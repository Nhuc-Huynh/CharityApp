import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/repositories/activeuser_repository.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class ActiveUserRepositoryImp extends IActiveUserRepository {
  final user = FirebaseFirestore.instance.collection("activeusers");
  UserRepositoryImp _userRepositoryImp = new UserRepositoryImp();
  @override
  Future<List<UserOverview>> loadActiveUser() async {
    List<UserOverview> listactiveuser = [];
    try {
      var users;
      await user.get().then((querySnapshot) async {
        for (var element in querySnapshot.docs) {
          if (element.data()['id'] !=
              GetIt.instance.get<Authenticator>().userProfile.id) {
            users =
                await _userRepositoryImp.getUserOverView(element.data()['id']);
            listactiveuser.add(users);
          }
        }
      });
      return listactiveuser;
    } catch (e) {
      print("Error load list active user" + e.toString());
      return listactiveuser;
    }
  }

  @override
  Future<void> addActiveUser(String id) async {
    try {
      await user.get().then((value) async {
        for (var user in value.docs) {
          if (user['id'] == id) return;
        }
        await user
            .add({'id': id})
            .then((value) => print("Active user Added"))
            .catchError((error) => print("Failed to add user: $error"));
      });
    } catch (e) {
      print("Error add actieuser:" + e.toString());
    }
  }

  @override
  Future<void> deleteActiveUser(String id) async {
    try {
      await user.doc(id).delete();
    } catch (e) {
      print("Error add actieuser:" + e.toString());
    }
  }
}
