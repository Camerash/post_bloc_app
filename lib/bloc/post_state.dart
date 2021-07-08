part of 'post_cubit.dart';

enum PostStatus { initial, loading, success, failure }

@JsonSerializable()
class PostState extends Equatable {
  PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) => PostState(
    status: status ?? this.status,
    posts: posts ?? this.posts,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax
  );

  @override
  String toString() => 'PostState { status: $status, posts: ${posts.length}, hasReachedMax: $hasReachedMax }';

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
