import 'dart:ui' as ui;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/journal_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إحصائيات المزاج')),
        body: Consumer<JournalProvider>(
          builder: (context, provider, child) {
            final counts = provider.moodDistributionForMonth();
            final moodLabels = ['😍', '😊', '😐', '😔', '😡', '😴'];
            return Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'اتجاهك العاطفي',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            provider.emotionSummary,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: BarChart(
                          BarChartData(
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index < 0 || index >= moodLabels.length)
                                      return const SizedBox();
                                    return Text(
                                      moodLabels[index],
                                      style: const TextStyle(fontSize: 18),
                                    );
                                  },
                                  reservedSize: 32,
                                ),
                              ),
                            ),
                            barGroups: moodLabels.asMap().entries.map((entry) {
                              final index = entry.key;
                              final mood = entry.value;
                              final count = counts[mood] ?? 0;
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: count.toDouble(),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    width: 24,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.end,
                    children: moodLabels.map((mood) {
                      return Chip(
                        label: Text(mood, style: const TextStyle(fontSize: 18)),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(31),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
