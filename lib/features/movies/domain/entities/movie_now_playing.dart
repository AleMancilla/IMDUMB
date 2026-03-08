class MovieNowPlayingPage {
    Dates? dates;
    int? page;
    List<MovieNowPlaying>? movieNowPlaying;
    int? totalPages;
    int? totalResults;

    MovieNowPlayingPage({
        this.dates,
        this.page,
        this.movieNowPlaying,
        this.totalPages,
        this.totalResults,
    });

}

class Dates {
    DateTime? maximum;
    DateTime? minimum;

    Dates({
        this.maximum,
        this.minimum,
    });

}

class MovieNowPlaying {
    bool? adult;
    String? backdropPath;
    List<int>? genreIds;
    int? id;
    OriginalLanguage? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    DateTime? releaseDate;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    MovieNowPlaying({
        this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
    });

}

enum OriginalLanguage {
    EN,
    ES,
    FI
}
