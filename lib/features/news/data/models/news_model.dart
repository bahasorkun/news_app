class NewsModel {
  final String key;
  final String url;
  final String description;
  final String image;
  final String name;
  final String source;

  NewsModel({
    required this.key,
    required this.url,
    required this.description,
    required this.image,
    required this.name,
    required this.source,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      key: json['key'] ?? " ",
      url: json["url"] ?? '',
      description: json['description'] ?? " ",
      image: json['image'] ?? " ",
      name: json['name'] ?? " ",
      source: json['source'] ?? " ",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'url': url,
      'description': description,
      'image': image,
      'name': name,
      'source': source,
    };
  }
}
