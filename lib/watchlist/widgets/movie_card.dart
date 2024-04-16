import 'package:flutter/material.dart';
class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movieId,
    required this.title,
    required this.releaseDate,
    required this.image,
    required this.onWatchlistPressed,
  }) : super(key: key);

  final int movieId;
  final String title;
  final String releaseDate;
  final String image;
  final Function onWatchlistPressed;

  final String imageBaseUrl = "https://image.tmdb.org/t/p/original";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF696969),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageBaseUrl + image),
                      fit: BoxFit.fill),
                ),
              ),
              IconButton(
                onPressed: onWatchlistPressed(),
                icon: const Icon(
                  Icons.bookmark_add,
                  color: Color(0xFFF7B539),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            padding: const EdgeInsets.all(16.0),
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            onWatchlistPressed();
                          },
                          child: const Icon(Icons.remove_red_eye),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              Text(
                releaseDate,
                style: TextStyle(
                  color: Colors.white30,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
