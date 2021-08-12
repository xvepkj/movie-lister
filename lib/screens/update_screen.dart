import 'package:flutter/material.dart';

import 'package:movie_lister/models/movie.dart';
import 'package:movie_lister/utils/update_movie_form.dart';

class UpdateScreen extends StatefulWidget {
  final int index;
  final Movie movie;

  const UpdateScreen({
    required this.index,
    required this.movie,
  });

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Update Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UpdateMovieForm(
          index: widget.index,
          movie: widget.movie,
        ),
      ),
    );
  }
}