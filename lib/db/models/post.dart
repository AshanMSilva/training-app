import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:meta/meta.dart';

class Post extends DBModel {
  static const DESCRIPTION_FIELD = 'description';
  static const TITLE_FIELD = 'title';
  static const USER_FIELD = 'user';
  static const CREATED_FIELD = 'created';

  String title;
  String description;
  // DocumentReference user;
  String user;
  Timestamp created;

  Post({
    @required DocumentReference ref,
    @required this.title,
    @required this.description,
    @required this.user,
    @required this.created,
  }) : super(ref: ref);
}
