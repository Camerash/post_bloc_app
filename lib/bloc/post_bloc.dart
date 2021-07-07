import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(PostState initialState) : super(initialState);

  @override
  Stream<PostState> mapEventToState(PostEvent event) {

  }
}