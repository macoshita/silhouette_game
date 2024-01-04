import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

final _quizPath = RegExp(r'assets/quiz/([^/]+).png');

@Riverpod(keepAlive: true)
Future<List<String>> quizList(QuizListRef ref) async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final qs = assetManifest
      .listAssets()
      .map((p) => _quizPath.firstMatch(p)?.group(1))
      .whereType<String>()
      .toList()
    ..shuffle();
  return qs.sublist(0, 5);
}

@freezed
class QuizState with _$QuizState {
  const QuizState._();
  const factory QuizState({
    required List<String> words,
    required int currentWordIndex,
    required int currentCharacterIndex,
  }) = _QuizState;

  String get currentWord => words[currentWordIndex];
  String get currentCharacter => currentWord[currentCharacterIndex];
  String get currentWordImage => 'assets/quiz/$currentWord.png';
}

@Riverpod(keepAlive: true)
class Quiz extends _$Quiz {
  @override
  FutureOr<QuizState> build() async {
    return QuizState(
      words: await ref.watch(quizListProvider.future),
      currentWordIndex: 0,
      currentCharacterIndex: 0,
    );
  }

  bool nextCharacter() {
    final value = state.requireValue;
    if (value.currentCharacterIndex < value.currentWord.length - 1) {
      state = AsyncData(value.copyWith(
        currentCharacterIndex: value.currentCharacterIndex + 1,
      ));
      return true;
    }
    return false;
  }

  bool nextWord() {
    final value = state.requireValue;
    if (value.currentWordIndex < value.words.length - 1) {
      state = AsyncData(value.copyWith(
        currentWordIndex: value.currentWordIndex + 1,
        currentCharacterIndex: 0,
      ));
      return true;
    }
    return false;
  }
}
