import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_constants.dart';
import '../../controller/controller.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late  String movieTitle;

  MovieController movieController = Get.put(MovieController());
  String query = '';
  final formKey = GlobalKey<FormState>();

  Widget getSearch() {
    return GetBuilder<MovieController>(builder: (controller) {
      return movieController.searchedMovies.isNotEmpty
          ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.52),
          itemCount: movieController.searchedMovies.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                movieController.getDetail(
                    movieController.searchedMovies[index].id.toString());
                movieController.getCastList(
                    movieController.searchedMovies[index].id.toString());
                movieController.getSimilar(
                    movieController.searchedMovies[index].id.toString());
                Get.toNamed('/deatils');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      ApiConstants.baseImgUrl +
                          movieController.searchedMovies[index].posterPath
                              .toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                  child: Text(
                     movieController
                        .searchedMovies[index].originalTitle
                        .toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      backgroundColor: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
              ),
            );
          })
          : const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 150.0),
          child: Column(
            children: [
              Icon(
                Icons.local_movies,
                size: 100,
                color: Color(0xFFB5B4B4),
              ),
              Text(
                "No movies found",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFFB5B4B4),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: const BoxDecoration(),
              child: Center(
                child: TextFormField(
                  key: formKey,
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                    movieController.getMovieSearch(query);
                  },
                  autofocus:
                  movieController.searchedMovies.isEmpty ? true : false,
                  cursorColor:
                  Theme.of(context).primaryTextTheme.bodyText1?.color,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF514F4F),
                    hintText: 'Enter Movie Name',
                    hintStyle: const TextStyle(
                      color: Colors.white30,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white), // Set the border color here
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white), // Set the border color here
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          currentFocus.focusedChild?.unfocus();
                        }
                        movieController.getMovieSearch(query);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 20),
              child: Text('Top Results'),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                height: double.maxFinite,
                child: getSearch(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
