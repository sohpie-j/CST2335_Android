import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Repository {
  final storage = const FlutterSecureStorage();
  Future<void> saveData(String key, String value) async {
    await storage.write(key: key, value: value);
  }
  Future<String?> loadData(String key) async {
    return await storage.read(key: key);
  }
}
