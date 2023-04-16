import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:study_toon/model/movie_preview_type.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../api/consts.dart';
import '../api/movie_api.dart';
import '../model/movie_detail_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final String poster;
  final MoviePreviewType type;
  final int movieId;

  const MovieDetailScreen({
    Key? key,
    required this.movieId,
    required this.poster,
    required this.type,
  }) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();

    movie = MovieApi.getDetailMovie(widget.movieId);
  }

  void onPressBackButton() {}

  void onClickBuyTicket() async {
    movie.then((value) async {
      await launchUrlString(value.homepage);
    });
  }

  String getRuntimeFormat(int runtime) {
    String time;
    if (runtime > 60) {
      var hour = runtime ~/ 60;
      var min = runtime % 60;
      time = "${hour}h ${min}min";
    } else {
      time = "${runtime}min";
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${widget.type}${widget.movieId}",
      child: Material(
        type: MaterialType.transparency,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
                iconSize: 30,
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                onPressed: onPressBackButton),
            toolbarHeight: 100,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Back To List",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "${Consts.imageBaseUrl}${widget.poster}",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.9)
                    ]),
              ),
              child: Column(
                children: [
                  Flexible(
                      flex: 6,
                      child: FutureBuilder(
                        future: movie,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    snapshot.data!.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyRatingBar(rating: snapshot.data!.voteAverage/2, size: 25,),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "${getRuntimeFormat(snapshot.data!.runtime)} | ${snapshot.data!.genres.join(',')}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  const Text(
                                    "Storyline",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data!.overview,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      )),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onClickBuyTicket,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 90,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(15),
                          color: Colors.yellow.shade600,
                        ),
                        child: const Text(
                          "Buy ticket",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyRatingBar extends StatelessWidget {
  final double rating;
  final double size;

  const MyRatingBar({Key? key, required this.rating, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      tapOnlyMode: true,
      itemSize: size,
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ), onRatingUpdate: (double value) {  },
    );
  }
}

