import 'package:flutter/material.dart';
import '../model/movie.dart';

class CustomDialogs {


  static void watchlistSuccessDialog(
      {required BuildContext context,
        required String val,
        required Movie movie,
        required Function func}) {
    String connect = val == 'added' ? 'to' : 'from';

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Watchlist',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'You successfully $val the movie \'${movie.title}\' $connect your watchlist.',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1A171E),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () {
              func();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }


}