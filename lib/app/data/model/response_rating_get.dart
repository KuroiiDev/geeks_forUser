class ResponseRatingGet {
  ResponseRatingGet({
      this.status, 
      this.data,});

  ResponseRatingGet.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataRating.fromJson(v));
      });
    }
  }
  String? status;
  List<DataRating>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DataRating {
  DataRating({
      this.id, 
      this.userId, 
      this.bookId, 
      this.rating, 
      this.createdAt, 
      this.updatedAt, 
      this.user, 
      this.book,});

  DataRating.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    bookId = json['book_id'];
    rating = json['rating'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
  }
  int? id;
  int? userId;
  int? bookId;
  double? rating;
  String? createdAt;
  String? updatedAt;
  User? user;
  Book? book;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['book_id'] = bookId;
    map['rating'] = rating;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
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

class User {
  User({
      this.id, 
      this.email, 
      this.profile, 
      this.name, 
      this.role, 
      this.createdAt, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    profile = json['profile'];
    name = json['name'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? email;
  String? profile;
  String? name;
  String? role;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['profile'] = profile;
    map['name'] = name;
    map['role'] = role;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}