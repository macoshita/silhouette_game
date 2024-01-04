// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizListHash() => r'bd7aa7abdab58dbab7809a64eac11979e42c6e78';

/// See also [quizList].
@ProviderFor(quizList)
final quizListProvider = FutureProvider<List<String>>.internal(
  quizList,
  name: r'quizListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QuizListRef = FutureProviderRef<List<String>>;
String _$quizHash() => r'f75bab7b15ada838f167fb528c77fac9e65856f1';

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
