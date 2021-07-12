import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:post_bloc_app/l10n/gen/app_localizations.dart';
import 'package:post_bloc_app/posts/posts.dart';
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
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.blueGrey,
        ),
        home: PostPage(),
      ),
    );
  }
}
