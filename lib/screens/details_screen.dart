import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/journal.dart';
import '../providers/journal_provider.dart';
import 'add_entry_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Journal journal;
  const DetailsScreen({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMEEEEd('ar').format(journal.date);
    final localizations = AppLocalizations.of(context)!;
    final provider = Provider.of<JournalProvider>(context);

    return Directionality(
      textDirection: provider.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.details),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEntryScreen(journal: journal),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Hero(
            tag: 'journal-${journal.id}',
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: Text(
                          journal.mood,
                          style: const TextStyle(fontSize: 64),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      journal.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Chip(label: Text(journal.category)),
                        const SizedBox(width: 12),
                        Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          journal.content,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(height: 1.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations.deleteEntryTitle),
          content: Text(localizations.deleteEntryConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () {
                Provider.of<JournalProvider>(
                  context,
                  listen: false,
                ).deleteJournal(journal.id!);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(localizations.delete,
                  style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
