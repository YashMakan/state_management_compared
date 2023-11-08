import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_compared/api/api.dart';
import 'package:state_management_compared/views/home_page/components/header_section.dart';
import 'package:state_management_compared/views/home_page/components/story_listview.dart';
import 'package:state_management_compared/widgets/post_provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      Api.getPosts(offset: offset).then((newPosts) {
        postProvider.updatePosts(newPosts);
        offset += 10;
      });
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          Api.getPosts(offset: offset).then((newPosts) {
            if (newPosts.isEmpty) {
              isLoading = false;
            }
            postProvider.addPosts(newPosts);
            offset += 10;
          });
        }
      });
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
              const SizedBox(height: 8),
              const HeaderSection(),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<PostProvider>(
                  builder: (context, postProvider, widget) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: postProvider.posts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == postProvider.posts.length && isLoading) {
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
                          post: postProvider.posts[index],
                        );
                      },
                    );
                  }
                ),
              )
            ],
          ),
        ));
  }
}
