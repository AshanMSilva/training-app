import 'package:equatable/equatable.dart';

class DiaryEntity extends Equatable {
  final String title;
  final String subTitle;
  final String description;

  const DiaryEntity({this.title, this.subTitle, this.description});

  Map<String, Object> toJson() {
    return {"title": title, "subTitle": subTitle, "description": description};
  }

  @override
  List<Object> get props => [title, subTitle, description];

  @override
  String toString() {
    return 'DiaryEntity { title: $title, subTitle: $subTitle, description: $description}';
  }

  static DiaryEntity fromJson(Map<String, Object> json) {
    return DiaryEntity(
      title: json["title"] as String,
      subTitle: json["subTitle"] as String,
      description: json["description"] as String,
    );
  }
}
