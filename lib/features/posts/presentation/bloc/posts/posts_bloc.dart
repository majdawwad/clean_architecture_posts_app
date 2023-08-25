import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

typedef FailureOrPosts =  Either<Failure, List<Post>>;

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  PostsBloc({
    required this.getAllPostsUseCase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final FailureOrPosts failureOrPosts =
            await getAllPostsUseCase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshAllPostsEvent) {
        emit(LoadingPostsState());

        final FailureOrPosts failureOrPosts =
            await getAllPostsUseCase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(FailureOrPosts either) {
    return either.fold(
      (failure) {
        return ErrorPostsState(errorMessage: _mapFailureToMessageInfo(failure));
      },
      (posts) {
        return LoadedPostsState(posts: posts);
      },
    );
  }

  String _mapFailureToMessageInfo(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCachedFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;

      default:
        return "An Unexpected Wrong, Please try again later!.";
    }
  }
}
