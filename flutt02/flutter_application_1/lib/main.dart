import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0A7F3F),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF3F7F1),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Futbol Jokoa',
      theme: theme,
      home: const FootballQuizPage(),
    );
  }
}

enum GameStage {
  start,
  info,
  question,
  win,
}

class FootballQuizPage extends StatefulWidget {
  const FootballQuizPage({super.key});

  @override
  State<FootballQuizPage> createState() => _FootballQuizPageState();
}

class _FootballQuizPageState extends State<FootballQuizPage> {
  final Random _random = Random();
  final List<PlayerChallenge> _players = playerChallenges;

  late List<PlayerChallenge> _roundPlayers;
  GameStage _stage = GameStage.start;
  int _currentIndex = 0;
  int _correctStreak = 0;
  bool _mustRestart = false;

  @override
  void initState() {
    super.initState();
    _roundPlayers = List<PlayerChallenge>.from(_players);
  }

  PlayerChallenge get _currentPlayer => _roundPlayers[_currentIndex];

  void _startGame() {
    final shuffledPlayers = List<PlayerChallenge>.from(_players)
      ..shuffle(_random);

    setState(() {
      _roundPlayers = shuffledPlayers;
      _currentIndex = 0;
      _correctStreak = 0;
      _mustRestart = false;
      _stage = GameStage.info;
    });
  }

  void _goToQuestion() {
    if (_mustRestart) {
      _startGame();
      return;
    }

    setState(() {
      _stage = GameStage.question;
    });
  }

  void _answerQuestion(String answer) {
    final isCorrect = answer == _currentPlayer.correctAnswer;

    setState(() {
      if (!isCorrect) {
        _correctStreak = 0;
        _mustRestart = true;
        _stage = GameStage.info;
        return;
      }

      _correctStreak += 1;
      _mustRestart = false;

      if (_correctStreak >= 4) {
        _stage = GameStage.win;
        return;
      }

      _currentIndex = (_currentIndex + 1) % _roundPlayers.length;
      _stage = GameStage.info;
    });
  }

  @override
  Widget build(BuildContext context) {
    late final Widget body;

    switch (_stage) {
      case GameStage.start:
        body = StartView(onStart: _startGame);
        break;
      case GameStage.info:
        body = PlayerInfoView(
          player: _currentPlayer,
          playerNumber: _currentIndex + 1,
          streak: _correctStreak,
          mustRestart: _mustRestart,
          onContinue: _goToQuestion,
          onRestart: _startGame,
        );
        break;
      case GameStage.question:
        body = QuestionView(
          player: _currentPlayer,
          playerNumber: _currentIndex + 1,
          streak: _correctStreak,
          onAnswer: _answerQuestion,
        );
        break;
      case GameStage.win:
        body = WinView(
          streak: _correctStreak,
          onRestart: _startGame,
        );
        break;
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE7F4E7),
              Color(0xFFF7FAF4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: body,
          ),
        ),
      ),
    );
  }
}

