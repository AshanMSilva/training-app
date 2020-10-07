part of 'diary_bloc.dart';

abstract class DiaryEvent extends Equatable {
  const DiaryEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends DiaryEvent {
  const InitialEvent();
  @override
  List<Object> get props => [];
}

class AddDiaryEvent extends DiaryEvent {
  final DiaryEntity diaryEntity;

  const AddDiaryEvent({
    this.diaryEntity,
  });
  @override
  List<Object> get props => [diaryEntity];
}
