import 'package:jsonplaceholder_api/jsonplaceholder_api.dart';
import 'package:post_repository/src/models/post.dart';

class PostRepository {
  final JsonPlaceholderApiClient _client;

  PostRepository({JsonPlaceholderApiClient? client})
      : _client = client ?? JsonPlaceholderApiClient();

  Future<List<Post>> getPosts(int start, int limit) async {
    final posts = await _client.getPosts(start, limit);
    return posts
        .map((e) => Post(id: e.id, title: e.title, body: e.body))
        .toList();
  }
}
