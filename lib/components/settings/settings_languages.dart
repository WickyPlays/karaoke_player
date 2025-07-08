import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsLanguages extends StatelessWidget {
  const SettingsLanguages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final currentValue = '${currentLocale.languageCode}-${currentLocale.countryCode}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'settings.language'.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.23),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentValue,
                isExpanded: true,
                dropdownColor: Colors.grey[900],
                padding: const EdgeInsets.symmetric(horizontal: 16),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'en-US',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'vi-VN',
                    child: Text('Vietnamese'),
                  ),
                ],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    final parts = newValue.split('-');
                    if (parts.length == 2) {
                      context.setLocale(Locale(parts[0], parts[1]));
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}