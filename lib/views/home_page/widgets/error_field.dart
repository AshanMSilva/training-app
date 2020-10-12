import 'package:flutter/material.dart';
import 'package:training_app/util/constants.dart';

class ErrorField extends StatelessWidget {
  final bool isErrorOccured;
  final bool isDescriptionExpanded;
  final String errText;
  ErrorField({
    this.isErrorOccured,
    this.isDescriptionExpanded,
    this.errText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Visibility(
        visible: isErrorOccured && isDescriptionExpanded,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              errText,
              style: kErrorTextStyle,
            ),
          ],
        ),
      ),
    );
    
  }
}
