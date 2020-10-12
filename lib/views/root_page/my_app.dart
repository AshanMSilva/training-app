import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/util/constants.dart';
import 'package:training_app/views/home_page/home_provider.dart';
import 'package:training_app/views/root_page/bloc/root_bloc.dart';
import 'package:training_app/views/root_page/bloc/root_state.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadingScreen = Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: kBackgroundDecoration,
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    );

    final mateiralApp = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<RootBloc, RootState>(
        buildWhen: (pre, current) => pre.initialized != current.initialized,
        builder: (context, state) {
          if (state.initialized) {
            return HomeProvider();
          }
          return loadingScreen;
        },
      ),
    );

    return BlocProvider(
      create: (context) => RootBloc(context),
      child: mateiralApp,
    );
  }
}
