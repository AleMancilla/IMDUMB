import 'package:imdumb/features/movies/data/models/movie_details_model.dart';
import 'package:imdumb/features/movies/domain/entities/movie_details.dart' as entity;

import 'movie_generes_mapper.dart';

extension MovieDetailsMapper on MovieDetailsModel {
  entity.MovieDetails toEntity() {
    return entity.MovieDetails(
      adult: adult,
      backdropPath: backdropPath,
      belongsToCollection: belongsToCollection?.toEntity(),
      budget: budget,
      genres: genres?.map((g) => g.toEntity()).toList(),
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies: productionCompanies?.map((c) => c.toEntity()).toList(),
      productionCountries: productionCountries?.map((c) => c.toEntity()).toList(),
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      spokenLanguages: spokenLanguages?.map((s) => s.toEntity()).toList(),
      status: status,
      tagline: tagline,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}

extension BelongsToCollectionMapper on BelongsToCollectionModel {
  entity.BelongsToCollection toEntity() {
    return entity.BelongsToCollection(
      id: id,
      name: name,
      posterPath: posterPath,
      backdropPath: backdropPath,
    );
  }
}

extension ProductionCompanyMapper on ProductionCompanyModel {
  entity.ProductionCompany toEntity() {
    return entity.ProductionCompany(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }
}

extension ProductionCountryMapper on ProductionCountryModel {
  entity.ProductionCountry toEntity() {
    return entity.ProductionCountry(
      iso31661: iso31661,
      name: name,
    );
  }
}

extension SpokenLanguageMapper on SpokenLanguageModel {
  entity.SpokenLanguage toEntity() {
    return entity.SpokenLanguage(
      englishName: englishName,
      iso6391: iso6391,
      name: name,
    );
  }
}
