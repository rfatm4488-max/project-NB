import 'package:flutter/material.dart';
import '../models/journal.dart';
import '../services/db_helper.dart';

class JournalProvider extends ChangeNotifier {
  final List<Journal> _journals = [];
  bool _isDarkMode = false;
  String? _selectedMood;
  String _searchQuery = '';
  bool _isLoading = true;
  Locale _locale = const Locale('ar');

  JournalProvider() {
    _loadJournals();
  }

  List<Journal> get journals => List.unmodifiable(_journals);
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;
  String? get selectedMood => _selectedMood;
  String get searchQuery => _searchQuery;
  Locale get locale => _locale;

  List<Journal> get filteredJournals {
    return _journals.where((journal) {
      final matchesMood =
          _selectedMood == null || journal.mood == _selectedMood;
      final matchesSearch = journal.title.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchesMood && matchesSearch;
    }).toList();
  }

  Future<void> _loadJournals() async {
    _isLoading = true;
    notifyListeners();
    final data = await DbHelper.instance.fetchJournals();
    _journals.clear();
    _journals.addAll(data);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addJournal(Journal journal) async {
    final id = await DbHelper.instance.insertJournal(journal);
    _journals.insert(
      0,
      Journal(
        id: id,
        title: journal.title,
        content: journal.content,
        mood: journal.mood,
        category: journal.category,
        date: journal.date,
      ),
    );
    notifyListeners();
  }

  Future<void> updateJournal(Journal journal) async {
    await DbHelper.instance.updateJournal(journal);
    final index = _journals.indexWhere((element) => element.id == journal.id);
    if (index != -1) {
      _journals[index] = journal;
      notifyListeners();
    }
  }

  Future<void> deleteJournal(int id) async {
    await DbHelper.instance.deleteJournal(id);
    _journals.removeWhere((journal) => journal.id == id);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setMoodFilter(String? mood) {
    _selectedMood = mood;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  Map<String, int> moodDistributionForMonth() {
    final now = DateTime.now();
    final filtered = _journals.where(
      (journal) =>
          journal.date.year == now.year && journal.date.month == now.month,
    );
    final counts = <String, int>{
      '😍': 0,
      '😊': 0,
      '😐': 0,
      '😔': 0,
      '😡': 0,
      '😴': 0,
    };
    for (final journal in filtered) {
      counts[journal.mood] = (counts[journal.mood] ?? 0) + 1;
    }
    return counts;
  }

  String get emotionSummary {
    final counts = moodDistributionForMonth();
    final positive = (counts['😍'] ?? 0) + (counts['😊'] ?? 0);
    final negative =
        (counts['😔'] ?? 0) + (counts['😡'] ?? 0) + (counts['😴'] ?? 0);
    final trend = positive >= negative
        ? 'اتجاه إيجابي مستمر هذا الشهر.'
        : 'المزاج يحتاج دفعة لطيفة هذا الشهر.';
    return 'أنت شاركت مشاعرك بوضوح. $trend';
  }
}
