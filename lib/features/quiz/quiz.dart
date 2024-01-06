import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silhouette_game/features/game_mode/game_mode.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

final _quizPath = RegExp(r'assets/quiz/([^/]+).png');

typedef QuizData = ({String word, String asset});

@Riverpod(keepAlive: true)
Future<List<QuizData>> quizList(QuizListRef ref) async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final qs = assetManifest
      .listAssets()
      .where((p) => _quizPath.hasMatch(p))
      .toList()
    ..shuffle();

  final gameMode = ref.watch(gameModeProvider);
  return qs.sublist(0, 5).map((p) {
    var word = _quizPath.firstMatch(p)!.group(1)!;
    if (gameMode == GameMode.katakana) {
      word = _hiraganaToKatakana(word);
    }
    return (word: word, asset: p);
  }).toList();
}

String _hiraganaToKatakana(val) {
  return val.replaceAllMapped(RegExp("[ぁ-ゔ]"),
      (Match m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) + 0x60));
}

@freezed
class QuizState with _$QuizState {
  const QuizState._();
  const factory QuizState({
    required List<QuizData> quizData,
    required int currentWordIndex,
    required int currentCharacterIndex,
  }) = _QuizState;

  QuizData get currentQuiz => quizData[currentWordIndex];
  String get currentCharacter => currentQuiz.word[currentCharacterIndex];
}

@Riverpod(keepAlive: true)
class Quiz extends _$Quiz {
  @override
  FutureOr<QuizState> build() async {
    return QuizState(
      quizData: await ref.watch(quizListProvider.future),
      currentWordIndex: 0,
      currentCharacterIndex: 0,
    );
  }

  bool nextCharacter() {
    final value = state.requireValue;
    if (value.currentCharacterIndex < value.currentQuiz.word.length - 1) {
      state = AsyncData(value.copyWith(
        currentCharacterIndex: value.currentCharacterIndex + 1,
      ));
      return true;
    }
    return false;
  }

  bool nextWord() {
    final value = state.requireValue;
    if (value.currentWordIndex < value.quizData.length - 1) {
      state = AsyncData(value.copyWith(
        currentWordIndex: value.currentWordIndex + 1,
        currentCharacterIndex: 0,
      ));
      return true;
    }
    return false;
  }
}