class StartView extends StatelessWidget {
  const StartView({
    super.key,
    required this.onStart,
  });

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      key: const ValueKey('start-view'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.sports_soccer,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Futbol Jokalarien Jokoa',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF10331A),
                ),
          ),
          const SizedBox(height: 16),
          Text(
            '10 jokalariren informazioa irakurri, galderak erantzun eta '
            '4 erantzun jarraian ondo asmatu jokoa irabazteko.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  color: const Color(0xFF365242),
                ),
          ),
          const SizedBox(height: 28),
          ScorePanel(
            title: 'Jokoaren arauak',
            value: '4/4',
            detail: '4 asmatu jarraian irabazteko',
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onStart,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Jokoa hasi'),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerInfoView extends StatelessWidget {
  const PlayerInfoView({
    super.key,
    required this.player,
    required this.playerNumber,
    required this.streak,
    required this.mustRestart,
    required this.onContinue,
    required this.onRestart,
  });

  final PlayerChallenge player;
  final int playerNumber;
  final int streak;
  final bool mustRestart;
  final VoidCallback onContinue;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      key: ValueKey('info-${player.name}-$mustRestart-$streak'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderRow(
            title: mustRestart ? 'Huts egin duzu' : 'Jokalariaren fitxa',
            subtitle: mustRestart
                ? 'Galdera oker erantzun duzu. Orain jokoa berriz hasi behar duzu.'
                : 'Irakurri jokalariaren datuak eta prest zaudenean jarraitu.',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ScorePanel(
                  title: 'Jokalaria',
                  value: '$playerNumber/10',
                  detail: player.name,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ScorePanel(
                  title: 'Racha',
                  value: '$streak/4',
                  detail: 'Asmatutakoak jarraian',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlayerPortrait(player: player),
                  const SizedBox(height: 20),
                  Text(
                    player.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF13361E),
                        ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      InfoChip(label: player.position),
                      InfoChip(label: player.country),
                      InfoChip(label: player.signature),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    player.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: const Color(0xFF395245),
                        ),
                  ),
                  const SizedBox(height: 18),
                  ...player.facts.map(
                    (fact) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: FactRow(text: fact),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: mustRestart ? onRestart : onContinue,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Text(mustRestart ? 'Berriz hasi jokoa' : 'Jarraitu'),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
    required this.player,
    required this.playerNumber,
    required this.streak,
    required this.onAnswer,
  });

  final PlayerChallenge player;
  final int playerNumber;
  final int streak;
  final ValueChanged<String> onAnswer;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      key: ValueKey('question-${player.name}-$streak'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderRow(
            title: 'Galdera',
            subtitle: 'Irakurri duzun jokalariari buruzko galdera erantzun.',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ScorePanel(
                  title: 'Galdera',
                  value: '$playerNumber/10',
                  detail: player.name,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ScorePanel(
                  title: 'Racha',
                  value: '$streak/4',
                  detail: 'Helburua 4 asmatu',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          PlayerMiniBanner(player: player),
          const SizedBox(height: 20),
          Text(
            player.question,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF13361E),
                ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: player.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = player.options[index];
                return SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonal(
                    onPressed: () => onAnswer(option),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(option),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WinView extends StatelessWidget {
  const WinView({
    super.key,
    required this.streak,
    required this.onRestart,
  });

  final int streak;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      key: const ValueKey('win-view'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              color: Color(0xFF0A7F3F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              size: 54,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Irabazi duzu!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF12341D),
                ),
          ),
          const SizedBox(height: 16),
          Text(
            '$streak erantzun jarraian ondo asmatu dituzu. '
            'Prest bazaude, beste partida bat has dezakezu.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  color: const Color(0xFF365242),
                ),
          ),
          const SizedBox(height: 24),
          ScorePanel(
            title: 'Amaiera',
            value: '$streak/4',
            detail: 'Helburua beteta',
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onRestart,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text('Beste partida bat'),
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenFrame extends StatelessWidget {
  const ScreenFrame({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFFD5E7D8),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF13361E),
              ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: const Color(0xFF50685C),
              ),
        ),
      ],
    );
  }
}

class ScorePanel extends StatelessWidget {
  const ScorePanel({
    super.key,
    required this.title,
    required this.value,
    required this.detail,
  });

  final String title;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF557161),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0D632F),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF496255),
                ),
          ),
        ],
      ),
    );
  }
}

class PlayerPortrait extends StatelessWidget {
  const PlayerPortrait({
    super.key,
    required this.player,
  });

  final PlayerChallenge player;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0A7F3F),
            Color(0xFF1FA060),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            bottom: -18,
            child: Icon(
              Icons.sports_soccer,
              size: 130,
              color: Colors.white.withOpacity(0.14),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.16),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'Jokalariaren txartela',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          player.name,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${player.country} • ${player.position}',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withOpacity(0.92),
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      avatarUrlFor(player.name),
                      width: 140,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => FallbackPortrait(
                        initials: player.initials,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerMiniBanner extends StatelessWidget {
  const PlayerMiniBanner({
    super.key,
    required this.player,
  });

  final PlayerChallenge player;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF0A7F3F),
            child: Text(
              player.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              player.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF143720),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class FallbackPortrait extends StatelessWidget {
  const FallbackPortrait({
    super.key,
    required this.initials,
  });

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 180,
      color: const Color(0xFFD8EBDD),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0A7F3F),
          ),
        ),
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  const InfoChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8F0),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFF2C4D39),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class FactRow extends StatelessWidget {
  const FactRow({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 7),
          decoration: const BoxDecoration(
            color: Color(0xFF0A7F3F),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: const Color(0xFF3D5848),
                ),
          ),
        ),
      ],
    );
  }
}

