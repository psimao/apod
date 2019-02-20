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
}
