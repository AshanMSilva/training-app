import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/util/constants.dart';
import 'package:training_app/views/home_page/blocs/db_blocs/post/post_bloc.dart';
import 'package:training_app/views/home_page/blocs/db_blocs/post/post_state.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/form/post_form_bloc.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/form/post_form_event.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/form/post_form_state.dart';
import 'package:training_app/views/home_page/widgets/add_post_form.dart';
import 'package:training_app/views/home_page/widgets/posts_builder.dart';

class HomeView extends StatelessWidget {
  static final log = Log("HomeView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final postFormBloc = BlocProvider.of<PostFormBloc>(context);

    log.d("Loading Home View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
        body: Container(
      // padding: EdgeInsets.all(5),
      width: double.infinity,
      height: double.infinity,
      decoration: kBackgroundDecoration,
      child: SafeArea(
          // minimum: EdgeInsets.only(top: 5),
          child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          postFormBloc.add(TapOutsideEvent(
            expandDescription: false,
            titleFieldWidth: 170.0,
          ));
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
                      style: kTitleStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'You are Here: Home',
                      style: kSubTitleStyle,
                    ),
                  ],
                ),
              ),
              AddPostForm(),
              SizedBox(
                height: 20,
              ),
              PostBuilder(),
            ],
          ),
        ),
      )),
    ));

    return MultiBlocListener(
      listeners: [
        BlocListener<PostFormBloc, PostFormState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<PostBloc, PostState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
