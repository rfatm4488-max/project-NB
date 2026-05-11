import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String selectedCategory;
  const CategoryScreen({super.key, required this.selectedCategory});

  static const categories = ['يومي', 'عملي', 'أفكار', 'ذكريات'];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('اختر التصنيف')),
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
