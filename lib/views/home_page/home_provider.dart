import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_app/views/home_page/blocs/db_blocs/post/post_bloc.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/form/post_form_bloc.dart';

import 'home_view.dart';

class HomeProvider extends BlocProvider<PostFormBloc> {
  HomeProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => PostFormBloc(context),
          child: BlocProvider(
            create: (context) => PostBloc(context),
            child: HomeView(),
          ),
        );
}
