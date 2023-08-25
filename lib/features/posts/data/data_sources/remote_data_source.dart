// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:clean_architecture_posts_app/core/errors/exceptions/exceptions.dart';

import '../models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

class RemoteDataSourceImplement implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImplement({
    required this.client,
  });

  final String baseUrlApi = "https://jsonplaceholder.typicode.com";

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(
        "$baseUrlApi/posts/",
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List postsDecodedJson = json.decode(response.body) as List;
      final List<PostModel> jsonToPostModels = postsDecodedJson
          .map<PostModel>(
            (postModel) => PostModel.fromJson(postModel),
          )
          .toList();
      return jsonToPostModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final Map<String, dynamic> body = {
      "title": postModel.title,
      "body": postModel.body
    };

    final response = await client.post(
      Uri.parse("$baseUrlApi/posts/"),
      body: body,
    );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$baseUrlApi/posts/${postId.toString()}"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final String postId = postModel.id.toString();

    final Map<String, dynamic> body = {
      "title": postModel.title,
      "body": postModel.body
    };

    final response = await client.patch(
      Uri.parse("$baseUrlApi/posts/$postId"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
