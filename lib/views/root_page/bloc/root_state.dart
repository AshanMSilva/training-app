import 'package:flutter/material.dart';

@immutable
class RootState {
  final bool initialized;
  final String error;

  RootState({
    @required this.initialized,
    @required this.error,
  });

  static RootState get initialState => RootState(
        initialized: false,
        error: '',
      );

  RootState clone({
    bool initialized,
    String error,
  }) {
    return RootState(
      initialized: initialized ?? this.initialized,
      error: error ?? this.error,
    );
  }
}
