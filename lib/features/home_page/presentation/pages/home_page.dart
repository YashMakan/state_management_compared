import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_compared/features/home_page/presentation/controllers/post_controller.dart';

import '../components/header_section.dart';
import '../components/post_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(PostController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller.getPosts();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        controller.onScrollEnd();
      }
    });
    super.initState();
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
                child: Obx(() {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.posts.length &&
                          controller.isLoading.isTrue) {
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
