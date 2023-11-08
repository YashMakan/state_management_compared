import 'package:state_management_compared/core/resources/data_state.dart';
import 'package:state_management_compared/features/home_page/data/models/post.dart';
import 'package:get/get.dart';
import 'package:state_management_compared/features/home_page/domain/usecases/fetch_posts_usecase.dart';

class PostController extends GetxController {
  RxList<Post> posts = RxList();
  int offset = 0;
  RxBool isLoading = true.obs;
  FetchPostsUsecase fetchPostsUsecase = FetchPostsUsecase();

  PostController();

  void getPosts() {
    fetchPostsUsecase(params: offset).then((dataState) {
      if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
        updatePosts(dataState.data!);
        offset += 10;
      }
    });
  }

  void onScrollEnd() {
    fetchPostsUsecase(params: offset).then((dataState) {
      if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
        addPosts(dataState.data!);
        offset += 10;
      }
    });
  }

  void updatePosts(List<Post> newPosts) {
    posts.value = newPosts;
  }

  void addPosts(List<Post> newPosts) {
    posts.addAll(newPosts);
  }

  void updateLike(int index, int value) {
    Post post = posts.elementAt(index);
    posts.removeAt(index);
    post.likes = value;
    posts.insert(index, post);
  }
}
