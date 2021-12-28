import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IUserRepository implements CRUDableRepository<UserProfile> {
  Future<List<UserOverview>> loadFriends(String ofUserId, int number);
  Future<int> loadNumberFriends(String ofUserId);
  Future<int> getIdUser(String username, String pass);
  Future<UserProfile> getUserProfile(String id);
  Future<List<Post>> getListPost(String id);
  Future<List<UserOverview>> searchUser(String query);
  Future<bool> isFriend(String id);
  Future<void> follow(String? id);
  Future<void> unfollow(String? id);
}
