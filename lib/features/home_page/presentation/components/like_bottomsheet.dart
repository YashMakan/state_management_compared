import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_compared/features/home_page/presentation/bloc/post_bloc.dart';
import 'package:state_management_compared/features/home_page/presentation/bloc/post_states.dart';

class LikeButtonSheet extends StatefulWidget {
  const LikeButtonSheet({super.key});

  @override
  State<LikeButtonSheet> createState() => _LikeButtonSheetState();
}

class _LikeButtonSheetState extends State<LikeButtonSheet> {
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<PostBloc>(context);
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      return ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(controller.posts[index].username),
          trailing: Switch(
            value: controller.posts[index].likes == 1,
            onChanged: (value) {
              controller.updateLike(index, !value ? 0 : 1);
            },
          ),
          leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(controller.posts[index].profilePicture)),
        ),
      );
    });
  }
}
