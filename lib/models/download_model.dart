class DownloadResult {
  final String title;
  final String thumbnail;
  final List<DownloadOption> options;
  final String platform;

  DownloadResult({
    required this.title,
    required this.thumbnail,
    required this.options,
    required this.platform,
  });

  factory DownloadResult.fromJson(Map<String, dynamic> json) {
    return DownloadResult(
      title: json['title'],
      thumbnail: json['thumbnail'],
      options: List<DownloadOption>.from(json['options'].map((x) => DownloadOption.fromJson(x))),
      platform: json['platform'],
    );
  }
}

class DownloadOption {
  final String quality;
  final String size;
  final String url;
  final String format;

  DownloadOption({
    required this.quality,
    required this.size,
    required this.url,
    required this.format,
  });

  factory DownloadOption.fromJson(Map<String, dynamic> json) {
    return DownloadOption(
      quality: json['quality'],
      size: json['size'],
      url: json['url'],
      format: json['format'],
    );
  }
}