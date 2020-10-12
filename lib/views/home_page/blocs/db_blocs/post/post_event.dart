import 'package:flutter/material.dart';
import 'package:training_app/db/models/models.dart';

@immutable
abstract class PostEvent {}

class ErrorEvent extends PostEvent {
  final String error;

  ErrorEvent(this.error);
}

class AddNewPostEvent extends PostEvent {
  final Post post;
  AddNewPostEvent({
    this.post,
  });
}

class StremPostsEvent extends PostEvent {
  final List<Post> posts;
  StremPostsEvent({
    this.posts,
  });
}
