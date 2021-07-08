import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_bloc_app/bloc/post_cubit.dart';
import 'package:post_bloc_app/pages/post_list.dart';
import 'package:post_repository/post_repository.dart';

class PostApp extends StatelessWidget {
  const PostApp({Key? key, required PostRepository postRepository})
      : _postRepository = postRepository,
        super(key: key);

  final PostRepository _postRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _postRepository,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Infinite List'),
          ),
          body: BlocProvider(
            create: (context) => PostCubit(context.read<PostRepository>()),
            child: PostListPage(),
          ),
        ),
      ),
    );
  }
}
