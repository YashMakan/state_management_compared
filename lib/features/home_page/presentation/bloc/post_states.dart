import 'package:state_management_compared/features/home_page/data/models/post.dart';

abstract class PostState {}

class InitialPostState extends PostState {}

class LoadedPostState extends PostState {
  final List<Post> posts;

  LoadedPostState(this.posts);
}

class LoadingPostState extends PostState {}

class ErrorPostState extends PostState {
  final String error;

  ErrorPostState(this.error);
}
