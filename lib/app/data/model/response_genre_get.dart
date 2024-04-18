class ResponseGenre {
  ResponseGenre({
      this.status, 
      this.data,});

  ResponseGenre.fromJson(dynamic json) {
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
      this.genre, 
      this.createdAt, 
      this.updatedAt,});

  DataGenre.fromJson(dynamic json) {
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