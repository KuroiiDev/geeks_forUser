/// status : "success"
/// data : {"user_id":1,"email":"user@example.com","name":"Normal User","role":"USER","created_at":"2024-04-01T02:23:36.000000Z","updated_at":"2024-04-01T02:23:36.000000Z"}

class ResponseUser {
  ResponseUser({
      this.status, 
      this.data,});

  ResponseUser.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? DataUser.fromJson(json['data']) : null;
  }
  String? status;
  DataUser? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// user_id : 1
/// email : "user@example.com"
/// name : "Normal User"
/// role : "USER"
/// created_at : "2024-04-01T02:23:36.000000Z"
/// updated_at : "2024-04-01T02:23:36.000000Z"

class DataUser {
  DataUser({
      this.id, 
      this.email,
    this.profile,
    this.name,
      this.role, 
      this.createdAt, 
      this.updatedAt,});

  DataUser.fromJson(dynamic json) {
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