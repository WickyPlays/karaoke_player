import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getBackgroundsDirectory() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('settings.directories.backgroundsPath');
}

Future<void> setBackgroundsDirectory(String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('settings.directories.backgroundsPath', value);
}

Future<String?> getSongsDirectory() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('settings.directories.songsPath');
}

Future<void> setSongsDirectory(String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('settings.directories.songsPath', value);
}

Future<bool?> isEnableTitleBackgroundMusic() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('settings.general.enableTitleBackgroundMusic');
}

Future<void> setEnableTitleBackgroundMusic(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('settings.general.enableTitleBackgroundMusic', value);
}
