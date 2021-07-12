import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_bloc_app/l10n/gen/app_localizations.dart';
import 'package:post_bloc_app/posts/posts.dart';
import 'package:post_repository/post_repository.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.postListTitle),
      ),
      body: BlocProvider(
        create: (context) =>
            PostBloc(context.read<PostRepository>())..add(PostEventFetch()),
        child: PostList(),
      ),
    );
  }
}
