import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsonplaceholder_api/src/models/jsonplaceholder_post.dart';

/// Exception thrown when getPosts fails.
class PostRequestFailure implements Exception {}

/// {@template jsonplaceholder_post_api_clients}
/// Dart API Client which wraps the [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts/)
/// {@endtemplate}
class JsonPlaceholderApiClient {
  JsonPlaceholderApiClient({http.Client? client})
      : _client = client ?? http.Client();

  static const _baseUrl = "jsonplaceholder.typicode.com";
  final http.Client _client;

  Future<List<JsonPlaceholderPost>> getPosts(int start, int limit) async {
    final postsRequest = Uri.https(_baseUrl, "/posts", {"start": start.toString(), "limit": limit.toString()});
    final postsResponse = await _client.get(postsRequest);

    if (postsResponse.statusCode != 200) {
      throw PostRequestFailure();
    }

    // Decode Json from string and generate list of objects
    return (jsonDecode(postsResponse.body) as List).map((e) => JsonPlaceholderPost.fromJson(e)).toList();
  }
}
