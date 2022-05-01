import 'package:news_application/utils/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  /// Prefs
  static Future<SharedPreferences> get _getPrefs async =>
      await SharedPreferences.getInstance();

  /// User
  static storeUsername(String uid) async {
    _getPrefs.then((prefs) {
      prefs.setString(StorageKeys.userKey, uid);
    });
  }

  static Future<String?> getUsername() {
    return _getPrefs.then(
      (prefs) => prefs.getString(StorageKeys.userKey),
    );
  }

  static Future<bool> isUserAvailable() async {
    final uid = await getUsername();
    if (uid == null) {
      return false;
    } else {
      return true;
    }
  }

  static removeUser() {
    _getPrefs.then((prefs) {
      prefs.remove(StorageKeys.userKey);
    });
  }
}
