
class MovieReviewsPage {
    int? id;
    int? page;
    List<MovieReview>? results;
    int? totalPages;
    int? totalResults;

    MovieReviewsPage({
        this.id,
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

}

class MovieReview {
    String? author;
    AuthorDetails? authorDetails;
    String? content;
    DateTime? createdAt;
    String? id;
    DateTime? updatedAt;
    String? url;

    MovieReview({
        this.author,
        this.authorDetails,
        this.content,
        this.createdAt,
        this.id,
        this.updatedAt,
        this.url,
    });

}

class AuthorDetails {
    String? name;
    String? username;
    String? avatarPath;
    double? rating;

    AuthorDetails({
        this.name,
        this.username,
        this.avatarPath,
        this.rating,
    });

}
