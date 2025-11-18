import 'package:commet_chat/core/services/logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

class User {
  static final User _instance = User.internal();
  User.internal();
  factory User() => _instance;

  late final Box userBox;

  Map _details = {};

  get userId => _details['_id'];
  get registrationStatus => _details['profileStatus']['registration'];
  get varificationStatus => _details['profileStatus']['verification'];

  init() async {
    userBox = await Hive.openBox("User");

    _details = userBox.get("details") ?? {};

    logger.d(_details);
  }

  store(Map details) async {
    _details = details;
    await userBox.put("details", details);
  }

  clear() async {
    _details.clear();
    await userBox.delete("details");
  }
}
