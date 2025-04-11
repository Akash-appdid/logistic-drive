import 'dart:convert';

List<VehicleMasterModel> vehicleMasterModelFromJson(String str) =>
    List<VehicleMasterModel>.from(
        json.decode(str).map((x) => VehicleMasterModel.fromJson(x)));

String vehicleMasterModelToJson(List<VehicleMasterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehicleMasterModel {
  int? id;
  String? name;
  String? type;
  String? weight;

  VehicleMasterModel({
    this.id,
    this.name,
    this.type,
    this.weight,
  });

  factory VehicleMasterModel.fromJson(Map<String, dynamic> json) =>
      VehicleMasterModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "weight": weight,
      };
}
