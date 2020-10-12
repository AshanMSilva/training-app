import 'package:flutter/material.dart';

@immutable
abstract class PostFormEvent {}

class ErrorEvent extends PostFormEvent {
  final String error;

  ErrorEvent(this.error);
}

class TapOutsideEvent extends PostFormEvent {
  final bool expandDescription;
  final titleFieldWidth;
  TapOutsideEvent({
    this.expandDescription,
    this.titleFieldWidth,
  });
}

class TapTitleFieldEvent extends PostFormEvent {
  final bool expandDescription;
  final titleFieldWidth;
  TapTitleFieldEvent({
    this.expandDescription,
    this.titleFieldWidth,
  });
}

class DescriptionFieldValidateEvent extends PostFormEvent {
  final bool descriptionErr;
  final String description;
  DescriptionFieldValidateEvent({
    this.description,
    this.descriptionErr,
  });
}

class DescriptionFieldChangeEvent extends PostFormEvent {
  final bool descriptionErr;
  final String description;
  DescriptionFieldChangeEvent({this.descriptionErr, this.description});
}

class TitleFieldChangeEvent extends PostFormEvent {
  final bool titleErr;
  final String title;
  TitleFieldChangeEvent({
    this.titleErr,
    this.title,
  });
}

class TitleFieldValidateEvent extends PostFormEvent {
  final bool titleErr;
  final String title;
  TitleFieldValidateEvent({
    this.title,
    this.titleErr,
  });
}

class SubmitFormEvent extends PostFormEvent {
  final bool expandDescription;
  final double titleFieldWidth;

  SubmitFormEvent({
    this.expandDescription,
    this.titleFieldWidth,
  });
}

class ResetFormEvent extends PostFormEvent {}
