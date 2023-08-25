import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme/app_theme.dart';
import 'dependency_injection.dart' as di;
import 'features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/pages/posts_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()
            ..add(
              GetAllPostsEvent(),
            ),
        ),
        BlocProvider(create: (_) => di.sl<AddUpdateDeletePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts App',
        theme: appTheme,
        home: const PostsPageView(),
      ),
    );
  }
}
