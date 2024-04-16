import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/genre_model.dart';
import '../pages/animation.dart';
import 'constants.dart';
import 'cubit/genre_results_cubit.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'genre_results.dart';

class GenreTile extends StatelessWidget {
  final Genres genre;
  const GenreTile({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          pushNewScreen(
              context,
              BlocProvider(
                create: (context) => GenreResultsCubit()..init(genre.id),
                child: GenreResults(query: genre.name),
              ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: genre.color,
            child: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: -5,
                  right: -20,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(380 / 360),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: genre.image,
                          fit: BoxFit.cover,
                          width: 60,
                          height: 75,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  child: Text(
                    genre.name,
                    textAlign: TextAlign.center,
                    style: normalText.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
