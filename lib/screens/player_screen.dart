import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karaoke_player/components/player/background_video.dart';
import 'package:karaoke_player/components/player/menu_dialog.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isDialogVisible = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showDialog() {
    setState(() {
      _isDialogVisible = true;
    });
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MenuDialog(
          onClose: () {
            Navigator.of(context).pop();
            setState(() {
              _isDialogVisible = false;
            });
            _focusNode.requestFocus();
          },
        );
      },
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      if (_isDialogVisible) {
        Navigator.of(context).pop();
        setState(() {
          _isDialogVisible = false;
        });
      } else {
        _showDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKeyEvent,
        child: Stack(
          children: [
            const BackgroundVideo(),
          ],
        ),
      ),
    );
  }
}