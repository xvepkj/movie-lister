import 'package:hive/hive.dart';
part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String director;

  Movie({
    required this.name,
    required this.director,
  });
}