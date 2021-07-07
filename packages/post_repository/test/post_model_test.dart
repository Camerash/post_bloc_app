import 'package:post_repository/models/post.dart';
import 'package:test/test.dart';

void main() {
  group('postModel', () {
    group('equatable', () {
      test('posts with different id is different', () {
        final idA = 100;
        final idB = 101;
        final title = 'test title';
        final body = 'test body';

        final postA = Post(id: idA, title: title, body: body);
        final postB = Post(id: idB, title: title, body: body);
        expect(postA, isNot(postB));
      });
    });
  });
}
