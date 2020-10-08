import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/post_repository.dart';
import 'package:training_app/src/models/models.dart';

import 'entities/entities.dart';

class FirebasePostRepository implements PostRepository {
  final postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> addNewPost(Post post) {
    return postCollection.add(post.toEntity().toDocument());
  }

  @override
  Stream<List<Post>> getPosts() {
    return postCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromEntity(PostEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
