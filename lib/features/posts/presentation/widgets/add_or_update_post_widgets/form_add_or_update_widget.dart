import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'form_submit_button_widget.dart';
import 'text_form_field_widget.dart';

class FormAddOrUpdateWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;
  const FormAddOrUpdateWidget({
    Key? key,
    this.post,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  State<FormAddOrUpdateWidget> createState() => _FormAddOrUpdateWidgetState();
}

class _FormAddOrUpdateWidgetState extends State<FormAddOrUpdateWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            name: "Title",
            multiLines: false,
            controller: _titleController,
          ),
          TextFormFieldWidget(
            name: "Body",
            multiLines: true,
            controller: _bodyController,
          ),
          FormSubmitButtonWidget(
            isUpdatePost: widget.isUpdatePost,
            onPressed: validateFormThenAddOrUpdatePost,
          ),
        ],
      ),
    );
  }

  void validateFormThenAddOrUpdatePost() {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      final Post post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isUpdatePost) {
        context
            .read<AddUpdateDeletePostBloc>()
            .add(UpdatePostEvent(post: post));
      } else {
        context.read<AddUpdateDeletePostBloc>().add(AddPostEvent(post: post));
      }
    }
  }
}
