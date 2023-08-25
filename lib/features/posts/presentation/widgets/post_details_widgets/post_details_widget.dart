import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../domain/entities/post.dart';
import '../../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import '../../pages/add_or_update_post_page_view.dart';
import '../../pages/posts_page_view.dart';
import 'delete_post_with_dialog_widget.dart';
import 'edit_or_delete_button_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;
  const PostDetailsWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 50.0),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const Divider(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EditOrDeleteButtonWidget(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddOrUpdatePostPageView(
                          isUpdatePost: true, post: post),
                    ),
                  );
                },
                isColorRedAccent: false,
                iconData: Icons.edit,
                btnText: "Edit",
              ),
              EditOrDeleteButtonWidget(
                onPressed: () => _deletePostDialog(context: context),
                 isColorRedAccent: true,
                iconData: Icons.delete_outline,
                btnText: "Delete",
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deletePostDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
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
              Navigator.of(context).pop();
              SnackBarMessage.snackBarErrorMessage(
                context: context,
                message: state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddUpdateDeletePostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }

            return DeletePostWithDialogWidget(postId: post.id!);
          },
        );
      },
    );
  }
}
