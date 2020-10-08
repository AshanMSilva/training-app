part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends PostEvent {
  const InitialEvent();
  @override
  List<Object> get props => [];
}

class AddPostEvent extends PostEvent {
  final Post post;

  const AddPostEvent({
    this.post,
  });
  @override
  List<Object> get props => [post];
}
