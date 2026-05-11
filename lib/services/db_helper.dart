import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/journal.dart';

class DbHelper {
  static const _journalsKey = 'mufakkirati_journals';
  static const _lastIdKey = 'mufakkirati_last_id';
  static final DbHelper instance = DbHelper._privateConstructor();

  DbHelper._privateConstructor();

  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  Future<List<Journal>> fetchJournals() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_journalsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final list = jsonDecode(jsonString) as List<dynamic>;
    final journals = list
        .map((item) => Journal.fromMap(item as Map<String, dynamic>))
        .toList();
    journals.sort((a, b) => b.date.compareTo(a.date));
    return journals;
  }

  Future<int> insertJournal(Journal journal) async {
    final prefs = await _prefs;
    final currentId = prefs.getInt(_lastIdKey) ?? 0;
    final nextId = currentId + 1;
    final newJournal = Journal(
      id: nextId,
      title: journal.title,
      content: journal.content,
      mood: journal.mood,
      category: journal.category,
      date: journal.date,
    );
    final journals = await fetchJournals();
    journals.insert(0, newJournal);
    await prefs.setString(
        _journalsKey, jsonEncode(journals.map((e) => e.toMap()).toList()));
    await prefs.setInt(_lastIdKey, nextId);
    return nextId;
  }

  Future<int> updateJournal(Journal journal) async {
    final prefs = await _prefs;
    final journals = await fetchJournals();
    final index = journals.indexWhere((item) => item.id == journal.id);
    if (index == -1) {
      return 0;
    }
    journals[index] = journal;
    journals.sort((a, b) => b.date.compareTo(a.date));
    await prefs.setString(
        _journalsKey, jsonEncode(journals.map((e) => e.toMap()).toList()));
    return 1;
  }

  Future<int> deleteJournal(int id) async {
    final prefs = await _prefs;
    final journals = await fetchJournals();
    final beforeCount = journals.length;
    journals.removeWhere((journal) => journal.id == id);
    final afterCount = journals.length;
    await prefs.setString(
        _journalsKey, jsonEncode(journals.map((e) => e.toMap()).toList()));
    return beforeCount - afterCount;
  }

  Future<List<Journal>> searchJournals(String query) async {
    final journals = await fetchJournals();
    return journals
        .where((journal) =>
            journal.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Journal>> filterByMood(String mood) async {
    final journals = await fetchJournals();
    return journals.where((journal) => journal.mood == mood).toList();
  }
}
