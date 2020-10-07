import 'package:training_app/src/entities/diary_entity.dart';

class DiaryRepository {
  final List<DiaryEntity> diaries = <DiaryEntity>[];
  addNewDiary(DiaryEntity diary) {
    diaries.add(diary);
  }

  List<DiaryEntity> getDiaries() {
    return diaries;
  }
}
