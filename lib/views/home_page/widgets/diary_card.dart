import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/util/constants.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/diary_card/diary_card_bloc.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/diary_card/diary_card_event.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/diary_card/diary_card_state.dart';

class DiaryCard extends StatelessWidget {
  DiaryCard({this.title, this.subTitle, this.description});
  final String title;
  final String description;
  final String subTitle;
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final diaryCardBloc = BlocProvider.of<DiaryCardBloc>(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Color(0xffb9e9ff),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<DiaryCardBloc, DiaryCardState>(
                builder: (context, state) {
                  return Text(
                    title,
                    maxLines: state.maxLinesTitle,
                    overflow: TextOverflow.ellipsis,
                    style: kCardTitleStyle,
                  );
                },
              ),
              SizedBox(
                height: 3,
              ),
              BlocBuilder<DiaryCardBloc, DiaryCardState>(
                builder: (context, state) {
                  return Text(
                    subTitle,
                    maxLines: state.maxLinesSubtitle,
                    overflow: TextOverflow.ellipsis,
                    style: kCardSubtitleStyle,
                  );
                },
              ),
              SizedBox(
                height: 12,
              ),
              BlocBuilder<DiaryCardBloc, DiaryCardState>(
                builder: (context, state) {
                  return Text(
                    description,
                    maxLines: state.maxLinesDescription,
                    overflow: TextOverflow.ellipsis,
                    style: kCardDescriptionStyle,
                  );
                },
              ),
              SizedBox(
                height: 15,
              ),
              BlocBuilder<DiaryCardBloc, DiaryCardState>(
                builder: (context, state) {
                  return FlatButton(
                    padding: EdgeInsets.only(left: -12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {
                      diaryCardBloc.add(TapShowButtonEvent(
                          showMoreVisible: !state.showMoreVisible));
                    },
                    child: Text(
                      state.showMoreVisible
                          ? 'Show More'.toUpperCase()
                          : 'Show Less'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
