import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_compared/features/home_page/presentation/controllers/post_controller.dart';

import '../components/header_section.dart';
import '../components/post_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final notifier = ref.read(postNotifier.notifier);
      notifier.getPosts();
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) {
          notifier.onScrollEnd();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(postNotifier);
    final notifier = ref.read(postNotifier.notifier);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              const HeaderSection(),
              const SizedBox(height: 16),
              Expanded(child: ListView.builder(
                controller: scrollController,
                itemCount: notifier.postLength + 1,
                itemBuilder: (context, index) {
                  if (index == notifier.postLength  && notifier.isLoading) {
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
                    post: notifier.getPost(index),
                  );
                },
              )),
            ],
          ),
        ));
  }
}
