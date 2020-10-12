import 'package:flutter/material.dart';

@immutable
class DiaryCardState {
  final String error;
  final int maxLinesDescription;
  final int maxLinesSubtitle;
  final int maxLinesTitle;
  final bool showMoreVisible;

  DiaryCardState({
    @required this.error,
    @required this.maxLinesDescription,
    @required this.maxLinesSubtitle,
    @required this.maxLinesTitle,
    @required this.showMoreVisible,
  });

  static DiaryCardState get initialState => DiaryCardState(
        error: '',
        maxLinesDescription: 3,
        maxLinesSubtitle: 1,
        maxLinesTitle: 2,
        showMoreVisible: true,
      );

  DiaryCardState clone({
    String error,
    int maxLinesDescription,
    int maxLinesSubtitle,
    int maxLinesTitle,
    bool showMoreVisible,
  }) {
    return DiaryCardState(
      error: error ?? this.error,
      maxLinesDescription: maxLinesDescription ?? this.maxLinesDescription,
      maxLinesSubtitle: maxLinesSubtitle ?? this.maxLinesSubtitle,
      maxLinesTitle: maxLinesTitle ?? this.maxLinesTitle,
      showMoreVisible: showMoreVisible ?? this.showMoreVisible,
    );
  }
}
