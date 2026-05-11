import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../models/journal.dart';
import '../providers/journal_provider.dart';
import 'add_entry_screen.dart';
import 'details_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final provider = Provider.of<JournalProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Directionality(
      textDirection: provider.locale.languageCode == 'ar'
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.appTitle),
          actions: [
            if (!isMobile) ...[
              IconButton(
                icon: const Icon(Icons.bar_chart),
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 450),
                    pageBuilder: (_, __, ___) => const StatsScreen(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                ),
              ),
            ],
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
          ],
        ),
        body: Consumer<JournalProvider>(
          builder: (context, provider, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 32,
                        vertical: 14,
                      ),
                      child: Column(
                        children: [
                          _buildSearchBar(context, localizations),
                          const SizedBox(height: 14),
                          _buildMoodFilters(context, localizations),
                          const SizedBox(height: 16),
                          Expanded(
                            child: _buildJournalList(
                              context,
                              provider.filteredJournals,
                              localizations,
                              isMobile,
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 450),
              pageBuilder: (_, __, ___) => const AddEntryScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          ),
          label: Text(localizations.addEntry),
          icon: const Icon(Icons.add),
        ),
        bottomNavigationBar:
            isMobile ? _buildBottomNavBar(context, localizations) : null,
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, AppLocalizations localizations) {
    return Consumer<JournalProvider>(
      builder: (context, provider, child) {
        return TextField(
          onChanged: provider.setSearchQuery,
          decoration: InputDecoration(
            hintText: localizations.search,
            prefixIcon: const Icon(Icons.search),
          ),
        );
      },
    );
  }

  Widget _buildMoodFilters(
      BuildContext context, AppLocalizations localizations) {
    const moods = ['😍', '😊', '😐', '😔', '😡', '😴'];
    return Consumer<JournalProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ChoiceChip(
                label: Text(localizations.filter),
                selected: provider.selectedMood == null,
                onSelected: (_) => provider.setMoodFilter(null),
              ),
              const SizedBox(width: 8),
              ...moods.map((mood) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Text(
                          mood,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    selected: provider.selectedMood == mood,
                    selectedColor: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha(51),
                    onSelected: (_) => provider.setMoodFilter(
                      provider.selectedMood == mood ? null : mood,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJournalList(BuildContext context, List<Journal> journals,
      AppLocalizations localizations, bool isMobile) {
    if (journals.isEmpty) {
      return Center(
        child: Text(
          localizations.noEntries,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.separated(
      itemCount: journals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final journal = journals[index];
        return _JournalCard(journal: journal, isMobile: isMobile);
      },
    );
  }

  Widget _buildBottomNavBar(
      BuildContext context, AppLocalizations localizations) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: localizations.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.bar_chart),
          label: localizations.stats,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: localizations.settings,
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            // Already on home
            break;
          case 1:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 450),
                pageBuilder: (_, __, ___) => const StatsScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
            break;
        }
      },
    );
  }
}

class _JournalCard extends StatelessWidget {
  final Journal journal;
  final bool isMobile;
  const _JournalCard({required this.journal, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd('ar').format(journal.date);
    final cardColor = _cardColor(context);
    final textColor =
        ThemeData.estimateBrightnessForColor(cardColor) == Brightness.dark
            ? Colors.white
            : Colors.black87;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 420),
          pageBuilder: (_, __, ___) => DetailsScreen(journal: journal),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(scale: animation, child: child);
          },
        ),
      ),
      child: Hero(
        tag: 'journal-${journal.id}',
        child: Card(
          color: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _accentColor(context),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    journal.mood,
                    style: TextStyle(fontSize: 36, color: textColor),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        journal.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: textColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formattedDate,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: textColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _cardColor(BuildContext context) {
    switch (journal.mood) {
      case '😍':
        return const Color(0xFFFFEBEE);
      case '😊':
        return const Color(0xFFFFF8E1);
      case '😐':
        return const Color(0xFFE3F2FD);
      case '😔':
        return const Color(0xFFEDE7F6);
      case '😡':
        return const Color(0xFFFFEBEE);
      case '😴':
        return const Color(0xFFE8EAF6);
      default:
        return Theme.of(context).cardColor;
    }
  }

  Color _accentColor(BuildContext context) {
    switch (journal.mood) {
      case '😍':
        return const Color(0xFFF8BBD0);
      case '😊':
        return const Color(0xFFFFF176);
      case '😐':
        return const Color(0xFF90CAF9);
      case '😔':
        return const Color(0xFFB39DDB);
      case '😡':
        return const Color(0xFFFF8A80);
      case '😴':
        return const Color(0xFF9FA8DA);
      default:
        return Theme.of(context).colorScheme.primary.withAlpha(51);
    }
  }
}
