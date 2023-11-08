import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_compared/widgets/post_provider.dart';

class LikeButtonSheet extends StatefulWidget {
  const LikeButtonSheet({super.key});

  @override
  State<LikeButtonSheet> createState() => _LikeButtonSheetState();
}

class _LikeButtonSheetState extends State<LikeButtonSheet> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: true);
    return ListView.builder(
      itemCount: postProvider.posts.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(postProvider.posts[index].username),
        trailing: Switch(
          value: postProvider.posts[index].likes == 1,
          onChanged: (value) {
            postProvider.updateLike(index, !value ? 0 : 1);
          },
        ),
        leading: CircleAvatar(
            backgroundImage:
                NetworkImage(postProvider.posts[index].profilePicture)),
      ),
    );
  }
}
