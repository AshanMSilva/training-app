import 'package:training_app/src/models/models.dart';

abstract class PostRepository {
  Future<void> addNewPost(Post post);

  Stream<List<Post>> getPosts();
}
