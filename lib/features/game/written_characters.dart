import 'package:hiragana_game/features/game/time_series_offset.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
