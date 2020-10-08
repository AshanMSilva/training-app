import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/bloc/post_bloc.dart';
import 'package:training_app/components/DiaryCard.dart';

import 'package:training_app/src/models/models.dart';

class DiaryHome extends StatefulWidget {
  @override
  _DiaryHomeState createState() => _DiaryHomeState();
}

double titleFieldWidth = 170; //to handle title field width
bool titleErr = false; //to handle title required err
String title;
bool descriptionErr = false; //to handle description require err
String description;
bool expandDescription = false; //to expand the description err
final _formKey = GlobalKey<FormState>();

class _DiaryHomeState extends State<DiaryHome>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (expandDescription) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///create transition field
  Widget _buildTransitionField() {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionField(),
          _buildDescriptionRequiredWidget(),
          SizedBox(
            height: 10,
          ),
          _buildSubmitButton()
        ],
      ),
    );
  }

//create description field
  Widget _buildDescriptionField() {
    return Container(
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
          hintStyle: TextStyle(color: Color(0xff40545e), fontSize: 14),
        ),
      ),
    );
  }

//create description required error field
  Widget _buildDescriptionRequiredWidget() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Visibility(
          visible: descriptionErr && expandDescription,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text('Description is Required',
                  style: TextStyle(
                      color: Colors.red, fontSize: 12, letterSpacing: 1.2)),
            ],
          )),
    );
  }

//create submit button
  Widget _buildSubmitButton() {
    return Container(
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

              BlocProvider.of<PostBloc>(context).add(AddPostEvent(
                  post: Post(
                      title: title,
                      user: 'Sample Subtitle',
                      description: description,
                      created: Timestamp.now())));

              setState(() {
                expandDescription = false;
                titleFieldWidth = 170;
              });
              _runExpandCheck();
            } else if (titleErr == true || descriptionErr == true) {
              setState(() {
                expandDescription = true;
                titleFieldWidth = MediaQuery.of(context).size.width;
              });
              _runExpandCheck();
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
    );
  }

// create title required error field
  Widget _buildTitleRequiredWidget() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Visibility(
          visible: titleErr && expandDescription,
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text('Title is Required',
                  style: TextStyle(
                      color: Colors.red, fontSize: 12, letterSpacing: 1.2)),
            ],
          )),
    );
  }

//create title field
  Widget _buildTitleField() {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xff2073f0).withOpacity(0.3),
      ),
      margin: EdgeInsets.only(left: 5, right: 5),
      alignment: Alignment.centerLeft,
      height: 55.0,
      width: titleFieldWidth,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
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
        onTap: () {
          if (expandDescription == false) {
            setState(() {
              expandDescription = true;
              titleFieldWidth = MediaQuery.of(context).size.width;
            });
            _runExpandCheck();
          }
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
          hintStyle: TextStyle(color: Color(0xff40545e), fontSize: 14),
        ),
      ),
    );
  }

//create diary card form
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleField(),
          _buildTitleRequiredWidget(),
          SizedBox(
            height: 25,
          ),
          _buildTransitionField(),
        ],
      ),
    );
  }

//create diary card list
  Widget _buildDiaryCardsList() {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostAddedState) {
          return StreamBuilder(
              stream: state.posts,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error Occured');
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                } else {
                  List<Post> listPosts = snapshot.data;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listPosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DiaryCard(
                        title: listPosts[index].title,
                        subTitle: listPosts[index].user,
                        description: listPosts[index].description,
                      );
                    },
                  );
                }
              });
        } else if (state is PostInitial) {
          return StreamBuilder(
              stream: state.posts,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error Occured');
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                } else {
                  List<Post> listPosts = snapshot.data;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listPosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DiaryCard(
                        title: listPosts[index].title,
                        subTitle: listPosts[index].user,
                        description: listPosts[index].description,
                      );
                    },
                  );
                }
              });
        } else if (state is LoadingState) {
          // print('Loading State');
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
            ),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return ListView();
        }
      },
    );
  }

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
            child: GestureDetector(
          onTap: () {
            setState(() {
              expandDescription = false;
              titleFieldWidth = 170;
            });
            _runExpandCheck();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 60, 7, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Home'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 1.3),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'You are Here: Home',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildForm(),
                SizedBox(
                  height: 20,
                ),
                _buildDiaryCardsList()
              ],
            ),
          ),
        )),
      ),
    );
  }
}
