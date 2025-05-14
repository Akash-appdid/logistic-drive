import 'dart:convert';

List<MiniTruckModel> miniTruckModelFromJson(String str) =>
    List<MiniTruckModel>.from(
        json.decode(str).map((x) => MiniTruckModel.fromJson(x)));

String miniTruckModelToJson(List<MiniTruckModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MiniTruckModel {
  int? id;
  String? title;

  MiniTruckModel({
    this.id,
    this.title,
  });

  factory MiniTruckModel.fromJson(Map<String, dynamic> json) => MiniTruckModel(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
