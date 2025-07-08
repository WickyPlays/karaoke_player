import 'package:flutter/material.dart';
import 'package:karaoke_player/cores/settings/settings_core.dart';
import 'package:karaoke_player/cores/title/sounds.dart';

class SettingsGeneral extends StatefulWidget {
  const SettingsGeneral({super.key});

  @override
  _SettingsGeneralState createState() => _SettingsGeneralState();
}

class _SettingsGeneralState extends State<SettingsGeneral> {
  bool _enableTitleBackgroundMusic = false;

  @override
  void initState() {
    super.initState();
    _initSettings();
  }

  Future<void> _initSettings() async {
    final isTitleMusicEnabled = await isEnableTitleBackgroundMusic();
    setState(() {
      _enableTitleBackgroundMusic = isTitleMusicEnabled!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('Enable title background music'),
      value: _enableTitleBackgroundMusic,
      onChanged: (value) {
        setState(() {
          _enableTitleBackgroundMusic = value;
        });
        _handleEnableTitleBackgroundMusic(value);
      },
    );
  }

  Future<void> _handleEnableTitleBackgroundMusic(bool enabled) async {
    await setEnableTitleBackgroundMusic(enabled);
    if (!enabled) {
      await TitleSounds.stopBackgroundMusic();
    }
  }
}
