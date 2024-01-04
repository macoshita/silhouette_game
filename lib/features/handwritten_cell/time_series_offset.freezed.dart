// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_series_offset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TimeSeriesOffset {
  double get dx => throw _privateConstructorUsedError;
  double get dy => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimeSeriesOffsetCopyWith<TimeSeriesOffset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeSeriesOffsetCopyWith<$Res> {
  factory $TimeSeriesOffsetCopyWith(
          TimeSeriesOffset value, $Res Function(TimeSeriesOffset) then) =
      _$TimeSeriesOffsetCopyWithImpl<$Res, TimeSeriesOffset>;
  @useResult
  $Res call({double dx, double dy, int time});
}

/// @nodoc
class _$TimeSeriesOffsetCopyWithImpl<$Res, $Val extends TimeSeriesOffset>
    implements $TimeSeriesOffsetCopyWith<$Res> {
  _$TimeSeriesOffsetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dx = null,
    Object? dy = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      dx: null == dx
          ? _value.dx
          : dx // ignore: cast_nullable_to_non_nullable
              as double,
      dy: null == dy
          ? _value.dy
          : dy // ignore: cast_nullable_to_non_nullable
              as double,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeSeriesOffsetImplCopyWith<$Res>
    implements $TimeSeriesOffsetCopyWith<$Res> {
  factory _$$TimeSeriesOffsetImplCopyWith(_$TimeSeriesOffsetImpl value,
          $Res Function(_$TimeSeriesOffsetImpl) then) =
      __$$TimeSeriesOffsetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double dx, double dy, int time});
}

/// @nodoc
class __$$TimeSeriesOffsetImplCopyWithImpl<$Res>
    extends _$TimeSeriesOffsetCopyWithImpl<$Res, _$TimeSeriesOffsetImpl>
    implements _$$TimeSeriesOffsetImplCopyWith<$Res> {
  __$$TimeSeriesOffsetImplCopyWithImpl(_$TimeSeriesOffsetImpl _value,
      $Res Function(_$TimeSeriesOffsetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dx = null,
    Object? dy = null,
    Object? time = null,
  }) {
    return _then(_$TimeSeriesOffsetImpl(
      null == dx
          ? _value.dx
          : dx // ignore: cast_nullable_to_non_nullable
              as double,
      null == dy
          ? _value.dy
          : dy // ignore: cast_nullable_to_non_nullable
              as double,
      null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TimeSeriesOffsetImpl extends _TimeSeriesOffset {
  const _$TimeSeriesOffsetImpl(this.dx, this.dy, this.time) : super._();

  @override
  final double dx;
  @override
  final double dy;
  @override
  final int time;

  @override
  String toString() {
    return 'TimeSeriesOffset(dx: $dx, dy: $dy, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeSeriesOffsetImpl &&
            (identical(other.dx, dx) || other.dx == dx) &&
            (identical(other.dy, dy) || other.dy == dy) &&
            (identical(other.time, time) || other.time == time));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dx, dy, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeSeriesOffsetImplCopyWith<_$TimeSeriesOffsetImpl> get copyWith =>
      __$$TimeSeriesOffsetImplCopyWithImpl<_$TimeSeriesOffsetImpl>(
          this, _$identity);
}

abstract class _TimeSeriesOffset extends TimeSeriesOffset {
  const factory _TimeSeriesOffset(
          final double dx, final double dy, final int time) =
      _$TimeSeriesOffsetImpl;
  const _TimeSeriesOffset._() : super._();

  @override
  double get dx;
  @override
  double get dy;
  @override
  int get time;
  @override
  @JsonKey(ignore: true)
  _$$TimeSeriesOffsetImplCopyWith<_$TimeSeriesOffsetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
