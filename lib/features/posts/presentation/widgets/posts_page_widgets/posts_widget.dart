import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import '../../pages/post_details_page_view.dart';

class PostsWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            posts[index].id.toString(),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text(
            posts[index].title.toString(),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            posts[index].body.toString(),
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostDetailsPageView(
                  post: posts[index],
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1.0,
        );
      },
      itemCount: posts.length,
    );
  }
}
