import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_player/components/settings/settings_directories.dart';
import 'package:karaoke_player/components/settings/settings_languages.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final Player player;
  late final VideoController videoController;
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    player = Player();
    videoController = VideoController(player);

    player.open(Media('asset:///assets/backgrounds/title.mp4'));
    player.setPlaylistMode(PlaylistMode.loop);
    player.setVolume(0);
    player.play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Video(
              controller: videoController,
              controls: NoVideoControls,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                border: Border.all(color: const Color(0xFF333333)),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 20, offset: Offset(0, -4))],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121212),
                      border: Border(bottom: BorderSide(color: const Color(0xFF333333))),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'settings.title'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Custom sidebar replacing NavigationRail
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFF121212),
                            border: Border(right: BorderSide(color: const Color(0xFF333333))),
                          ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              _buildSidebarItem(0, 'settings.general'.tr()),
                              _buildSidebarItem(1, 'settings.language'.tr()),
                              _buildSidebarItem(2, 'settings.lyrics.tab'.tr()),
                              _buildSidebarItem(3, 'settings.directories.tab'.tr()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: const Color(0xFF1E1E1E),
                            padding: const EdgeInsets.all(24),
                            child: SingleChildScrollView(
                              child: _buildActiveTabContent(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, String title) {
    return InkWell(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: _activeTab == index ? const Color(0xFF1E1E1E) : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _activeTab == index ? Colors.white : Colors.white.withValues(alpha: 0.6),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabContent() {
    switch (_activeTab) {
      case 0:
        return Text('settings.general.empty'.tr(), style: const TextStyle(color: Colors.white));
      case 1:
        return const SettingsLanguages();
      case 2:
        return const SettingsLyrics();
      case 3:
        return const SettingsDirectories();
      default:
        return Container();
    }
  }
}

class SettingsLyrics extends StatelessWidget {
  const SettingsLyrics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}