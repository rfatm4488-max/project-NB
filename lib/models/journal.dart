class Journal {
  final int? id;
  final String title;
  final String content;
  final String mood;
  final String category;
  final DateTime date;

  Journal({
    this.id,
    required this.title,
    required this.content,
    required this.mood,
    required this.category,
    required this.date,
  });

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      mood: map['mood'] as String,
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'mood': mood,
      'category': category,
      'date': date.toIso8601String(),
    };
  }
}
