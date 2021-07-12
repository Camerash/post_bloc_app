import 'package:post_bloc_app/posts/bloc/post_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('PostState', () {
    test('copyWith copies states correctly', () {
      final postState = PostState();
      expect(
        postState.copyWith(hasReachedMax: true),
        PostState(hasReachedMax: true)
      );
    });
  });
}