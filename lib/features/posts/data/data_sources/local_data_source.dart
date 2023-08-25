import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/post_model.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

class LocalDataSourceImplement implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  final String cachedPosts = "CACHED_POSTS";

  LocalDataSourceImplement({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    final List postModelsToJson = postModels
        .map<Map<String, dynamic>>(
          (postModel) => postModel.toJson(),
        )
        .toList();
    final String cachedPosts = json.encode(postModelsToJson);
    sharedPreferences.setString(cachedPosts, cachedPosts);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final cachedPostsJsonString = sharedPreferences.getString(cachedPosts);
    if (cachedPostsJsonString != null) {
      final List postModelsJsonData = json.decode(cachedPostsJsonString);
      final List<PostModel> jsonDataToPostModels = postModelsJsonData
          .map<PostModel>(
            (postModelJsonData) => PostModel.fromJson(postModelJsonData),
          )
          .toList();
      return Future.value(jsonDataToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
