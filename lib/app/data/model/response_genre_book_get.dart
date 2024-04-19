class ResponseGenreBook {
  ResponseGenreBook({
      this.status, 
      this.data,});

  ResponseGenreBook.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataGenre.fromJson(v));
      });
    }
  }
  String? status;
  List<DataGenre>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DataGenre {
  DataGenre({
      this.id, 
      this.genreId, 
      this.bookId, 
      this.createdAt, 
      this.updatedAt, 
      this.genre, 
      this.book,});

  DataGenre.fromJson(dynamic json) {
    id = json['id'];
    genreId = json['genre_id'];
    bookId = json['book_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    genre = json['genre'] != null ? Genre.fromJson(json['genre']) : null;
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
  }
  int? id;
  int? genreId;
  int? bookId;
  String? createdAt;
  String? updatedAt;
  Genre? genre;
  Book? book;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['genre_id'] = genreId;
    map['book_id'] = bookId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (genre != null) {
      map['genre'] = genre?.toJson();
    }
    if (book != null) {
      map['book'] = book?.toJson();
    }
    return map;
  }

}

class Book {
  Book({
      this.id, 
      this.cover, 
      this.title, 
      this.writer, 
      this.publisher, 
      this.synopsis, 
      this.rented, 
      this.rating, 
      this.status, 
      this.publishYear, 
      this.createdAt, 
      this.updatedAt,});

  Book.fromJson(dynamic json) {
    id = json['id'];
    cover = json['cover'];
    title = json['title'];
    writer = json['writer'];
    publisher = json['publisher'];
    synopsis = json['synopsis'];
    rented = json['rented'];
    rating = json['rating'].toDouble();
    status = json['status'];
    publishYear = json['publish_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? cover;
  String? title;
  String? writer;
  String? publisher;
  String? synopsis;
  int? rented;
  double? rating;
  String? status;
  int? publishYear;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cover'] = cover;
    map['title'] = title;
    map['writer'] = writer;
    map['publisher'] = publisher;
    map['synopsis'] = synopsis;
    map['rented'] = rented;
    map['rating'] = rating;
    map['status'] = status;
    map['publish_year'] = publishYear;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

class Genre {
  Genre({
      this.id, 
      this.genre, 
      this.createdAt, 
      this.updatedAt,});

  Genre.fromJson(dynamic json) {
    id = json['id'];
    genre = json['genre'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? genre;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['genre'] = genre;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}