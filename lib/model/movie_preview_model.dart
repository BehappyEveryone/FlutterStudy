class MoviePreviewModel {
  final int id;
  final String posterImageUrl, title;

  MoviePreviewModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        posterImageUrl = json['poster_path'],
        title = json['title'];
}
