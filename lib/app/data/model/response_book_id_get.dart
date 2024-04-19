class ResponseBookId {
  ResponseBookId({
    this.status,
    this.data,});

  ResponseBookId.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? DataBookId.fromJson(json['data']) : null;
  }
  String? status;
  DataBookId? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class DataBookId {
  DataBookId({
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

  DataBookId.fromJson(dynamic json) {
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