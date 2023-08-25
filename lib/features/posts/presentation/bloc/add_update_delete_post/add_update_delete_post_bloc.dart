import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

typedef FailureOrPosts = Either<Failure, Unit>;

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  AddUpdateDeletePostBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletePostState());

        final addOrFailurePost = await addPostUseCase(event.post);

        emit(
          _mapFailureOrAddUpdateDeletePostToState(
            addOrFailurePost,
            addPostSuccess,
          ),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletePostState());

        final updateOrFailurePost = await updatePostUseCase(event.post);

        emit(
          _mapFailureOrAddUpdateDeletePostToState(
            updateOrFailurePost,
            updatePostSuccess,
          ),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeletePostState());

        final deleteOrFailurePost = await deletePostUseCase(event.postId);

        emit(
          _mapFailureOrAddUpdateDeletePostToState(
            deleteOrFailurePost,
            deletePostSuccess,
          ),
        );
      }
    });
  }

  AddUpdateDeletePostState _mapFailureOrAddUpdateDeletePostToState(
      FailureOrPosts either, String message) {
    return either.fold(
      (failure) {
        return ErrorAddUpdateDeletePostState(
            errorMessage: _mapFailureToMessageInfo(failure));
      },
      (_) {
        return SuccessAddUpdateDeletePostState(successMessage: message);
      },
    );
  }

  String _mapFailureToMessageInfo(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;

      default:
        return "An Unexpected Wrong, Please try again later!.";
    }
  }
}
