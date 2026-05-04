import 'dart:math';
import 'package:flutter/material.dart';

import 'ereduak/jokalari_erronka.dart';
import 'datuak/jokalari_datuak.dart';
import 'widgetak/pantailak.dart';

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
  final List<JokalariErronka> _players = jokalariErronkak;

  late List<JokalariErronka> _roundPlayers;
  GameStage _stage = GameStage.start;
  int _currentIndex = 0;
  int _correctStreak = 0;
  bool _mustRestart = false;

  @override
  void initState() {
    super.initState();
    _roundPlayers = List<JokalariErronka>.from(_players);
  }

  JokalariErronka get _currentPlayer => _roundPlayers[_currentIndex];

  void _startGame() {
    final shuffledPlayers = List<JokalariErronka>.from(_players)
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
    final isCorrect = answer == _currentPlayer.erantzunZuzena;

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
