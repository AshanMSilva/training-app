import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';

import 'post_form_event.dart';
import 'post_form_state.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  static final log = Log("PostFormBloc");

  PostFormBloc(BuildContext context) : super(PostFormState.initialState);

  @override
  Stream<PostFormState> mapEventToState(PostFormEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        log.e('Error: $error');
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;
      case TapOutsideEvent:
        print('TapOutsideEvent occured ......................................');
        final expandDescription = (event as TapOutsideEvent).expandDescription;
        final titleFieldWidth = (event as TapOutsideEvent).titleFieldWidth;

        yield state.clone(
          expandDescription: expandDescription,
          titleFieldWidth: titleFieldWidth,
        );
        break;
      case DescriptionFieldValidateEvent:
        print(
            'DescriptionFieldValidateEvent occured ......................................');
        final description =
            (event as DescriptionFieldValidateEvent).description;
        final descriptionErr =
            (event as DescriptionFieldValidateEvent).descriptionErr;
        yield state.clone(
          description: description,
          descriptionErr: descriptionErr,
        );
        break;
      case DescriptionFieldChangeEvent:
        print(
            'DescriptionFieldChangeEvent occured ......................................');
        final descriptionErr =
            (event as DescriptionFieldChangeEvent).descriptionErr;
        final description = (event as DescriptionFieldChangeEvent).description;

        yield state.clone(
          description: description,
          descriptionErr: descriptionErr,
        );

        break;

      case TitleFieldValidateEvent:
        print(
            'TitleFieldValidateEvent occured ......................................');
        final title = (event as TitleFieldValidateEvent).title;
        final titleErr = (event as TitleFieldValidateEvent).titleErr;
        yield state.clone(
          title: title,
          titleErr: titleErr,
        );
        break;
      case TitleFieldChangeEvent:
        print(
            'TitleFieldChangeEvent occured ......................................');
        final titleErr = (event as TitleFieldChangeEvent).titleErr;
        final title = (event as TitleFieldChangeEvent).title;

        yield state.clone(
          title: title,
          titleErr: titleErr,
        );

        break;
      case SubmitFormEvent:
        print('SubmitFormEvent occured ......................................');
        final titleFieldWidth = (event as SubmitFormEvent).titleFieldWidth;
        final expandDescription = (event as SubmitFormEvent).expandDescription;
        yield state.clone(
          titleFieldWidth: titleFieldWidth,
          expandDescription: expandDescription,
        );
        break;
      case TapTitleFieldEvent:
        print(
            'TapTitleFieldEvent occured ......................................');
        final expandDescription =
            (event as TapTitleFieldEvent).expandDescription;
        final titleFieldWidth = (event as TapTitleFieldEvent).titleFieldWidth;

        yield state.clone(
          expandDescription: expandDescription,
          titleFieldWidth: titleFieldWidth,
        );
        break;
      case ResetFormEvent:
        print('ResetFormEvent occured ......................................');
        yield state.clone(
          title: '',
          description: '',
          expandDescription: false,
          titleFieldWidth: 170,
        );
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
