part of 'diary_bloc.dart';

abstract class DiaryState extends Equatable {
  const DiaryState();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class DiaryInitial extends DiaryState {
  List<DiaryEntity> diaries;
  DiaryInitial({List<DiaryEntity> diaries}) {
    if (diaries == null) {
      this.diaries = <DiaryEntity>[];
    } else {
      this.diaries = diaries;
    }
  }

  @override
  List<Object> get props => [diaries];
}

class DiaryAddedState extends DiaryState {
  final List<DiaryEntity> diaries;
  const DiaryAddedState({this.diaries});
  @override
  List<Object> get props => [diaries];
}
