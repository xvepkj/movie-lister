import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_lister/models/movie.dart';

class AddMovieForm extends StatefulWidget {
  const AddMovieForm({Key? key}) : super(key: key);

  @override
  _AddMovieFormState createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<AddMovieForm> {
  final _nameController = TextEditingController();
  final _directorController = TextEditingController();
  final _movieFormKey = GlobalKey<FormState>();
  var _image;
  var imagePicker;
  late XFile image;
  late final Box box;

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  // Add info to movie box
  _addInfo() async {
    Movie newMovie = Movie(
      name: _nameController.text,
      director: _directorController.text,
      image: image.path
    );

    box.add(newMovie);
    print('Info added to box!');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('movieBox');
    imagePicker = new ImagePicker();
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
          Text('Director'),
          TextFormField(
            controller: _directorController,
            validator: _fieldValidator,
          ),
          Spacer(),
          Center(
            child: GestureDetector(
              onTap: () async {
                image = await imagePicker.pickImage(
                    source: ImageSource.gallery, imageQuality: 50);
                setState(() {
                  _image = File(image.path);
                });
              },
              child: Container(
                width: 214,
                height: 320,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor),
                child: _image != null
                    ? Image.file(
                  _image,
                  width: 214.0,
                  height: 320.0,
                  fit: BoxFit.fitHeight,
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor),
                  width: 214,
                  height: 320,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_movieFormKey.currentState!.validate() && _image!=null) {
                    _addInfo();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}