// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuizState {
  List<({String asset, String word})> get quizData =>
      throw _privateConstructorUsedError;
  int get currentWordIndex => throw _privateConstructorUsedError;
  int get currentCharacterIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuizStateCopyWith<QuizState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizStateCopyWith<$Res> {
  factory $QuizStateCopyWith(QuizState value, $Res Function(QuizState) then) =
      _$QuizStateCopyWithImpl<$Res, QuizState>;
  @useResult
  $Res call(
      {List<({String asset, String word})> quizData,
      int currentWordIndex,
      int currentCharacterIndex});
}

/// @nodoc
class _$QuizStateCopyWithImpl<$Res, $Val extends QuizState>
    implements $QuizStateCopyWith<$Res> {
  _$QuizStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizData = null,
    Object? currentWordIndex = null,
    Object? currentCharacterIndex = null,
  }) {
    return _then(_value.copyWith(
      quizData: null == quizData
          ? _value.quizData
          : quizData // ignore: cast_nullable_to_non_nullable
              as List<({String asset, String word})>,
      currentWordIndex: null == currentWordIndex
          ? _value.currentWordIndex
          : currentWordIndex // ignore: cast_nullable_to_non_nullable
              as int,
      currentCharacterIndex: null == currentCharacterIndex
          ? _value.currentCharacterIndex
          : currentCharacterIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizStateImplCopyWith<$Res>
    implements $QuizStateCopyWith<$Res> {
  factory _$$QuizStateImplCopyWith(
          _$QuizStateImpl value, $Res Function(_$QuizStateImpl) then) =
      __$$QuizStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<({String asset, String word})> quizData,
      int currentWordIndex,
      int currentCharacterIndex});
}

/// @nodoc
class __$$QuizStateImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$QuizStateImpl>
    implements _$$QuizStateImplCopyWith<$Res> {
  __$$QuizStateImplCopyWithImpl(
      _$QuizStateImpl _value, $Res Function(_$QuizStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizData = null,
    Object? currentWordIndex = null,
    Object? currentCharacterIndex = null,
  }) {
    return _then(_$QuizStateImpl(
      quizData: null == quizData
          ? _value._quizData
          : quizData // ignore: cast_nullable_to_non_nullable
              as List<({String asset, String word})>,
      currentWordIndex: null == currentWordIndex
          ? _value.currentWordIndex
          : currentWordIndex // ignore: cast_nullable_to_non_nullable
              as int,
      currentCharacterIndex: null == currentCharacterIndex
          ? _value.currentCharacterIndex
          : currentCharacterIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$QuizStateImpl extends _QuizState {
  const _$QuizStateImpl(
      {required final List<({String asset, String word})> quizData,
      required this.currentWordIndex,
      required this.currentCharacterIndex})
      : _quizData = quizData,
        super._();

  final List<({String asset, String word})> _quizData;
  @override
  List<({String asset, String word})> get quizData {
    if (_quizData is EqualUnmodifiableListView) return _quizData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quizData);
  }

  @override
  final int currentWordIndex;
  @override
  final int currentCharacterIndex;

  @override
  String toString() {
    return 'QuizState(quizData: $quizData, currentWordIndex: $currentWordIndex, currentCharacterIndex: $currentCharacterIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizStateImpl &&
            const DeepCollectionEquality().equals(other._quizData, _quizData) &&
            (identical(other.currentWordIndex, currentWordIndex) ||
                other.currentWordIndex == currentWordIndex) &&
            (identical(other.currentCharacterIndex, currentCharacterIndex) ||
                other.currentCharacterIndex == currentCharacterIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_quizData),
      currentWordIndex,
      currentCharacterIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizStateImplCopyWith<_$QuizStateImpl> get copyWith =>
      __$$QuizStateImplCopyWithImpl<_$QuizStateImpl>(this, _$identity);
}

abstract class _QuizState extends QuizState {
  const factory _QuizState(
      {required final List<({String asset, String word})> quizData,
      required final int currentWordIndex,
      required final int currentCharacterIndex}) = _$QuizStateImpl;
  const _QuizState._() : super._();

  @override
  List<({String asset, String word})> get quizData;
  @override
  int get currentWordIndex;
  @override
  int get currentCharacterIndex;
  @override
  @JsonKey(ignore: true)
  _$$QuizStateImplCopyWith<_$QuizStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
