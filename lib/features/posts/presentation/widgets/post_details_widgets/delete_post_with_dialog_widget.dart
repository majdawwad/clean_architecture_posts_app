import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'yes_or_no_button_widget.dart';

class DeletePostWithDialogWidget extends StatelessWidget {
  final int postId;
  const DeletePostWithDialogWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Are you sure?!...",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        YesOrNoButtonWidget(
          btnText: "No",
          onPressed: () => Navigator.of(context).pop(),
        ),
        YesOrNoButtonWidget(
          btnText: "Yes",
          onPressed: () {
            context.read<AddUpdateDeletePostBloc>().add(
                  DeletePostEvent(postId: postId),
                );
          },
        ),
      ],
    );
  }
}
