import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../providers/journal_provider.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final String selectedCategory;
  const CategoryScreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final provider = Provider.of<JournalProvider>(context);

    final categories = [
      localizations.categoryDaily,
      localizations.categoryWork,
      localizations.categoryIdeas,
      localizations.categoryMemories,
    ];

    return Directionality(
      textDirection: provider.locale.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(localizations.selectCategory)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              final selected = category == selectedCategory;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(category, textAlign: TextAlign.end),
                  trailing: selected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () => Navigator.pop(context, category),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
