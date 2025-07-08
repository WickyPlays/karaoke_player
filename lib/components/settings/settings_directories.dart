import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform/platform.dart';

class SettingsDirectories extends StatefulWidget {
  const SettingsDirectories({super.key});

  @override
  _SettingsDirectoriesState createState() => _SettingsDirectoriesState();
}

class _SettingsDirectoriesState extends State<SettingsDirectories> {
  String backgroundsDir = '';
  String songsDir = '';
  final LocalPlatform platform = const LocalPlatform();

  @override
  void initState() {
    super.initState();
    _initDirectories();
  }

  Future<void> _initDirectories() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundsDir = prefs.getString('settings.directories.backgroundsPath') ?? '';
      songsDir = prefs.getString('settings.directories.songsPath') ?? '';
    });
  }

  Future<void> _selectBackgroundsDirectory() async {
    String? selectedDirectory;
    
    if (platform.isAndroid || platform.isIOS) {
      // For mobile platforms
      try {
        selectedDirectory = await FilePicker.platform.getDirectoryPath();
      } catch (e) {
        debugPrint('Error selecting backgrounds directory: $e');
      }
    } else {
      // For desktop platforms
      try {
        selectedDirectory = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Select Backgrounds Directory',
          initialDirectory: backgroundsDir.isNotEmpty ? backgroundsDir : null,
        );
      } catch (e) {
        debugPrint('Error selecting backgrounds directory: $e');
      }
    }

    if (selectedDirectory != null) {
      setState(() {
        backgroundsDir = selectedDirectory!;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('settings.directories.backgroundsPath', selectedDirectory);
    }
  }

  Future<void> _selectSongsDirectory() async {
    String? selectedDirectory;
    
    if (platform.isAndroid || platform.isIOS) {
      // For mobile platforms
      try {
        selectedDirectory = await FilePicker.platform.getDirectoryPath();
      } catch (e) {
        debugPrint('Error selecting songs directory: $e');
      }
    } else {
      // For desktop platforms
      try {
        selectedDirectory = await FilePicker.platform.getDirectoryPath(
          dialogTitle: 'Select Songs Directory',
          initialDirectory: songsDir.isNotEmpty ? songsDir : null,
        );
      } catch (e) {
        debugPrint('Error selecting songs directory: $e');
      }
    }

    if (selectedDirectory != null) {
      setState(() {
        songsDir = selectedDirectory!;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('settings.directories.songsPath', selectedDirectory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDirectorySetting(
            label: 'settings.directories.backgrounds_path'.tr(),
            directory: backgroundsDir,
            onSelect: _selectBackgroundsDirectory,
          ),
          const SizedBox(height: 20),
          _buildDirectorySetting(
            label: 'settings.directories.songs_path'.tr(),
            directory: songsDir,
            onSelect: _selectSongsDirectory,
          ),
        ],
      ),
    );
  }

  Widget _buildDirectorySetting({
    required String label,
    required String directory,
    required VoidCallback onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      directory.isEmpty ? 'Not selected' : directory,
                      style: TextStyle(
                        color: directory.isEmpty ? Colors.grey : Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.folder_open),
                  onPressed: onSelect,
                  tooltip: 'settings.directories.select_folder'.tr(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}