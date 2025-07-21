class UpdateLocationDto {
  final double latitude;
  final double longitude;

  UpdateLocationDto({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}