import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String profilePicture;
  final String username;
  final List<String> posts;
  int likes;
  final String caption;
  final int comments;

  PostEntity(
      {required this.profilePicture,
      required this.username,
      required this.posts,
      required this.likes,
      required this.caption,
      required this.comments});

  @override
  List<Object?> get props =>
      [profilePicture, username, posts, likes, caption, comments];
}
