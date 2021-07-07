import 'package:flutter/material.dart';
import 'package:post_bloc_app/pages/post_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PostListPage(),
    );
  }
}
