import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_compared/features/home_page/presentation/controllers/post_controller.dart';

class LikeButtonSheet extends ConsumerStatefulWidget {
  const LikeButtonSheet({super.key});

  @override
  ConsumerState<LikeButtonSheet> createState() => _LikeButtonSheetState();
}

class _LikeButtonSheetState extends ConsumerState<LikeButtonSheet> {
  @override
  Widget build(BuildContext context) {
    ref.watch(postNotifier);
    final notifier = ref.read(postNotifier.notifier);
    return ListView.builder(
      itemCount: notifier.postLength,
      itemBuilder: (context, index) => ListTile(
        title: Text(notifier.getPost(index).username),
        trailing: Switch(
          value: notifier.getPost(index).likes == 1,
          onChanged: (value) {
            notifier.updateLike(index, !value ? 0 : 1);
          },
        ),
        leading: CircleAvatar(
            backgroundImage:
            NetworkImage(notifier.getPost(index).profilePicture)),
      ),
    );
  }
}
