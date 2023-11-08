import 'package:flutter/widgets.dart';
import 'package:state_management_compared/models/post.dart';

class InheritedHomeWidget extends InheritedWidget {
  List<Post> posts;

  InheritedHomeWidget({super.key,
    required this.posts,
    required Widget child,
  }) : super(child: child);

  static InheritedHomeWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedHomeWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}