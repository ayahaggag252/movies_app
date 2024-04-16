import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/genre_results_cubit.dart';

class GenreResults extends StatefulWidget {
  final String query;
  const GenreResults({
    super.key,
    required this.query,
  });

  @override
  State<GenreResults> createState() => _GenreResultsState();
}

class _GenreResultsState extends State<GenreResults> {
  ScrollController movieController = ScrollController();
  int currentPage = 0;
  late PageController pageViewController;

  @override
  void initState() {
    super.initState();
    pageViewController = PageController(
      initialPage: currentPage,
    );
    movieController.addListener(movieScrollListener);
    BlocProvider.of<GenreResultsCubit>(context).init(widget.query);
  }

  void movieScrollListener() {
    if (movieController.offset >= movieController.position.maxScrollExtent &&
        !movieController.position.outOfRange) {
      BlocProvider.of<GenreResultsCubit>(context).loadNextMoviePage();
    }
  }

  @override
  void dispose() {
    movieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GenreResultsCubit, GenreResultsState>(
        builder: (context, state) {
          return Column(
            children: [
              // Top Bar
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade900, width: 0.6))),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                        Text(
                          widget.query,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Movie List
              Expanded(
                child: buildMovieList(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildMovieList(GenreResultsState state) {
    switch (state.movieStatus) {
      case MovieStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case MovieStatus.loaded:
      case MovieStatus.adding:
        return ListView.builder(
          controller: movieController,
          itemCount: state.movies.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(state.movies[index].title.toString()),
            );
          },
        );
      case MovieStatus.error:
        return const Center(child: Text('Failed to load data'));
      default:
        return Container(); // Handle initial or other states as necessary
    }
  }
}
