import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();

  static const _keyUserType = 'user_type'; // 'resident' or 'bql'
  static const _keyPhone = 'phone';
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';

  // Save Resident credentials
  static Future<void> saveResidentCredentials(String phone) async {
    await _storage.write(key: _keyUserType, value: 'resident');
    await _storage.write(key: _keyPhone, value: phone);
  }

  // Save BQL credentials
  static Future<void> saveBqlCredentials(String email, String password) async {
    await _storage.write(key: _keyUserType, value: 'bql');
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPassword, value: password);
  }

  // Get User Type
  static Future<String?> getUserType() async {
    return await _storage.read(key: _keyUserType);
  }

  // Get Resident Phone
  static Future<String?> getResidentPhone() async {
    return await _storage.read(key: _keyPhone);
  }

  // Get BQL Email
  static Future<String?> getBqlEmail() async {
    return await _storage.read(key: _keyEmail);
  }

  // Get BQL Password
  static Future<String?> getBqlPassword() async {
    return await _storage.read(key: _keyPassword);
  }

  // Clear credentials (on logout if needed)
  static Future<void> clearCredentials() async {
    await _storage.deleteAll();
  }
}
