import 'package:state_management_compared/core/resources/data_state.dart';
import 'package:state_management_compared/features/home_page/data/models/post.dart';
import 'package:state_management_compared/features/home_page/domain/usecases/fetch_posts_usecase.dart';
import 'package:bloc/bloc.dart';
import 'post_events.dart';
import 'post_states.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(InitialPostState()) {
    on<GetPostsEvent>((event, emit) async {
      emit(LoadingPostState());
      try {
        final dataState = await fetchPostsUsecase(params: offset);
        if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
          updatePosts(dataState.data!);
          offset += 10;
          emit(LoadedPostState(posts));
        }
      } catch (e) {
        emit(ErrorPostState('An error occurred'));
      }
    });

    on<OnLikeClickedEvent>((event, emit) => emit(LoadedPostState(posts)));

    on<ScrollEndEvent>((event, emit) async {
      emit(LoadingPostState());
      try {
        final dataState = await fetchPostsUsecase(params: offset);
        if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
          addPosts(dataState.data!);
          offset += 10;
          emit(LoadedPostState(posts));
        }
      } catch (e) {
        emit(ErrorPostState('An error occurred'));
      }
    });
  }

  List<Post> posts = [];
  int offset = 0;
  bool isLoading = true;
  FetchPostsUsecase fetchPostsUsecase = FetchPostsUsecase();

  void updatePosts(List<Post> newPosts) {
    posts = newPosts;
  }

  void addPosts(List<Post> newPosts) {
    posts.addAll(newPosts);
  }

  void updateLike(int index, int value) {
    Post post = posts.elementAt(index);
    posts.removeAt(index);
    post.likes = value;
    posts.insert(index, post);
    add(OnLikeClickedEvent());
  }
}