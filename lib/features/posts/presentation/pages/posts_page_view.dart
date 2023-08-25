import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_theme/app_theme.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/posts_page_widgets/message_display_widget.dart';
import '../widgets/posts_page_widgets/posts_widget.dart';
import 'add_or_update_post_page_view.dart';

class PostsPageView extends StatelessWidget {
  const PostsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton(context: context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Posts",
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              color: primaryColor,
              backgroundColor: secondaryColor,
              semanticsLabel: "Loadiing...",
              onRefresh: () => _onRefresh(context: context),
              child: PostsWidget(
                posts: state.posts,
              ),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
              message: state.errorMessage,
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Widget _buildFloatingButton({
    required BuildContext context,
  }) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AddOrUpdatePostPageView(isUpdatePost: false),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _onRefresh({
    required BuildContext context,
  }) async {
    context.read<PostsBloc>().add(RefreshAllPostsEvent());
  }
}
