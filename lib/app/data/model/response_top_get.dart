/// status : "success"
/// data : {"id":1,"title":"Tobatlah","writer":"Andika","publisher":"Julidi gaming","synopsis":"Nyam Nyam","rented":3,"status":"UNAVAILABLE","publish_year":2009,"created_at":"2024-03-06T06:34:51.000000Z","updated_at":"2024-03-06T06:58:58.000000Z"}

class ResponseTop {
  ResponseTop({
      this.status, 
      this.data,});

  ResponseTop.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? DataBook.fromJson(json['data']) : null;
  }
  String? status;
  DataBook? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : 1
/// title : "Tobatlah"
/// writer : "Andika"
/// publisher : "Julidi gaming"
/// synopsis : "Nyam Nyam"
/// rented : 3
/// status : "UNAVAILABLE"
/// publish_year : 2009
/// created_at : "2024-03-06T06:34:51.000000Z"
/// updated_at : "2024-03-06T06:58:58.000000Z"

class DataBook {
  DataBook({
      this.id, 
      this.title, 
      this.writer, 
      this.publisher, 
      this.synopsis, 
      this.rented, 
      this.status, 
      this.publishYear, 
      this.createdAt, 
      this.updatedAt,});

  DataBook.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    writer = json['writer'];
    publisher = json['publisher'];
    synopsis = json['synopsis'];
    rented = json['rented'];
    status = json['status'];
    publishYear = json['publish_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? title;
  String? writer;
  String? publisher;
  String? synopsis;
  int? rented;
  String? status;
  int? publishYear;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['writer'] = writer;
    map['publisher'] = publisher;
    map['synopsis'] = synopsis;
    map['rented'] = rented;
    map['status'] = status;
    map['publish_year'] = publishYear;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}