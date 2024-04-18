class ResponseBook {
  ResponseBook({
    this.status,
    this.data,});

  ResponseBook.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataBook.fromJson(v));
      });
    }
  }
  String? status;
  List<DataBook>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DataBook {
  DataBook({
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

  DataBook.fromJson(dynamic json) {
    id = json['id'];
    cover = json['cover'];
    title = json['title'];
    writer = json['writer'];
    publisher = json['publisher'];
    synopsis = json['synopsis'];
    rented = json['rented'];
    rating = json['rating'];
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