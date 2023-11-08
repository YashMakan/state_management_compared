import 'package:flutter/material.dart';
import 'package:state_management_compared/api/api.dart';
import 'package:state_management_compared/views/home_page/components/header_section.dart';
import 'package:state_management_compared/views/home_page/components/story_listview.dart';
import 'package:state_management_compared/widgets/inherited_home_widget.dart';

import 'components/post_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = true;
  int offset = 0;

  @override
  void initState() {
    Api.getPosts(offset: offset).then((_posts) {
      InheritedHomeWidget.of(context)?.posts = _posts;
      offset += 10;
      setState(() {});
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        Api.getPosts(offset: offset).then((_posts) {
          if (_posts.isEmpty) {
            isLoading = false;
          }
          InheritedHomeWidget.of(context)?.posts.addAll(_posts);
          offset += 10;
          setState(() {});
        });
      }
    });
    super.initState();
  }

  Widget header() {
    return const Column(
      children: [
        StoryListView(),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              HeaderSection(
                  onLikedUpdated: (value, index) {
                    InheritedHomeWidget.of(context)?.posts[index].likes =
                        !value ? 0 : 1;
                    setState(() {});
                  }),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: InheritedHomeWidget.of(context)!.posts.length + 1,
                  itemBuilder: (context, index) {
                    if (index ==
                            InheritedHomeWidget.of(context)?.posts.length &&
                        isLoading) {
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
                        post: InheritedHomeWidget.of(context)!.posts[index],
                        index: index,
                        onLikedUpdated: (index) {
                          InheritedHomeWidget.of(context)!.posts[index].likes =
                              InheritedHomeWidget.of(context)!
                                          .posts[index]
                                          .likes ==
                                      1
                                  ? 0
                                  : 1;
                          setState(() {});
                        });
                  },
                ),
              )
            ],
          ),
        ));
  }
}
