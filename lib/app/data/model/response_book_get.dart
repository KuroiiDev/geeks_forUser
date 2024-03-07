/// status : "success"
/// data : [{"id":2,"title":"Agama","writer":"Andika","publisher":"Julidi gaming","synopsis":"Nyam Nyam","rented":0,"status":"AVAILABLE","publish_year":2009,"created_at":"2024-03-07T01:23:24.000000Z","updated_at":"2024-03-07T01:23:24.000000Z"},{"id":1,"title":"Tobatlah","writer":"Andika","publisher":"Julidi gaming","synopsis":"Nyam Nyam","rented":3,"status":"UNAVAILABLE","publish_year":2009,"created_at":"2024-03-06T06:34:51.000000Z","updated_at":"2024-03-06T06:58:58.000000Z"}]

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

/// id : 2
/// title : "Agama"
/// writer : "Andika"
/// publisher : "Julidi gaming"
/// synopsis : "Nyam Nyam"
/// rented : 0
/// status : "AVAILABLE"
/// publish_year : 2009
/// created_at : "2024-03-07T01:23:24.000000Z"
/// updated_at : "2024-03-07T01:23:24.000000Z"

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