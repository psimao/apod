class Apod {
  static final TYPE_IMAGE = "image";
  static final TYPE_VIDEO = "video";

  static final firstApodDate = DateTime.utc(1995, 6, 20);

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

  static bool isValidApodDate(DateTime date) =>
      date.isAfter(Apod.firstApodDate.subtract(Duration(days: 1)));
}
