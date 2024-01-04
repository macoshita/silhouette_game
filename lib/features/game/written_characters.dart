import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:silhouette_game/features/handwritten_cell/time_series_offset.dart';

part 'written_characters.g.dart';

@riverpod
class WrittenCharacters extends _$WrittenCharacters {
  @override
  List<Character> build() => [[]];

  void write(Character character) {
    state = [...state.sublist(0, state.length - 1), character];
  }

  void next() {
    state = [...state, []];
  }
}
