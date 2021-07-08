import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_bloc_app/bloc/post_cubit.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ScrollController _scrollController = ScrollController();
  late PostCubit _postCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postCubit = context.read<PostCubit>();
    _postCubit.fetchPost(); // Initial trigger
  }

  void _onScroll() {
    if (_isAtBottom()) _postCubit.fetchPost();
  }

  bool _isAtBottom() {
    if (!_scrollController.hasClients) return false;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollExtent = _scrollController.offset;
    return currentScrollExtent >= (maxScrollExtent * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
              child: Text("Failed to fetch posts"),
            );
          case PostStatus.loading:
            if (state.posts.isEmpty) continue empty_loading;
            continue list;
          list:
          case PostStatus.success:
            return ListView.builder(
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
                  final post = state.posts[index];
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: Text(post.id.toString()),
                      title: Text(post.title),
                      subtitle: Text(post.body),
                    ),
                  );
                }
              },
            );
          empty_loading:
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
