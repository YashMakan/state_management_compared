import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_compared/features/home_page/presentation/bloc/post_bloc.dart';
import 'package:state_management_compared/features/home_page/presentation/bloc/post_events.dart';
import 'package:state_management_compared/features/home_page/presentation/bloc/post_states.dart';

import '../components/header_section.dart';
import '../components/post_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final controller = BlocProvider.of<PostBloc>(context);
      controller.add(GetPostsEvent());
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          controller.add(ScrollEndEvent());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<PostBloc>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const HeaderSection(),
              const SizedBox(height: 16),
              Expanded(
                child:
                    BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.posts.length &&
                          controller.isLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                      return PostSection(
                        index: index,
                        post: controller.posts[index],
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ));
  }
}
