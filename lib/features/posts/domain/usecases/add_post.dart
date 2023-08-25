import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository repository;

  AddPostUseCase(
    this.repository,
  );

  Future<Either<Failure, Unit>> call(Post post) async{
     return await repository.addPost(post);
  }
}