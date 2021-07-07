import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:post_repository/post_repository.dart';
import 'package:test/test.dart';

class MockJsonPlaceholderApiClient extends Mock implements JsonPlaceholderApiClient {}
class MockJsonPlaceholderPost extends Mock implements JsonPlaceholderPost {}

void main() {
  group('postRepository', () {
    late JsonPlaceholderApiClient jsonPlaceholderApiClient;
    late PostRepository repository;

    setUp(() {
      jsonPlaceholderApiClient = MockJsonPlaceholderApiClient();
      repository = PostRepository(client: jsonPlaceholderApiClient);
    });

    group('constructor', () {
      test('does not require JsonPlaceholderApiClient', () {
        expect(PostRepository(), isNotNull);
      });
    });

    group('getPosts', () {
      test('get posts correctly', () async {
        // Mock response
        final jsonPost = MockJsonPlaceholderPost();
        when(() => jsonPost.id).thenReturn(1);
        when(() => jsonPost.body).thenReturn('test body');
        when(() => jsonPost.title).thenReturn('test title');
        when(() => jsonPlaceholderApiClient.getPosts(any(), any())).thenAnswer((_) async => [jsonPost]);

        final posts = await repository.getPosts(1, 1);
        expect(posts, hasLength(1));
        expect(posts[0].id, 1);
        expect(posts[0].body, 'test body');
        expect(posts[0].title, 'test title');
      });
    });
  });
}