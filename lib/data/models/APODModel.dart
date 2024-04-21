class APODModel {
  final String date;
  final String explanation;
  final String mediaType;
  final String title;
  final String url;

  APODModel({
    required this.date,
    required this.explanation,
    required this.mediaType,
    required this.title,
    required this.url,
  });

  factory APODModel.fromJson(Map<String, dynamic> json) {
    return APODModel(
      date: json['date'],
      explanation: json['explanation'],
      mediaType: json['media_type'],
      title: json['title'],
      url: json['url'],
    );
  }
}
