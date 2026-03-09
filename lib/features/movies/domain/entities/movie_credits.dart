class MovieCredits {
    int? id;
    List<Cast>? cast;
    List<Cast>? crew;

    MovieCredits({
        this.id,
        this.cast,
        this.crew,
    });

}

class Cast {
    bool? adult;
    int? gender;
    int? id;
    String? knownForDepartment;
    String? name;
    String? originalName;
    double? popularity;
    String? profilePath;
    int? castId;
    String? character;
    String? creditId;
    int? order;
    String? department;
    String? job;

    Cast({
        this.adult,
        this.gender,
        this.id,
        this.knownForDepartment,
        this.name,
        this.originalName,
        this.popularity,
        this.profilePath,
        this.castId,
        this.character,
        this.creditId,
        this.order,
        this.department,
        this.job,
    });

}
