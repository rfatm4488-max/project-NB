import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/journal_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final provider = Provider.of<JournalProvider>(context);

    return Directionality(
      textDirection: provider.locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(localizations.settings)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SwitchListTile(
                  title: Text(localizations.darkMode),
                  subtitle: Text(provider.isDarkMode
                      ? 'الوضع الداكن مفعل'
                      : 'الوضع الفاتح مفعل'),
                  value: provider.isDarkMode,
                  onChanged: (_) => provider.toggleTheme(),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(localizations.language),
                  subtitle: Text(provider.locale.languageCode == 'ar'
                      ? localizations.arabic
                      : localizations.english),
                  trailing: DropdownButton<Locale>(
                    value: provider.locale,
                    items: [
                      DropdownMenuItem(
                        value: const Locale('ar'),
                        child: Text(localizations.arabic),
                      ),
                      DropdownMenuItem(
                        value: const Locale('en'),
                        child: Text(localizations.english),
                      ),
                    ],
                    onChanged: (locale) {
                      if (locale != null) {
                        provider.setLocale(locale);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
