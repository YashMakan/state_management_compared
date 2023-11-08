import 'package:state_management_compared/features/home_page/domain/entities/post.dart';

class Post extends PostEntity {
  Post(
      {required String profilePicture,
      required String username,
      required List<String> posts,
      required int likes,
      required String caption,
      required int comments})
      : super(
            profilePicture: profilePicture,
            username: username,
            posts: posts,
            likes: likes,
            caption: caption,
            comments: comments);

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        profilePicture: json['profile_picture'],
        username: json['first_name'],
        posts: [
          json['profile_picture'],
        ],
        likes: 0,
        caption: json['street'],
        comments: json['id'],
      );
}
