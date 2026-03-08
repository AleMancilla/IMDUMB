import 'package:imdumb/features/movies/data/models/movie_generes_model.dart';
import 'package:imdumb/features/movies/domain/entities/movie_generes.dart';


extension GenreMapper on GenreModel {
  Genre toEntity() {
    return Genre(id: id, name: name);
  }
}