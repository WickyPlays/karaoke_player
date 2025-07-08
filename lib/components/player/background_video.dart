import 'package:flutter/material.dart';
import 'package:karaoke_player/cores/settings/settings_core.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'dart:io';

class BackgroundVideo extends StatefulWidget {
  const BackgroundVideo({super.key});

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  late final Player player;
  late final VideoController videoController;

  Future<void> loadBackground() async {
    try {
      var bgDir = await getBackgroundsDirectory();
      final backgroundsDirectory = Directory(bgDir!);
      
      if (!await backgroundsDirectory.exists()) {
        print('Backgrounds directory does not exist');
        return;
      }
      
      final files = await backgroundsDirectory.list().toList();
      
      final videoFiles = files.where((file) {
        if (file is File) {
          final path = file.path.toLowerCase();
          return path.endsWith('.mp4') || 
                 path.endsWith('.mov') || 
                 path.endsWith('.avi') ||
                 path.endsWith('.mkv') || 
                 path.endsWith('.webm');
        }
        return false;
      }).toList();
      
      if (videoFiles.isNotEmpty) {
        final firstVideo = videoFiles.first as File;
        player.open(Media(firstVideo.path));
        player.setPlaylistMode(PlaylistMode.loop);
        player.setVolume(0);
        player.play();
      } else {
        print('No video files found in backgrounds directory');
        player.open(Media('asset:///assets/backgrounds/title.mp4'));
        player.setPlaylistMode(PlaylistMode.loop);
        player.setVolume(0);
        player.play();
      }
    } catch (e) {
      // Fallback to asset video if error occurs
      player.open(Media('asset:///assets/backgrounds/title.mp4'));
      player.setPlaylistMode(PlaylistMode.loop);
      player.setVolume(0);
      player.play();
    }
  }

  @override
  void initState() {
    super.initState();
    player = Player();
    videoController = VideoController(player);

    loadBackground();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Video(
        controller: videoController,
        controls: NoVideoControls,
        fit: BoxFit.cover,
      ),
    );
  }
}