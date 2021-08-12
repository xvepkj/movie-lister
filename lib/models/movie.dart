import 'package:hive/hive.dart';
part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String director;

  @HiveField(2)
  final String image;

  Movie({
    required this.name,
    required this.director,
    required this.image
  });
}