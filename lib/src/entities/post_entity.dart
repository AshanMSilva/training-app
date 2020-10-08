import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String title;
  final String user;
  final String description;
  final Timestamp created;

  const PostEntity({this.title, this.user, this.description, this.created});

  Map<String, Object> toJson() {
    return {
      "title": title,
      "user": user,
      "description": description,
      "created": created
    };
  }

  @override
  List<Object> get props => [title, user, description, created];

  @override
  String toString() {
    return 'PostEntity { title: $title, user: $user, description: $description, created: $created}';
  }

  static PostEntity fromJson(Map<String, Object> json) {
    return PostEntity(
        title: json["title"] as String,
        user: json["user"] as String,
        description: json["description"] as String,
        created: json["created"] as Timestamp);
  }

  static PostEntity fromSnapshot(DocumentSnapshot snap) {
    return PostEntity(
      title: snap.get('title'),
      user: snap.get('user'),
      description: snap.get('description'),
      created: snap.get('created'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "title": title,
      "user": user,
      "description": description,
      "created": created
    };
  }
}
