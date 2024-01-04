import 'dart:ui';

import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_series_offset.freezed.dart';

typedef Stroke = List<TimeSeriesOffset>;
typedef Character = List<Stroke>;

@freezed
class TimeSeriesOffset with _$TimeSeriesOffset {
  const TimeSeriesOffset._();
  const factory TimeSeriesOffset(
    double dx,
    double dy,
    int time,
  ) = _TimeSeriesOffset;

  factory TimeSeriesOffset.fromOffset(Offset offset) => TimeSeriesOffset(
        offset.dx,
        offset.dy,
        clock.now().millisecondsSinceEpoch,
      );

  Offset toOffset() => Offset(dx, dy);
}
