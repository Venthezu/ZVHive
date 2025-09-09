class Post {
  final String id;
  final String userId;
  final String content;
  final List<String> images;
  final int likes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.images,
    required this.likes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      images: List<String>.from(json['images']),
      likes: json['likes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Comment {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}