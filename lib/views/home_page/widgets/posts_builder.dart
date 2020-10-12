import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/views/home_page/blocs/db_blocs/post/post_bloc.dart';
import 'package:training_app/views/home_page/blocs/db_blocs/post/post_state.dart';
import 'package:training_app/views/home_page/blocs/ui_blocs/diary_card/diary_card_bloc.dart';
import 'package:training_app/views/home_page/widgets/diary_card.dart';

class PostBuilder extends StatelessWidget {
  final loadingCircle = Center(
    child: SpinKitFadingCircle(
      color: Colors.white,
      size: 50.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      buildWhen: (previous, current) =>
          !identical(previous.posts, current.posts),
      builder: (context, state) {
        print('Build Posts Builder Field.....');
        if (state.posts == null) {
          return loadingCircle;
        } else if (state.posts.isEmpty) {
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return BlocProvider(
                create: (context) => DiaryCardBloc(context),
                child: DiaryCard(
                  title: state.posts[index].title,
                  subTitle: state.posts[index].user,
                  description: state.posts[index].description,
                ),
              );
            },
          );
        }
      },
    );
    // return StreamBuilder(
    //     stream: streamPosts,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Text('Error Occured');
    //       }

    //       if (!snapshot.hasData) {
    //         return Center(
    //           child: SpinKitFadingCircle(
    //             color: Colors.white,
    //             size: 50.0,
    //           ),
    //         );
    //       } else {
    //         List<Post> listPosts = snapshot.data;
    //         listPosts.sort((a, b) => b.created.compareTo(a.created));
    //         return ListView.builder(
    //           physics: NeverScrollableScrollPhysics(),
    //           shrinkWrap: true,
    //           scrollDirection: Axis.vertical,
    //           itemCount: listPosts.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return DiaryCard(
    //               title: listPosts[index].title,
    //               subTitle: listPosts[index].user,
    //               description: listPosts[index].description,
    //             );
    //           },
    //         );
    //       }
    //     });
  }
}
