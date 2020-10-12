import 'package:flutter/material.dart';


@immutable
class PostFormState {
  final String title;
  final String description;
  final String error;
  final bool descriptionErr;
  final bool titleErr;
  final double titleFieldWidth;
  final bool expandDescription;

  PostFormState({
    @required this.title,
    @required this.description,
    @required this.error,
    @required this.descriptionErr,
    @required this.expandDescription,
    @required this.titleErr,
    @required this.titleFieldWidth,
  });

  static PostFormState get initialState => PostFormState(
        title: null,
        description: null,
        error: '',
        descriptionErr: false,
        titleErr: false,
        expandDescription: false,
        titleFieldWidth: 170,
      );

  PostFormState clone({
    String title,
    String error,
    String description,
    bool descriptionErr,
    bool titleErr,
    double titleFieldWidth,
    bool expandDescription,
  }) {
    if (title == '') {
      return PostFormState(
        title: null,
        error: error ?? this.error,
        description: description ?? this.description,
        descriptionErr: descriptionErr ?? this.descriptionErr,
        titleErr: titleErr ?? this.titleErr,
        titleFieldWidth: titleFieldWidth ?? this.titleFieldWidth,
        expandDescription: expandDescription ?? this.expandDescription,
      );
    } else if (description == '') {
      return PostFormState(
        title: title ?? this.title,
        error: error ?? this.error,
        description: null,
        descriptionErr: descriptionErr ?? this.descriptionErr,
        titleErr: titleErr ?? this.titleErr,
        titleFieldWidth: titleFieldWidth ?? this.titleFieldWidth,
        expandDescription: expandDescription ?? this.expandDescription,
      );
    }
    return PostFormState(
      title: title ?? this.title,
      error: error ?? this.error,
      description: description ?? this.description,
      descriptionErr: descriptionErr ?? this.descriptionErr,
      titleErr: titleErr ?? this.titleErr,
      titleFieldWidth: titleFieldWidth ?? this.titleFieldWidth,
      expandDescription: expandDescription ?? this.expandDescription,
    );
  }
}
