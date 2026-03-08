class MovieGeneresModel {
    List<Genre> genres;

    MovieGeneresModel({
        required this.genres,
    });

}

class Genre {
    int id;
    String name;

    Genre({
        required this.id,
        required this.name,
    });

}
