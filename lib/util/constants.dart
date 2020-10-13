import 'package:flutter/material.dart';

final kSubmitButtonStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.2,
  fontSize: 14,
);

final kErrorTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 12,
  letterSpacing: 1.2,
);

kTextFieldBoxDecoration({double radius}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: Color(0xff2073f0).withOpacity(0.3),
  );
}

kTextFieldInputDecoration({
  String hintText,
  double top,
  double left,
  double right,
  double bottom,
}) {
  return InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.fromLTRB(
      left,
      top,
      right,
      bottom,
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Color(0xff40545e),
      fontSize: 14,
    ),
  );
}

final kInputTextStyle = TextStyle(
  color: Colors.black,
);

final kBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xff00bad5),
      Color(0xff01afda),
      Color(0xff02a4e0),
      Color(0xff039ce4)
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);
final kTitleStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 30,
  letterSpacing: 1.3,
);

final kSubTitleStyle = TextStyle(
  color: Colors.white.withOpacity(.5),
);

final kCardTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.5,
  color: Colors.black,
);

final kCardSubtitleStyle = TextStyle(
  letterSpacing: 1.2,
  color: Colors.grey[800],
  fontSize: 14,
);

final kCardDescriptionStyle = TextStyle(
  letterSpacing: 1.2,
  fontSize: 14,
  color: Colors.black,
);
