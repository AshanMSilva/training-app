import 'package:flutter/material.dart';

class DiaryCard extends StatefulWidget {
  DiaryCard({this.title, this.subTitle, this.description});
  final String title;
  final String description;
  final String subTitle;
  @override
  _DiaryCardState createState() => _DiaryCardState();
}

class _DiaryCardState extends State<DiaryCard> {
  int maxLines = 3;
  bool showMoreVisible = true;
  bool showLessVisible = false;
  @override
  Widget build(BuildContext context) {
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
              Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.black),
              ),
              SizedBox(
                height: 3,
              ),
              Text(widget.subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      letterSpacing: 1.2,
                      color: Colors.grey[800],
                      fontSize: 14)),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.description,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    letterSpacing: 1.2, fontSize: 14, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Visibility(
                visible: showMoreVisible,
                child: FlatButton(
                  padding: EdgeInsets.only(left: -12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    setState(() {
                      maxLines = 1000;
                      showLessVisible = !showLessVisible;
                      showMoreVisible = !showMoreVisible;
                    });
                  },
                  child: Text(
                    'Show More'.toUpperCase(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Visibility(
                visible: showLessVisible,
                child: FlatButton(
                  padding: EdgeInsets.only(left: -12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  onPressed: () {
                    setState(() {
                      maxLines = 3;
                      showLessVisible = !showLessVisible;
                      showMoreVisible = !showMoreVisible;
                    });
                  },
                  child: Text(
                    'Show Less'.toUpperCase(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
