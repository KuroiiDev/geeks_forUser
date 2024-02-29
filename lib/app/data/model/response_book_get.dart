/// status : "success"
/// data : [{"id":4,"title":"halo halo bandung 123","writer":"Andika Suka Ibadah","publisher":"PT.AnimeKeren","synopsis":"bandung","publish_year":2007,"created_at":"2024-02-29T00:21:18.000000Z","updated_at":"2024-02-29T00:40:31.000000Z"},{"id":3,"title":"Redo Of The Healer","writer":"Andika Suka Hentai","publisher":"PT.BotolKecapAnime","synopsis":"Seorang pangeran yang bisa nge heal (sumpah)","publish_year":6969,"created_at":"2024-02-26T07:51:13.000000Z","updated_at":"2024-02-26T07:51:13.000000Z"},{"id":2,"title":"Overflow","writer":"Andika Suka Hentai","publisher":"PT.BotolKecapAnime","synopsis":"3 kakak-beradik yang saling menyayang (lagi)i :v","publish_year":6969,"created_at":"2024-02-26T07:50:28.000000Z","updated_at":"2024-02-26T07:50:28.000000Z"},{"id":1,"title":"Yosuga No Sora","writer":"Andika Suka Hentai","publisher":"PT.BotolKecapAnime","synopsis":"sepasang kakak-beradik yang saling menyayangi :v","publish_year":6969,"created_at":"2024-02-26T07:49:42.000000Z","updated_at":"2024-02-26T07:49:42.000000Z"}]

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

/// id : 4
/// title : "halo halo bandung 123"
/// writer : "Andika Suka Ibadah"
/// publisher : "PT.AnimeKeren"
/// synopsis : "bandung"
/// publish_year : 2007
/// created_at : "2024-02-29T00:21:18.000000Z"
/// updated_at : "2024-02-29T00:40:31.000000Z"

class DataBook {
  DataBook({
      this.id, 
      this.title, 
      this.writer, 
      this.publisher, 
      this.synopsis, 
      this.publishYear, 
      this.createdAt, 
      this.updatedAt,});

  DataBook.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    writer = json['writer'];
    publisher = json['publisher'];
    synopsis = json['synopsis'];
    publishYear = json['publish_year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? title;
  String? writer;
  String? publisher;
  String? synopsis;
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
    map['publish_year'] = publishYear;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}