import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_compared/core/constants/assets.dart';
import 'package:state_management_compared/features/home_page/presentation/controllers/post_controller.dart';

import 'like_bottomsheet.dart';

class HeaderSection extends ConsumerStatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  ConsumerState<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends ConsumerState<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    ref.watch(postNotifier);
    final notifier = ref.read(postNotifier.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            MyAssets.instagramLogo,
            width: 112,
          ),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => const LikeButtonSheet());
            },
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            child: Text(
              'Total Like Counter: ${notifier.totalLikes}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
          // SizedBox(
          //   child: Row(
          //     children: [
          //       Image.asset(MyAssets.addIcon, width: 24,),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 20),
          //         child: Image.asset(MyAssets.heartIcon, width: 24,),
          //       ),
          //       Image.asset(MyAssets.messageIcon, width: 24,),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
