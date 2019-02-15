class Apod {
  static final TYPE_IMAGE = "image";
  static final TYPE_VIDEO = "video";

  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String title;
  final String url;

  Apod(
      {this.copyright,
      this.date,
      this.explanation,
      this.hdurl,
      this.mediaType,
      this.title,
      this.url});

  factory Apod.fromJson(Map<String, dynamic> json) => Apod(
      copyright: json["copyright"],
      date: json["date"],
      explanation: json["explanation"],
      hdurl: json.containsKey("hdurl") ? json["hdurl"] : null,
      mediaType: json["media_type"],
      title: json["title"],
      url: json["url"]);
}
