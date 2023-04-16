class MovieDetailModel {
  final String title, overview,homepage;
  final bool isAdult;
  final List<String> genres;
  final int id, runtime, voteCount;
  final double voteAverage;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        homepage = json['homepage'],
        overview = json['overview'],
        isAdult = json['adult'],
        genres = (json['genres'] as List<dynamic>)
            .map((genre) => GenreModel.fromJson(genre).name)
            .toList(),
        runtime = json['runtime'],
        voteCount = json['vote_count'],
        voteAverage = json['vote_average'];
}

class GenreModel {
  final int id;
  final String name;

  GenreModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
