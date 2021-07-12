import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:post_bloc_app/posts/posts.dart';
import 'package:post_repository/post_repository.dart';

class FakePostEvent extends Fake implements PostEvent {}

class FakePostState extends Fake implements PostState {}

class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}

extension on WidgetTester {
  Future<void> pumpPostList(PostBloc postBloc) {
    return pumpWidget(
      MaterialApp(
        home: Material(
          child: BlocProvider.value(
            value: postBloc,
            child: PostList(),
          ),
        ),
      ),
    );
  }
}

void main() {
  late PostBloc postBloc;
  final mockPosts = List.generate(
    5,
    (i) => Post(id: i, title: 'title', body: 'body'),
  );

  setUpAll(() {
    registerFallbackValue<PostEvent>(FakePostEvent());
    registerFallbackValue<PostState>(FakePostState());
  });

  setUp(() {
    postBloc = MockPostBloc();
  });

  group('PostList', () {
    testWidgets(
        'renders CircularProgressBar '
        'when status in PostState is initial', (tester) async {
      when(() => postBloc.state).thenReturn(PostState());
      await tester.pumpPostList(postBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders no post '
        'when status in PostState is success '
        'but no posts are returned', (tester) async {
      when(() => postBloc.state).thenReturn(PostState(
        status: PostStatus.success,
        posts: [],
        hasReachedMax: true,
      ));
      await tester.pumpPostList(postBloc);
      expect(find.text('No Posts'), findsOneWidget);
    });

    testWidgets(
        'renders 5 post and a bottom loader '
        'when post max is not reached yet', (tester) async {
      when(() => postBloc.state).thenReturn(PostState(
        status: PostStatus.success,
        posts: mockPosts,
        hasReachedMax: false,
      ));
      await tester.pumpPostList(postBloc);
      expect(find.byType(PostListTile), findsNWidgets(5));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'does not render bottom loader '
        'when post max has been reached', (tester) async {
      when(() => postBloc.state).thenReturn(PostState(
        status: PostStatus.success,
        posts: mockPosts,
        hasReachedMax: true,
      ));
      await tester.pumpPostList(postBloc);
      expect(find.byType(PostListTile), findsNWidgets(5));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('fetch more post when list reached bottom', (tester) async {
      when(() => postBloc.state).thenReturn(PostState(
        status: PostStatus.success,
        posts: List.generate(
          10,
          (i) => Post(
            id: i,
            title: 'title',
            body: 'body',
          ),
        ),
        hasReachedMax: false,
      ));
      await tester.pumpPostList(postBloc);
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        find.byType(CircularProgressIndicator),
        find.byType(PostList),
        Offset(0, -100),
      );
      verify(() => postBloc.add(PostEventFetch())).called(1);
    });
  });
}