class PlayerChallenge {
  const PlayerChallenge({
    required this.name,
    required this.country,
    required this.position,
    required this.signature,
    required this.description,
    required this.facts,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  final String name;
  final String country;
  final String position;
  final String signature;
  final String description;
  final List<String> facts;
  final String question;
  final List<String> options;
  final String correctAnswer;

  String get initials {
    final pieces = name.split(' ');
    if (pieces.length == 1) {
      return pieces.first.substring(0, min(2, pieces.first.length)).toUpperCase();
    }

    return '${pieces.first.substring(0, 1)}${pieces.last.substring(0, 1)}'
        .toUpperCase();
  }
}

String avatarUrlFor(String name) {
  final encodedName = Uri.encodeComponent(name);
  return 'https://ui-avatars.com/api/?name=$encodedName&size=512&background=0A7F3F&color=ffffff&bold=true';
}

const List<PlayerChallenge> playerChallenges = [
  PlayerChallenge(
    name: 'Lionel Messi',
    country: 'Argentina',
    position: 'Aurrelaria',
    signature: 'Dribbling aparta',
    description:
        'Lionel Messi futbolaren historian jokalari teknikoenetako bat da. '
        'Baloiaren kontrola, pase fina eta area inguruko erabaki azkarrak dira bere ezaugarri nagusiak.',
    facts: [
      'Rosarion jaio zen eta oso gaztetatik nabarmendu zen talentuagatik.',
      'Ezker hankarekin jokaldi ikusgarriak egiten ditu maiz.',
      'Argentinako selekzioarekin txapelketa handiak irabazi ditu.',
    ],
    question: 'Zein herrialdetako selekzioarekin izan da nazioarteko protagonista?',
    options: ['Portugal', 'Argentina', 'Brasil', 'Italia'],
    correctAnswer: 'Argentina',
  ),
  PlayerChallenge(
    name: 'Cristiano Ronaldo',
    country: 'Portugal',
    position: 'Aurrelari hegalekoa',
    signature: 'Erremate indartsua',
    description:
        'Cristiano Ronaldo goleatzaile handia da, aireko jokoan eta errematean oso indartsua. '
        'Bere diziplina fisikoa eta lehiakortasuna mundu osoan ezagunak dira.',
    facts: [
      'Madeiran jaio zen eta gaztetatik erakutsi zuen potentzia handia.',
      'Bi hankekin eta buruz arrisku handia sortzen du.',
      'Gol ugari sartu ditu klub eta selekzio mailan.',
    ],
    question: 'Zein herrialdetakoa da Cristiano Ronaldo?',
    options: ['Portugal', 'Espainia', 'Frantzia', 'Argentina'],
    correctAnswer: 'Portugal',
  ),
  PlayerChallenge(
    name: 'Luka Modric',
    country: 'Kroazia',
    position: 'Erdilaria',
    signature: 'Jokoaren erritmoa',
    description:
        'Luka Modric erdiko lerroko maisua da. Jokoaren tempoa kontrolatzen du, pase zehatzak ematen ditu '
        'eta taldearen oreka bilatzen du etengabe.',
    facts: [
      'Erdiko zelaian ikuspegi aparta du.',
      'Pase motzak eta luzeak zehaztasun handiz erabiltzen ditu.',
      'Bere selekzioarekin txapelketa handietan paper garrantzitsua izan du.',
    ],
    question: 'Zein postutan aritzen da normalean Luka Modric?',
    options: ['Atezaina', 'Erdilaria', 'Atzelaria', 'Aurrelaria'],
    correctAnswer: 'Erdilaria',
  ),
  PlayerChallenge(
    name: 'Andres Iniesta',
    country: 'Espainia',
    position: 'Erdilaria',
    signature: 'Pase fina',
    description:
        'Andres Iniesta espazio txikietan oso eraginkorra izan zen. Baloiaren kontrol lasaia eta '
        'une erabakigarrietan agertzeko gaitasuna zituen.',
    facts: [
      'Erdiko zelaian teknikoki oso garbia zen.',
      'Partida handietan jokaldi erabakigarriak utzi zituen.',
      'Talde-jokoan eta pasean aparteko ulermena zuen.',
    ],
    question: 'Zein selekziorekin lotzen da Andres Iniesta?',
    options: ['Portugal', 'Espainia', 'Argentina', 'Herbehereak'],
    correctAnswer: 'Espainia',
  ),
  PlayerChallenge(
    name: 'Erling Haaland',
    country: 'Norvegia',
    position: 'Aurrelaria',
    signature: 'Abiadura eta indarra',
    description:
        'Erling Haaland aurrelari indartsua da, espazioan korrika egiteko eta aukera gutxirekin gola egiteko '
        'gaitasun handia duena.',
    facts: [
      'Defentsaren bizkarrean arrisku handia sortzen du.',
      'Bere gorputz indarraz baliatzen da duelotan nagusitzeko.',
      'Area barruan oso errematatzaile fidagarria da.',
    ],
    question: 'Zein herrialdetakoa da Erling Haaland?',
    options: ['Danimarka', 'Suedia', 'Norvegia', 'Alemania'],
    correctAnswer: 'Norvegia',
  ),
  PlayerChallenge(
    name: 'Kylian Mbappe',
    country: 'Frantzia',
    position: 'Aurrelari hegalekoa',
    signature: 'Abiadura ikusgarria',
    description:
        'Kylian Mbappe oso jokalari azkarra da, metro gutxitan abiadura handia hartzen duena. '
        'Zelaian espazioa aurkitzen duenean oso arriskutsua bihurtzen da.',
    facts: [
      'Aurkariari bizkarra irabazteko gaitasun aparta du.',
      'Hegaletik zein erdian jokatu dezake.',
      'Trantsizio azkarretan bereziki nabarmentzen da.',
    ],
    question: 'Zein selekziotakoa da Kylian Mbappe?',
    options: ['Belgika', 'Frantzia', 'Brasil', 'Maroko'],
    correctAnswer: 'Frantzia',
  ),
  PlayerChallenge(
    name: 'Neymar Jr',
    country: 'Brasil',
    position: 'Aurrelari hegalekoa',
    signature: '1 kontra 1 bikaina',
    description:
        'Neymar Jr teknika, dribblinga eta sormena uztartzen dituen jokalaria da. '
        'Zelaiko azken herenean desoreka handia sor dezake.',
    facts: [
      'Baloiaren kontrol oso finarekin nabarmentzen da.',
      'Zaleek asko miresten dute bere irudimenagatik.',
      'Erasoan askatasunarekin jokatu ohi du.',
    ],
    question: 'Zein herrialdetako selekzioarekin jokatu du Neymarrek?',
    options: ['Argentina', 'Portugal', 'Brasil', 'Kolonbia'],
    correctAnswer: 'Brasil',
  ),
  PlayerChallenge(
    name: 'Alexia Putellas',
    country: 'Espainia',
    position: 'Erdilaria',
    signature: 'Lidergoa eta kalitatea',
    description:
        'Alexia Putellas erdiko zelaiko jokalari oso osatua da. Pasa, iritsi eta jokoa ulertzeko duen gaitasunagatik '
        'nabarmendu da urte luzez.',
    facts: [
      'Jokoaren antolaketan pisu handia du.',
      'Teknika eta irakurketa taktikoa uztartzen ditu.',
      'Erasoan zein sorkuntzan eragin handia izan dezake.',
    ],
    question: 'Zein herrialdetakoa da Alexia Putellas?',
    options: ['Espainia', 'Mexiko', 'Argentina', 'Txile'],
    correctAnswer: 'Espainia',
  ),
  PlayerChallenge(
    name: 'Aitana Bonmati',
    country: 'Espainia',
    position: 'Erdilaria',
    signature: 'Mugimendu adimentsuak',
    description:
        'Aitana Bonmati erdilaria da, baloirik gabe oso ondo mugitzen dena eta jokaldiak lotzeko gaitasun handia duena. '
        'Erritmo aldaketetan eta azken pasean ere nabarmendu ohi da.',
    facts: [
      'Zelaiko espazioak ondo interpretatzen ditu.',
      'Pase lerroak sortzen ditu etengabeko mugimenduarekin.',
      'Erdiko zelaian dinamismo handia ematen du.',
    ],
    question: 'Zein postutan aritzen da Aitana Bonmati?',
    options: ['Atezaina', 'Atzelaria', 'Erdilaria', 'Aurrelaria'],
    correctAnswer: 'Erdilaria',
  ),
  PlayerChallenge(
    name: 'Zinedine Zidane',
    country: 'Frantzia',
    position: 'Erdilaria',
    signature: 'Kontrola eta dotorezia',
    description:
        'Zinedine Zidane futbolaren historiako erdilaririk dotoreenetakoa izan zen. '
        'Lehen ukitua, gorputz orientazioa eta pasearen kalitatea ziren bere ezaugarri nagusiak.',
    facts: [
      'Baloiaren gaineko kontrol aparta zuen.',
      'Partida handietan erabakigarri agertzeko gaitasuna zuen.',
      'Bere joko estiloa lasaitasunarekin eta kalitatearekin lotzen da.',
    ],
    question: 'Zein herrialdetakoa da Zinedine Zidane?',
    options: ['Aljeria', 'Italia', 'Frantzia', 'Portugal'],
    correctAnswer: 'Frantzia',
  ),
];
