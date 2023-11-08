import 'package:flutter/material.dart';
import 'package:state_management_compared/models/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> posts = [];

  PostProvider();

  void updatePosts(List<Post> newPosts) {
    posts = newPosts;
    notifyListeners();
  }

  void addPosts(List<Post> newPosts) {
    posts.addAll(newPosts);
    notifyListeners();
  }

  void updateLike(int index, int value) {
    posts[index].likes = value;
    notifyListeners();
  }
}
