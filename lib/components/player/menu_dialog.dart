import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuDialog extends StatelessWidget {
  final VoidCallback onClose;

  const MenuDialog({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.black.withValues(alpha: .54),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 600,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "player.menu_dialog.title".tr(),
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.normal, textBaseline: null),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 4,
                          ),
                        ),
                        onPressed: () {
                          onClose();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
                            (_) => false,
                          );
                        },
                        child: Text(
                          "player.menu_dialog.back_to_menu".tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 4,
                          ),
                        ),
                        onPressed: onClose,
                        child: Text(
                          "player.menu_dialog.cancel".tr(),
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
