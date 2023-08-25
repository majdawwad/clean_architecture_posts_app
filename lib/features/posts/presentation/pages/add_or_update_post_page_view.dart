import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/post.dart';
import '../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import '../widgets/add_or_update_post_widgets/form_add_or_update_widget.dart';
import 'posts_page_view.dart';

class AddOrUpdatePostPageView extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const AddOrUpdatePostPageView({
    Key? key,
    this.post,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        isUpdatePost ? "Edit Post" : "Add Post",
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
          listener: (context, state) {
            if (state is SuccessAddUpdateDeletePostState) {
              SnackBarMessage.snackBarSuccessMessage(
                context: context,
                message: state.successMessage,
              );
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PostsPageView()),
                (route) => false,
              );
            } else if (state is ErrorAddUpdateDeletePostState) {
              SnackBarMessage.snackBarErrorMessage(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddUpdateDeletePostState) {
              return const LoadingWidget();
            }
            return FormAddOrUpdateWidget(
              isUpdatePost: isUpdatePost,
              post: isUpdatePost ? post : null,
            );
          },
        ),
      ),
    );
  }
}
