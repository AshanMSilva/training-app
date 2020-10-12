import 'package:flutter/material.dart';
import 'package:training_app/db/models/models.dart';

@immutable
class PostState {
  final String error;
  final List<Post> posts;

  PostState({
    @required this.error,
    @required this.posts,
  });

  static PostState get initialState => PostState(
        error: '',
        posts: null,
      );

  PostState clone({
    String error,
    List<Post> posts,
  }) {
    return PostState(
      error: error ?? this.error,
      posts: posts ?? this.posts,
    );
  }
}
