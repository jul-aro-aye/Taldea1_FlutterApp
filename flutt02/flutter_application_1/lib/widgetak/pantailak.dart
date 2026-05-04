import 'package:flutter/material.dart';
import '../ereduak/jokalari_erronka.dart';
import 'osagaiak.dart';

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
          const ScorePanel(
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

  final JokalariErronka player;
  final int playerNumber;
  final int streak;
  final bool mustRestart;
  final VoidCallback onContinue;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      key: ValueKey('info-${player.izena}-$mustRestart-$streak'),
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
                  detail: player.izena,
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
                    player.izena,
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
                      InfoChip(label: player.posizioa),
                      InfoChip(label: player.herrialdea),
                      InfoChip(label: player.ezaugarria),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    player.deskribapena,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: const Color(0xFF395245),
                        ),
                  ),
                  const SizedBox(height: 18),
                  ...player.datuak.map(
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

  final JokalariErronka player;
  final int playerNumber;
  final int streak;
  final ValueChanged<String> onAnswer;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      key: ValueKey('question-${player.izena}-$streak'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderRow(
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
                  detail: player.izena,
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
            player.galdera,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF13361E),
                ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: player.aukerak.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = player.aukerak[index];
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
