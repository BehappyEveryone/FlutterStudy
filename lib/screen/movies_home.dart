import 'package:flutter/material.dart';
import 'package:study_toon/api/consts.dart';
import 'package:study_toon/api/movie_api.dart';
import 'package:study_toon/screen/movies_detail.dart';

import '../model/movie_preview_model.dart';
import '../model/movie_preview_type.dart';

class MoviesHomeScreen extends StatelessWidget {
  MoviesHomeScreen({Key? key}) : super(key: key);

  final Future<List<MoviePreviewModel>> popularList =
      MovieApi.getPopularMovies();
  final Future<List<MoviePreviewModel>> nowPlayingList =
      MovieApi.getNowPlayingMovies();
  final Future<List<MoviePreviewModel>> comingSoonList =
      MovieApi.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: getCategoryTitleText("Popular Movies"),
          ),
          SizedBox(
            height: 230,
            child: FutureBuilder(
              future: popularList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return makeList(snapshot, MoviePreviewType.popular);
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: getCategoryTitleText("Now in Cinemas"),
          ),
          SizedBox(
            height: 300,
            child: FutureBuilder(
              future: nowPlayingList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return makeList(snapshot, MoviePreviewType.nowPlaying);
                } else {
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: getCategoryTitleText("Coming soon"),
          ),
          SizedBox(
            height: 300,
            child: FutureBuilder(
              future: comingSoonList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return makeList(snapshot, MoviePreviewType.comingSoon);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  ListView makeList(
      AsyncSnapshot<List<MoviePreviewModel>> snapshot, MoviePreviewType type) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        final movie = snapshot.data![index];
        return getMoviePreviewWidget(type, movie);
      },
      separatorBuilder: (_, int index) {
        return const SizedBox(
          width: 15,
        );
      },
      itemCount: snapshot.data!.length,
    );
  }

  Widget getMoviePreviewWidget(MoviePreviewType type, MoviePreviewModel movie) {
    switch (type) {
      case MoviePreviewType.popular:
        return ImageMovieWidget(
          movie: movie,
          onClickMovie: goToDetail,
          type: type,
        );
      case MoviePreviewType.nowPlaying:
      case MoviePreviewType.comingSoon:
        return DefaultMovieWidget(
          movie: movie,
          onClickMovie: goToDetail,
          type: type,
        );
    }
  }

  Widget getCategoryTitleText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  void goToDetail(
      BuildContext context, MoviePreviewModel movie, MoviePreviewType type) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 600,
        ),
        pageBuilder: (_, __, ___) => MovieDetailScreen(
          movieId: movie.id,
          type: type,
          poster: movie.posterImageUrl,
        ),
      ),
    );
  }
}

class ImageMovieWidget extends StatelessWidget {
  const ImageMovieWidget({
    super.key,
    required this.movie,
    required this.onClickMovie,
    required this.type,
  });

  final MoviePreviewType type;
  final MoviePreviewModel movie;
  final Function onClickMovie;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "$type${movie.id}",
      child: GestureDetector(
        onTap: () => onClickMovie(context, movie, type),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(3, 5),
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          width: 330,
          child: Image.network(
            "${Consts.imageBaseUrl}${movie.posterImageUrl}",
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class DefaultMovieWidget extends StatelessWidget {
  const DefaultMovieWidget({
    super.key,
    required this.movie,
    required this.onClickMovie,
    required this.type,
  });

  final MoviePreviewModel movie;
  final Function onClickMovie;
  final MoviePreviewType type;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "$type${movie.id}",
      child: GestureDetector(
        onTap: () => onClickMovie(context, movie, type),
        child: SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(3, 5),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    "${Consts.imageBaseUrl}${movie.posterImageUrl}",
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  movie.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
