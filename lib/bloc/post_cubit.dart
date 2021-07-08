import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:post_repository/post_repository.dart';

part 'post_state.dart';

const post_limit = 20;

class PostCubit extends Cubit<PostState> {
  PostCubit(this._postRepository) : super(PostState());

  final PostRepository _postRepository;

  void fetchPost() async {
    if (state.status == PostStatus.loading || state.hasReachedMax) return emit(state);

    emit (state.copyWith(status: PostStatus.loading));

    // Fetch post from repository
    try {
      List<Post> posts = await _postRepository.getPosts(state.posts.length, post_limit);
      emit(state.copyWith(
        status: PostStatus.success,
        posts: List.of(state.posts)..addAll(posts),
        hasReachedMax: posts.isEmpty,
      ));
    } on Exception {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
