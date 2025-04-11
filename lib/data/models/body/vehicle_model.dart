class VehicleOption {
  final String key;
  final String vehicleType;
  final String storageType;
  final String description;
  final String image;

  VehicleOption({
    required this.key,
    required this.vehicleType,
    required this.storageType,
    required this.description,
    required this.image,
  });

  factory VehicleOption.fromJson(Map<String, dynamic> json) {
    return VehicleOption(
      key: json['key'],
      vehicleType: json['vehicle_type'],
      storageType: json['storage_type'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'vehicle_type': vehicleType,
      'storage_type': storageType,
      'description': description,
      'image': image,
    };
  }
}
