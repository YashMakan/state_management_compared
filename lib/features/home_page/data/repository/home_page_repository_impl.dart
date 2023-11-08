import 'dart:io';

import 'package:state_management_compared/core/resources/data_state.dart';
import 'package:state_management_compared/features/home_page/data/data_sources/home_page_api_service.dart';
import 'package:state_management_compared/features/home_page/data/models/post.dart';
import 'package:state_management_compared/features/home_page/domain/repository/home_page_repository.dart';

class HomePageRepositoryImpl extends HomePageRepository {
  @override
  Future<DataState<List<Post>>> getPosts(int offset) async {
    try {
      List<Post> posts = await HomePageApiService.getPosts(offset: offset);
      return DataSuccess(posts);
    } on HttpException catch (error) {
      return DataFailed(error);
    }
  }
}
