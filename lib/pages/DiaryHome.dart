import 'package:flutter/material.dart';
import 'package:training_app/components/DiaryCard.dart';

class DiaryHome extends StatefulWidget {
  @override
  _DiaryHomeState createState() => _DiaryHomeState();
}

bool titleErr = false;
String title;
bool descriptionErr = false;
String description;
List<DiaryCard> diaryCards = <DiaryCard>[];
final _formKey = GlobalKey<FormState>();

class _DiaryHomeState extends State<DiaryHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.all(5),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
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
        ),
        child: SafeArea(
            // minimum: EdgeInsets.only(top: 5),
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xff2073f0).withOpacity(0.3),
                      ),
                      margin: EdgeInsets.only(left: 5, right: 5),
                      alignment: Alignment.centerLeft,
                      height: 50.0,
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              titleErr = true;
                            });
                          } else {
                            setState(() {
                              titleErr = false;
                            });
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              titleErr = true;
                            });
                          } else {
                            setState(() {
                              titleErr = false;
                              title = value;
                            });
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Submit New',
                          hintStyle:
                              TextStyle(color: Color(0xff40545e), fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Visibility(
                          visible: titleErr,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text('Title is Required',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      letterSpacing: 1.2)),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xff2073f0).withOpacity(0.3),
                      ),
                      height: 120.0,
                      child: TextFormField(
                        maxLines: 100,
                        validator: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              descriptionErr = true;
                            });
                          } else {
                            setState(() {
                              descriptionErr = false;
                              description = value;
                            });
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          if (value.isEmpty) {
                            setState(() {
                              descriptionErr = true;
                            });
                          } else {
                            setState(() {
                              descriptionErr = false;
                            });
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0, left: 20),
                          hintText: 'Enter Description',
                          hintStyle:
                              TextStyle(color: Color(0xff40545e), fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Visibility(
                          visible: descriptionErr,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text('Description is Required',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      letterSpacing: 1.2)),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xff2073f0),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (titleErr == false && descriptionErr == false) {
                              _formKey.currentState.reset();
                              diaryCards.add(DiaryCard(
                                title: title,
                                description: description,
                                subTitle: 'Sample Subtitle',
                              ));
                            } else if (titleErr == true ||
                                descriptionErr == true) {
                              if (titleErr == true) {
                                print("Missing Title");
                              }
                              if (descriptionErr == true) {
                                print("Missing Description");
                              }
                            }
                          }
                        },
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: diaryCards,
              )
            ],
          ),
        )),
      ),
    );
  }
}
