import 'package:state_management_compared/core/resources/data_state.dart';
import 'package:state_management_compared/features/home_page/data/models/post.dart';

abstract class HomePageRepository {
  Future<DataState<List<Post>>> getPosts(int offset);
}
