import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/bloc/post_bloc.dart';
import 'package:training_app/pages/DiaryHome.dart';

import 'package:training_app/src/firebase_post_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Error Occured');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider(
            create: (context) =>
                PostBloc(postRepository: FirebasePostRepository())
                  ..add(InitialEvent()),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: DiaryHome(),
            ),
          );
        }

        return Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        );
      },
    );
  }
}
