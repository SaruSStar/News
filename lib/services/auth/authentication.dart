import 'package:news_application/models/models.dart';
import 'package:news_application/utils/database/datebase_helper_user.dart';
import 'package:news_application/utils/storage/storage.dart';

class Authentication {
  User? user;

  static Future<UserResponse> register({
    required String username,
    required String password,
    required String name,
  }) async {
    try {
      DatabaseHelperUser dbHelper = DatabaseHelperUser();
      // check wether user exist already if exist it will immediately return with message
      final isUserExist = await dbHelper.getUser(username) != null;
      if (isUserExist) {
        return UserResponse(
            status: 'error', message: "user already exist", totalResults: 0);
      }

      User user = User(name, username, password);
      final res = await dbHelper.saveUser(user);
      if (res == 1) {
        return UserResponse(
            status: 'ok',
            message: 'user registered successfuly',
            totalResults: 1,
            user: user);
      } else {
        return UserResponse(
            status: 'error',
            message: 'database failed creating user',
            totalResults: 0,
            user: null);
      }
    } catch (e) {
      return UserResponse(
          status: 'error', message: e.toString(), totalResults: 0, user: null);
    }
  }

  static Future<UserResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      DatabaseHelperUser dbHelper = DatabaseHelperUser();
      final isUserExist = await dbHelper.getUser(username) == null;
      if (isUserExist) {
        return UserResponse(
            status: 'error', message: "user does not exist", totalResults: 0);
      }
      final User? user = await dbHelper.loginUser(username, password);

      if (user != null) {
        return UserResponse(
            status: 'ok',
            message: 'user login successful',
            totalResults: 1,
            user: user);
      } else {
        return UserResponse(
            status: 'error',
            message: 'credentials does not match',
            totalResults: 0);
      }
    } catch (e) {
      return UserResponse(
          status: 'error', message: 'user login failed', totalResults: 0);
    }
  }

  static void logout() {
    Storage.removeUser();
  }

  static Future<User?> getCurrentUser() async {
    final username = await Storage.getUsername();
    DatabaseHelperUser dbHelper = DatabaseHelperUser();
    if (username == null) return null;
    final user = await dbHelper.getUser(username);
    return user;
  }
}
