import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/posts/data/data_sources/local_data_source.dart';
import 'features/posts/data/data_sources/remote_data_source.dart';
import 'features/posts/data/repositories/post_repository_implement.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts

  //Bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(
    () => AddUpdateDeletePostBloc(
      addPostUseCase: sl(),
      updatePostUseCase: sl(),
      deletePostUseCase: sl(),
    ),
  );

  //UseCases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  //Post Repository

  sl.registerLazySingleton<PostsRepository>(
    () => PostRepositoryImplement(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplement(sharedPreferences: sl()));

  //!core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));

  //!External
  
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
