part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class PostInitial extends PostState {
  Stream<List<Post>> posts;
  PostInitial({Stream<List<Post>> posts});

  @override
  List<Object> get props => [posts];
}

class PostAddedState extends PostState {
  final Stream<List<Post>> posts;
  const PostAddedState({this.posts});
  @override
  List<Object> get props => [posts];
}

class LoadingState extends PostState {
  const LoadingState();
  @override
  List<Object> get props => [];
}

class ErrorState extends PostState {
  final String error;
  const ErrorState({this.error});
  @override
  List<Object> get props => [error];
}
