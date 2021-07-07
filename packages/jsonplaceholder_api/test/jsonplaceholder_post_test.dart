import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:test/test.dart';

void main() {
  group('JsonPlaceholderPost', () {
    group('fromJson', () {
      test('Correct parsing of JsonPlaceholderPost from json', () {
        JsonPlaceholderPost post = JsonPlaceholderPost.fromJson(
            {
              'id': 100,
              'title': 'test title',
              'body': 'test body',
            }
        );

        expect(post.id, 100);
        expect(post.title, 'test title');
        expect(post.body, 'test body');
      });
    });
  });
}