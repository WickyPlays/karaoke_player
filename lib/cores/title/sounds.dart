import 'package:audioplayers/audioplayers.dart';

class TitleSounds {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> playBackgroundMusic() async {
    if (_isPlaying) return;
    
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('se/standby.mp3'));
      _isPlaying = true;
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  // Stop background music
  static Future<void> stopBackgroundMusic() async {
    if (!_isPlaying) return;
    
    try {
      await _player.stop();
      _isPlaying = false;
    } catch (e) {
      print('Error stopping background music: $e');
    }
  }

  static bool get isMusicPlaying => _isPlaying;
}