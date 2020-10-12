import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:training_app/db/repositories/post_repository.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  static final log = Log("PostBloc");
  final postRepository = PostRepository();

  StreamSubscription postSubscription;

  PostBloc(BuildContext context) : super(PostState.initialState) {
    postSubscription = postRepository
        .query(
          specification: ComplexSpecification([]),
        )
        .listen((posts) => add(StremPostsEvent(posts: posts)));
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;
      case AddNewPostEvent:
        print('AddNewPostEvent occured ......................................');
        final post = (event as AddNewPostEvent).post;
        await postRepository.add(item: post);
        break;

      case StremPostsEvent:
        print('StremPostsEvent occured ......................................');
        final posts = (event as StremPostsEvent).posts;
        posts.sort((a, b) => b.created.compareTo(a.created));
        yield state.clone(
          posts: posts,
        );
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    log.e('$stacktrace');
    log.e('$error');
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    await postSubscription?.cancel();
    await super.close();
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      add(ErrorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}
