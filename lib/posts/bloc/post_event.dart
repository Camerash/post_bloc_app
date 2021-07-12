part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {}

class PostEventFetch extends PostEvent {
  @override
  List<Object> get props => [];
}
