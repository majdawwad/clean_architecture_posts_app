import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;

  GetAllPostsUseCase(
    this.repository,
  );

  Future<Either<Failure, List<Post>>> call() async{
    return repository.getAllPosts();
  }
}
