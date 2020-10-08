import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Post {
  final String title;
  final String user;
  final String description;
  final Timestamp created;

  Post({this.title, this.user, this.description, this.created});

  Post copyWith(
      {String title, String user, String description, Timestamp created}) {
    return Post(
      title: title ?? this.title,
      user: user ?? this.user,
      description: description ?? this.description,
      created: created ?? this.created,
    );
  }

  @override
  int get hashCode =>
      title.hashCode ^ user.hashCode ^ description.hashCode ^ created.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          user == other.user &&
          description == other.description &&
          created == other.created;

  @override
  String toString() {
    return 'Post { title: $title, user: $user, description: $description, created: $created}';
  }

  PostEntity toEntity() {
    return PostEntity(
        title: title, user: user, description: description, created: created);
  }

  static Post fromEntity(PostEntity entity) {
    return Post(
        title: entity.title,
        description: entity.description,
        user: entity.user,
        created: entity.created);
  }
}
