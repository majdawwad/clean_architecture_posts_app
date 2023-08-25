part of 'add_update_delete_post_bloc.dart';

abstract class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddUpdateDeletePostState extends AddUpdateDeletePostState {}

class SuccessAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String successMessage;
  const SuccessAddUpdateDeletePostState({
    required this.successMessage,
  });
  @override
  List<Object> get props => [successMessage];
}

class ErrorAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String errorMessage;
  const ErrorAddUpdateDeletePostState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [errorMessage];
}
