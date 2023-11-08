import 'package:state_management_compared/api/api.dart';
import 'package:state_management_compared/models/post.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxList<Post> posts = RxList();
  int offset = 0;
  RxBool isLoading = true.obs;

  PostController();

  void getPosts() {
    Api.getPosts(offset: offset).then((newPosts) {
      updatePosts(newPosts);
      offset += 10;
    });
  }

  void onScrollEnd() {
    Api.getPosts(offset: offset).then((newPosts) {
      if (newPosts.isEmpty) {
        isLoading.value = false;
      }
      addPosts(newPosts);
      offset += 10;
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
