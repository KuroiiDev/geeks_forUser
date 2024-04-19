class ResponseRating {
  ResponseRating({
      this.status, 
      this.data,});

  ResponseRating.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? DataRating.fromJson(json['data']) : null;
  }
  String? status;
  DataRating? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class DataRating {
  DataRating({
      this.userId, 
      this.bookId, 
      this.rating, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  DataRating.fromJson(dynamic json) {
    userId = json['user_id'];
    bookId = json['book_id'];
    rating = json['rating'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? userId;
  String? bookId;
  String? rating;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['book_id'] = bookId;
    map['rating'] = rating;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}