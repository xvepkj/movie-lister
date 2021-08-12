import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:movie_lister/models/movie.dart';

class UpdateMovieForm extends StatefulWidget {
  final int index;
  final Movie movie;

  const UpdateMovieForm({
    required this.index,
    required this.movie,
  });

  @override
  _UpdateMovieFormState createState() => _UpdateMovieFormState();
}

class _UpdateMovieFormState extends State<UpdateMovieForm> {
  final _movieFormKey = GlobalKey<FormState>();

  late final _nameController;
  late final _directorController;
  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Update info of movie box
  _updateInfo() {
    Movie newMovie = Movie(
      name: _nameController.text,
      director: _directorController.text,
    );

    box.putAt(widget.index, newMovie);

    print('Info updated in box!');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('movieBox');
    _nameController = TextEditingController(text: widget.movie.name);
    _directorController = TextEditingController(text: widget.movie.director);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _movieFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name'),
          TextFormField(
            controller: _nameController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 24.0),
          Text('Home Country'),
          TextFormField(
            controller: _directorController,
            validator: _fieldValidator,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_movieFormKey.currentState!.validate()) {
                    _updateInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Update'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}