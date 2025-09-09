class Comic {
  final String id;
  final String title;
  final ComicType type;
  final String coverUrl;
  final String description;
  final List<Chapter> chapters;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comic({
    required this.id,
    required this.title,
    required this.type,
    required this.coverUrl,
    required this.description,
    required this.chapters,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      title: json['title'],
      type: ComicType.values.firstWhere((e) => e.name == json['type']),
      coverUrl: json['cover_url'],
      description: json['description'],
      chapters: List<Chapter>.from(json['chapters'].map((x) => Chapter.fromJson(x))),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Chapter {
  final String id;
  final String title;
  final int chapterNumber;
  final List<String> pages;
  final DateTime createdAt;

  Chapter({
    required this.id,
    required this.title,
    required this.chapterNumber,
    required this.pages,
    required this.createdAt,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      title: json['title'],
      chapterNumber: json['chapter_number'],
      pages: List<String>.from(json['pages']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

enum ComicType { comic, manhwa, manhua }