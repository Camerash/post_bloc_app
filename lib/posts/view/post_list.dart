import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_bloc_app/posts/posts.dart';
import 'package:post_repository/post_repository.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final ScrollController _scrollController = ScrollController();
  late PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<PostBloc>();
  }

  void _onScroll() {
    if (_isAtBottom()) _postBloc.add(PostEventFetch());
  }

  bool _isAtBottom() {
    if (!_scrollController.hasClients) return false;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollExtent = _scrollController.offset;
    return currentScrollExtent >= (maxScrollExtent * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
              child: Text("Failed to fetch posts"),
            );
          case PostStatus.success:
            return state.posts.isEmpty
                ? Center(
                    child: Text('No Posts'),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax
                        ? state.posts.length
                        : state.posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.posts.length) {
                        // bottom progress item
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return PostListTile(post: state.posts[index]);
                      }
                    },
                  );
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class PostListTile extends StatelessWidget {
  const PostListTile({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Text(post.id.toString()),
        title: Text(post.title),
        subtitle: Text(post.body),
      ),
    );
  }
}
