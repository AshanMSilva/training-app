import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';

import 'diary_card_event.dart';
import 'diary_card_state.dart';

class DiaryCardBloc extends Bloc<DiaryCardEvent, DiaryCardState> {
  static final log = Log("DiartCardBloc");

  DiaryCardBloc(BuildContext context) : super(DiaryCardState.initialState);

  @override
  Stream<DiaryCardState> mapEventToState(DiaryCardEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;
      case TapShowButtonEvent:
        print(
          'TapShowButtonEvent occured ......................................',
        );
        final showMoreVisible = (event as TapShowButtonEvent).showMoreVisible;
        if (!showMoreVisible) {
          yield state.clone(
            showMoreVisible: showMoreVisible,
            maxLinesDescription: 1000,
            maxLinesSubtitle: 1000,
            maxLinesTitle: 1000,
          );
        } else {
          yield state.clone(
            showMoreVisible: showMoreVisible,
            maxLinesDescription: 3,
            maxLinesSubtitle: 1,
            maxLinesTitle: 2,
          );
        }

        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    log.e('$stacktrace');
    log.e('$error');
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      add(ErrorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      ));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again !"));
    }
  }
}
