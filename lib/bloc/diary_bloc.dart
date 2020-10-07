import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_app/src/diary_repository.dart';
import 'package:training_app/src/entities/diary_entity.dart';

part 'diary_event.dart';
part 'diary_state.dart';

class DiaryBloc extends Bloc<DiaryEvent, DiaryState> {
  final DiaryRepository _diaryRepository;
  DiaryBloc({DiaryRepository diaryRepository})
      : assert(diaryRepository != null),
        _diaryRepository = diaryRepository,
        super(DiaryInitial());

  @override
  Stream<DiaryState> mapEventToState(
    DiaryEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AddDiaryEvent) {
      _diaryRepository.addNewDiary(event.diaryEntity);
      yield DiaryAddedState(diaries: _diaryRepository.getDiaries());
    } else if (event is InitialEvent) {
      // print(_diaryRepository.getDiaries().length);
      yield DiaryInitial(diaries: <DiaryEntity>[]);
    } else {
      yield DiaryInitial(diaries: _diaryRepository.getDiaries());
    }
  }
}
