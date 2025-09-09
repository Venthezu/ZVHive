class Anime {
  final String id;
  final String title;
  final AnimeType type;
  final String coverUrl;
  final String description;
  final List<Episode> episodes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Anime({
    required this.id,
    required this.title,
    required this.type,
    required this.coverUrl,
    required this.description,
    required this.episodes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'],
      title: json['title'],
      type: AnimeType.values.firstWhere((e) => e.name == json['type']),
      coverUrl: json['cover_url'],
      description: json['description'],
      episodes: List<Episode>.from(json['episodes'].map((x) => Episode.fromJson(x))),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Episode {
  final String id;
  final String title;
  final int episodeNumber;
  final String videoUrl;
  final String? subtitleUrl;
  final DateTime createdAt;

  Episode({
    required this.id,
    required this.title,
    required this.episodeNumber,
    required this.videoUrl,
    this.subtitleUrl,
    required this.createdAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      title: json['title'],
      episodeNumber: json['episode_number'],
      videoUrl: json['video_url'],
      subtitleUrl: json['subtitle_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

enum AnimeType { anime, donghua }