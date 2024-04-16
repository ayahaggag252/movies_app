import 'package:flutter/material.dart';

class VerticalMovieCard extends StatefulWidget {
  final String imgUrl , movieTitle;
  final Function() onTap;
  final double width;

  const VerticalMovieCard(
      {super.key, required this.imgUrl, required this.onTap, this.width = 180,    required this.movieTitle,});

  @override
  State<VerticalMovieCard> createState() => _VerticalMovieCardState();
}

class _VerticalMovieCardState extends State<VerticalMovieCard> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        margin: const EdgeInsets.only(left: 12),

        child: Stack(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(widget.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              child: IconButton(

                onPressed: () {
                  setState(
                        () {
                      isClicked = !isClicked;
                    },
                  );
                },
                icon: Icon(

                  size: 40,
                  isClicked
                      ? Icons.bookmark_added_sharp
                      : Icons.bookmark_add_outlined,
                  color: isClicked
                      ? Colors.yellowAccent
                      : Colors.grey,
                ),
              ),
            ),
          /* Positioned(
             top: 0,
             right: 0,
             child: Text(
                    widget.movieTitle,
                    style: const TextStyle(
                      fontSize: 5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,


              ),
           ),*/
          ],
        ),
      ),
    );

  }
}
