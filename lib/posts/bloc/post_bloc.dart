import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:post_repository/post_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'post_state.dart';
part 'post_event.dart';

const post_limit = 20;

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._postRepository) : super(PostState());

  final PostRepository _postRepository;

  /// Debounce consecutive fetch requests
  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
      Stream<PostEvent> events,
      TransitionFunction<PostEvent, PostState> transitionFn) {
    return super.transformEvents(
      events.throttleTime(Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostEventFetch) {
      yield await _fetchPost();
    }
  }

  Future<PostState> _fetchPost() async {
    if (state.hasReachedMax) return state;

    // Fetch post from repository
    try {
      List<Post> posts =
          await _postRepository.getPosts(state.posts.length, post_limit);
      return state.copyWith(
        status: PostStatus.success,
        posts: List.of(state.posts)..addAll(posts),
        hasReachedMax: posts.isEmpty,
      );
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }
}
