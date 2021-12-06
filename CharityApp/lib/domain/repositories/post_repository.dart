import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IPostRepository implements CRUDableRepository<Post>{
  Stream<List<UserComment>> loadComments(String id, int number);
}