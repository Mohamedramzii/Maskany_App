class Location {
  final String id;
  final double latitude;
  final double longitude;
  final String name;
   bool isviewed;

  Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.isviewed,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      name: json['name'] as String,
      isviewed: json['isviewed'] as bool,
    );
  }
}

List<Location> locationsData = [
  Location(
      id: '1',
      latitude: 30.07681641462623,
      longitude: 31.346735891447615,
      name: 'Villa1',
      isviewed: false),
  Location(
      id: '2',
      latitude: 30.076707594380764,
      longitude: 31.34641627386224,
      name: 'Villa2',
      isviewed: false),
  Location(
      id: '3',
      latitude: 30.076636051166584,
      longitude: 31.346128568412784,
      name: 'Villa3',
      isviewed: false),
  Location(
      id: '4',
      latitude: 30.076352743302635,
      longitude: 31.346022746098434,
      name: 'Villa4',
      isviewed: false),
  Location(
      id: '5',
      latitude: 30.076198211522456,
      longitude: 31.34589377546395,
      name: 'Villa5',
      isviewed: false),
];
