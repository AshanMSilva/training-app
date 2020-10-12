import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:training_app/db/models/post.dart';
import 'package:training_app/util/db_util.dart';

class PostRepository extends FirebaseRepository<Post> {
  @override
  Post fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return Post(
      ref: snapshot.reference,
      title: data[Post.TITLE_FIELD],
      description: data[Post.DESCRIPTION_FIELD],
      user: data[Post.USER_FIELD],
      created: data[Post.CREATED_FIELD],
    );
  }

  @override
  Map<String, dynamic> toMap(Post post) {
    return {
      Post.TITLE_FIELD: post.title,
      Post.DESCRIPTION_FIELD: post.description,
      Post.USER_FIELD: post.user,
      Post.CREATED_FIELD: post.created,
    };
  }

  @override
  Stream<List<Post>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.POSTS,
      parent: null,
    );
  }

  @override
  Future<DocumentReference> add({
    Post item,
    String type,
    DocumentReference parent,
  }) {
    return super.add(item: item, type: DBUtil.POSTS, parent: null);
  }
}
