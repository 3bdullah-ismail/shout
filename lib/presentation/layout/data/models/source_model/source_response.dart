import 'sources.dart';
import 'dart:convert';

SourceResponse sourceResponseFromJson(String str) =>
    SourceResponse.fromJson(json.decode(str));
String sourceResponseToJson(SourceResponse data) => json.encode(data.toJson());

class SourceResponse {
  SourceResponse({this.status, this.sources});

  SourceResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['sources'] != null) {
      sources = (json['sources'] as List)
          .map((v) => Source.fromJson(v))
          .toList();
    }
  }
  String? status;
  List<Source>? sources;
  SourceResponse copyWith({String? status, List<Source>? sources}) =>
      SourceResponse(
        status: status ?? this.status,
        sources: sources ?? this.sources,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (sources != null) {
      map['sources'] = sources?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
