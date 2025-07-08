import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_player/cores/title/sounds.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  late final Player player;
  late final VideoController videoController;

  @override
  void initState() {
    super.initState();
    player = Player();
    videoController = VideoController(player);

    // Set video source
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
          // Background video
          SizedBox.expand(
            child: Video(
              controller: videoController,
              controls: NoVideoControls,
              fit: BoxFit.cover,
            ),
          ),

          // Content overlay
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  color: Colors.black.withOpacity(0.6),
                  child: const Text(
                    'Karaoke Player',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                  ),
                ),

                // Buttons
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    _NavButton(text: 'title.play_songs'.tr(), redirect: '/player'),
                    const SizedBox(height: 10),
                    _NavButton(text: 'title.edit_songs'.tr(), redirect: '/editor'),
                    const SizedBox(height: 10),
                    _NavButton(text: 'title.settings'.tr(), redirect: '/settings'),
                    const SizedBox(height: 10),
                    _NavButton(text: 'title.quit'.tr(), redirect: '/quit'),
                  ],
                ),
              ],
            ),
          ),

          // Footer
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('Made with ❤️ by Wicky', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String text;
  final String redirect;

  const _NavButton({required this.text, required this.redirect});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, widget.redirect),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 300,
          height: 48,
          decoration: BoxDecoration(
            color: _isHovered ? const Color.fromARGB(255, 51, 51, 51) : Colors.black,
          ),
          alignment: Alignment.center,
          child: Text(widget.text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

