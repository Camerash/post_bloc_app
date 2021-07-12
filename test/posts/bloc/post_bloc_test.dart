import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:post_bloc_app/posts/bloc/post_bloc.dart';
import 'package:post_repository/post_repository.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  group('PostBloc', () {
    late MockPostRepository postRepository;
    late PostBloc postBloc;

    setUp(() {
      postRepository = MockPostRepository();
      postBloc = PostBloc(postRepository);
    });

    test('correct initial test', () {
      expect(postBloc.state, PostState());
    });

    blocTest<PostBloc, PostState>(
      'no states are emitted when hasReachedMax is true',
      build: () => postBloc,
      seed: () => PostState(hasReachedMax: true),
      act: (bloc) => bloc.add(PostEventFetch()),
      expect: () => [],
    );

    blocTest<PostBloc, PostState>(
      'return success state when fetch succeed',
      build: () => postBloc,
      act: (bloc) {
        when(() => postRepository.getPosts(any(), any())).thenAnswer(
            (_) async => [Post(id: 1, title: 'title', body: 'body')]);
        bloc.add(PostEventFetch());
      },
      expect: () => [
        PostState(
          status: PostStatus.success,
          posts: [Post(id: 1, title: 'title', body: 'body')],
          hasReachedMax: false,
        ),
      ],
    );

    blocTest<PostBloc, PostState>(
      'return failure state when fetch fails',
      build: () => postBloc,
      act: (bloc) {
        when(() => postRepository.getPosts(any(), any())).thenThrow(Exception('Fetch error'));
        bloc.add(PostEventFetch());
      },
      expect: () => [
        PostState(
          status: PostStatus.failure,
          posts: [],
          hasReachedMax: false,
        ),
      ],
    );
  });
}
