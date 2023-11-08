import 'package:state_management_compared/core/resources/data_state.dart';
import 'package:state_management_compared/core/usecase/use_case.dart';
import 'package:state_management_compared/features/home_page/data/models/post.dart';
import 'package:state_management_compared/features/home_page/data/repository/home_page_repository_impl.dart';
import 'package:state_management_compared/features/home_page/domain/repository/home_page_repository.dart';

class FetchPostsUsecase implements UseCase<DataState<List<Post>>, int> {
  @override
  Future<DataState<List<Post>>> call({int? params}) {
    HomePageRepository homePageRepository = HomePageRepositoryImpl();
    return homePageRepository.getPosts(params!);
  }
}
