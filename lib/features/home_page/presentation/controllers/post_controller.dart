import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_compared/core/resources/data_state.dart';
import 'package:state_management_compared/features/home_page/data/models/post.dart';
import 'package:state_management_compared/features/home_page/domain/usecases/fetch_posts_usecase.dart';

class PostState {
  final List<Post> posts;
  final bool isLoading;

  PostState(this.posts, this.isLoading);

  PostState copyWith({List<Post>? posts, bool? isLoading}) =>
      PostState(posts ?? this.posts, isLoading ?? this.isLoading);
}

final postNotifier =
    StateNotifierProvider<PostNotifier, PostState>((ref) => PostNotifier());

class PostNotifier extends StateNotifier<PostState> {
  int offset = 0;
  FetchPostsUsecase fetchPostsUsecase = FetchPostsUsecase();

  PostNotifier() : super(PostState([], true));

  int get postLength => state.posts.length;

  bool get isLoading => state.isLoading;

  int get totalLikes {
    return state.posts.isEmpty
        ? 0
        : state.posts.map((e) => e.likes).reduce((a, b) => a + b);
  }

  Post getPost(int index) {
    return state.posts.elementAt(index);
  }

  void getPosts() {
    fetchPostsUsecase(params: offset).then((dataState) {
      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        updatePosts(dataState.data!);
        offset += 10;
      }
    });
  }

  void onScrollEnd() {
    fetchPostsUsecase(params: offset).then((dataState) {
      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        addPosts(dataState.data!);
        offset += 10;
      }
    });
  }

  void updatePosts(List<Post> newPosts) {
    state = state.copyWith(posts: newPosts);
  }

  void addPosts(List<Post> newPosts) {
    state = state.copyWith(posts: [...state.posts, ...newPosts]);
  }

  void updateLike(int index, int value) {
    final updatedPosts = List<Post>.from(state.posts);
    updatedPosts[index] = updatedPosts[index].copyWith(likes: value);
    state = state.copyWith(posts: updatedPosts);
  }
}
