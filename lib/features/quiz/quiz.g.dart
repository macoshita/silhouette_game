// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizListHash() => r'c6f92d84fde84e2d68e5520dfe3a1516dab6f044';

/// See also [quizList].
@ProviderFor(quizList)
final quizListProvider = FutureProvider<List<QuizData>>.internal(
  quizList,
  name: r'quizListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QuizListRef = FutureProviderRef<List<QuizData>>;
String _$quizHash() => r'29d73c5df0af1099406cf3a9e1b01853fd8230e1';

/// See also [Quiz].
@ProviderFor(Quiz)
final quizProvider = AsyncNotifierProvider<Quiz, QuizState>.internal(
  Quiz.new,
  name: r'quizProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Quiz = AsyncNotifier<QuizState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
