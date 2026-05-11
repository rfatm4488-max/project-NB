import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/journal.dart';
import '../providers/journal_provider.dart';
import 'category_screen.dart';

class AddEntryScreen extends StatefulWidget {
  final Journal? journal;
  const AddEntryScreen({super.key, this.journal});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _mood = '😊';
  String _category = 'يومي';

  final List<String> moods = ['😍', '😊', '😐', '😔', '😡', '😴'];
  final List<String> categories = ['يومي', 'عملي', 'أفكار', 'ذكريات'];

  @override
  void initState() {
    super.initState();
    if (widget.journal != null) {
      _titleController.text = widget.journal!.title;
      _contentController.text = widget.journal!.content;
      _mood = widget.journal!.mood;
      _category = widget.journal!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.journal != null;
    final localizations = AppLocalizations.of(context)!;
    final provider = Provider.of<JournalProvider>(context);

    return Directionality(
      textDirection: provider.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              isEditing ? localizations.editEntry : localizations.newEntry),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  localizations.chooseMood,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildMoodSelector(),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: localizations.title),
                  validator: (value) => value == null || value.isEmpty
                      ? localizations.enterTitle
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  maxLines: 8,
                  decoration: InputDecoration(labelText: localizations.content),
                  validator: (value) => value == null || value.isEmpty
                      ? localizations.enterContent
                      : null,
                ),
                const SizedBox(height: 16),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tileColor: Theme.of(context).cardColor,
                  title: Text(localizations.category),
                  subtitle: Text(_category, textAlign: TextAlign.end),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    final result = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CategoryScreen(selectedCategory: _category),
                      ),
                    );
                    if (result != null) {
                      setState(() => _category = result);
                    }
                  },
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () => _saveEntry(context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    isEditing
                        ? localizations.saveChanges
                        : localizations.addNote,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: moods.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final mood = moods[index];
          final selected = mood == _mood;
          return GestureDetector(
            onTap: () => setState(() => _mood = mood),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 80,
              decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  mood,
                  style: const TextStyle(fontSize: 42),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveEntry(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final provider = Provider.of<JournalProvider>(context, listen: false);
    final journal = Journal(
      id: widget.journal?.id,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      mood: _mood,
      category: _category,
      date: widget.journal?.date ?? DateTime.now(),
    );

    if (widget.journal != null) {
      provider.updateJournal(journal);
    } else {
      provider.addJournal(journal);
    }
    Navigator.pop(context);
  }
}
