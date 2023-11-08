import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_compared/core/constants/assets.dart';
import 'package:state_management_compared/features/home_page/presentation/bloc/post_bloc.dart';
import 'package:state_management_compared/features/home_page/presentation/bloc/post_states.dart';

import 'like_bottomsheet.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<PostBloc>(context);
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
                  builder: (context) => BlocProvider.value(
                        value: controller,
                        child: const LikeButtonSheet(),
                      ));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              return Text(
                'Total Like Counter: ${controller.posts.isEmpty ? 0 : controller.posts.map((e) => e.likes).reduce((a, b) => a + b)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            }),
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
