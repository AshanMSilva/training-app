import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/db/models/models.dart';
import 'package:training_app/util/constants.dart';
import 'package:training_app/views/home_page/blocs/db_blocs/post/post_bloc.dart';
import 'package:training_app/views/home_page/blocs/db_blocs/post/post_event.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/form/post_form_bloc.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/form/post_form_event.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/form/post_form_state.dart';
import 'package:training_app/views/home_page/widgets/error_field.dart';

class AddPostForm extends StatefulWidget {
  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck(expandDescription: false);
  }

  void prepareAnimations() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck({bool expandDescription}) {
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
  Widget _buildTransitionField({PostFormBloc postFormBloc}) {
    print('Build Transition Field.....');
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionField(
            postFormBloc: postFormBloc,
          ),
          BlocBuilder<PostFormBloc, PostFormState>(
            buildWhen: (previous, current) =>
                previous.descriptionErr != current.descriptionErr,
            builder: (context, state) {
              print('Build Description Required Field.....');
              return ErrorField(
                isErrorOccured: state.descriptionErr,
                isDescriptionExpanded: state.expandDescription,
                errText: 'Description is Required',
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          _buildSubmitButton(
            postFormBloc: postFormBloc,
          ),
        ],
      ),
    );
  }

//create description field
  Widget _buildDescriptionField({
    PostFormBloc postFormBloc,
  }) {
    print('Build Description Field.....');
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      alignment: Alignment.centerLeft,
      decoration: kTextFieldBoxDecoration(radius: 10.0),
      height: 120.0,
      child: TextFormField(
        maxLines: 100,
        validator: (String value) {
          if (value.isEmpty || value == null) {
            postFormBloc.add(DescriptionFieldValidateEvent(
              descriptionErr: true,
              description: '',
            ));
          } else {
            postFormBloc.add(DescriptionFieldValidateEvent(
              descriptionErr: false,
              description: value,
            ));
          }
          return null;
        },
        onChanged: (String value) {
          if (value.isEmpty || value == null) {
            postFormBloc.add(DescriptionFieldChangeEvent(
              descriptionErr: true,
              description: '',
            ));
          } else {
            postFormBloc.add(DescriptionFieldChangeEvent(
              descriptionErr: false,
              description: value,
            ));
          }
        },
        keyboardType: TextInputType.text,
        style: kInputTextStyle,
        decoration: kTextFieldInputDecoration(
          hintText: "Enter Description",
          left: 20,
          right: 0,
          top: 14,
          bottom: 0,
        ),
      ),
    );
  }

//create submit button
  Widget _buildSubmitButton({
    PostFormBloc postFormBloc,
  }) {
    return BlocBuilder<PostFormBloc, PostFormState>(
      buildWhen: (previous, current) =>
          previous.titleErr != current.titleErr ||
          previous.description != current.description ||
          previous.descriptionErr != current.descriptionErr ||
          previous.title != current.title,
      builder: (context, state) {
        print('Build Submit Button.....');

        return Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Color(0xff2073f0),
            onPressed: () {
              // print(state.title);
              if (_formKey.currentState.validate()) {
                if (state.titleErr == false &&
                    state.descriptionErr == false &&
                    state.title != null &&
                    state.description != null) {
                  _formKey.currentState.reset();
                  BlocProvider.of<PostBloc>(context).add(
                    AddNewPostEvent(
                      // ignore: missing_required_param
                      post: Post(
                        title: state.title,
                        user: 'Sample Subtitle',
                        description: state.description,
                        created: Timestamp.now(),
                      ),
                    ),
                  );

                  postFormBloc.add(ResetFormEvent());
                  // print(state);

                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                } else if (state.titleErr == true ||
                    state.descriptionErr == true ||
                    state.description == null ||
                    state.title == null) {
                  postFormBloc.add(SubmitFormEvent(
                    expandDescription: true,
                    titleFieldWidth: MediaQuery.of(context).size.width,
                  ));

                  if (state.titleErr == true) {
                    print("Missing Title");
                  }
                  if (state.descriptionErr == true) {
                    print("Missing Description");
                  }
                }
              }
            },
            child: Text(
              'Submit'.toUpperCase(),
              style: kSubmitButtonStyle,
            ),
          ),
        );
      },
    );
  }

//create title field
  Widget _buildTitleField({
    double titleFieldWidth,
    bool expandDescription,
    PostFormBloc postFormBloc,
  }) {
    print('Build Title Field.....');
    return AnimatedContainer(
      decoration: kTextFieldBoxDecoration(radius: 20.0),
      margin: EdgeInsets.only(left: 5, right: 5),
      alignment: Alignment.centerLeft,
      height: 55.0,
      width: titleFieldWidth,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty || value == null) {
            postFormBloc.add(TitleFieldValidateEvent(
              titleErr: true,
              title: '',
            ));
          } else {
            postFormBloc.add(TitleFieldValidateEvent(
              titleErr: false,
              title: value,
            ));
          }
          return null;
        },
        onTap: () {
          if (expandDescription == false) {
            // print("Ashan");
            postFormBloc.add(TapTitleFieldEvent(
              expandDescription: true,
              titleFieldWidth: MediaQuery.of(context).size.width,
            ));
          }
        },
        onChanged: (String value) {
          if (value.isEmpty || value == null) {
            postFormBloc.add(
              TitleFieldChangeEvent(titleErr: true, title: ''),
            );
          } else {
            postFormBloc.add(
              TitleFieldChangeEvent(
                titleErr: false,
                title: value,
              ),
            );
          }
        },
        keyboardType: TextInputType.text,
        style: kInputTextStyle,
        decoration: kTextFieldInputDecoration(
            hintText: "Submit New", left: 20, right: 20, top: 20, bottom: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final postFormBloc = BlocProvider.of<PostFormBloc>(context);
    return BlocBuilder<PostFormBloc, PostFormState>(
      buildWhen: (previous, current) =>
          previous.expandDescription != current.expandDescription,
      builder: (context, state) {
        print('Build Form.....');
        _runExpandCheck(expandDescription: state.expandDescription);

        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleField(
                titleFieldWidth: state.titleFieldWidth,
                expandDescription: state.expandDescription,
                postFormBloc: postFormBloc,
              ),
              BlocBuilder<PostFormBloc, PostFormState>(
                buildWhen: (previous, current) =>
                    previous.titleErr != current.titleErr ||
                    previous.expandDescription != current.expandDescription,
                builder: (context, state) {
                  print('Build Title Required Field.....');
                  return ErrorField(
                    isErrorOccured: state.titleErr,
                    isDescriptionExpanded: state.expandDescription,
                    errText: 'Title is Required',
                  );
                },
              ),
              SizedBox(
                height: 25,
              ),
              _buildTransitionField(
                postFormBloc: postFormBloc,
              ),
            ],
          ),
        );
      },
    );
  }
}
