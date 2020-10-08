import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_app/post_repository.dart';

import 'package:training_app/src/models/models.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;
  PostBloc({PostRepository postRepository})
      : assert(postRepository != null),
        _postRepository = postRepository,
        super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is AddPostEvent) {
      try {
        yield LoadingState();
        await _postRepository.addNewPost(event.post);
        Stream<List<Post>> posts = _postRepository.getPosts();
        yield PostAddedState(posts: posts);
      } catch (e) {
        yield ErrorState(error: e);
      }
    } else if (event is InitialEvent) {
      try {
        yield LoadingState();
        Stream<List<Post>> posts = _postRepository.getPosts();
        yield PostAddedState(posts: posts);
      } catch (e) {
        yield ErrorState(error: e);
      }
    }
  }
}
