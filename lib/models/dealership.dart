class Dealership {
  final int? id;
  final String name;
  final String streetAddress;
  final String city;
  final String postalCode;

  Dealership({
    this.id,
    required this.name,
    required this.streetAddress,
    required this.city,
    required this.postalCode,
  });

  // Convert a Dealership into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'streetAddress': streetAddress,
      'city': city,
      'postalCode': postalCode,
    };
  }

  // Extract a Dealership from a Map.
  factory Dealership.fromMap(Map<String, dynamic> map) {
    return Dealership(
      id: map['id'],
      name: map['name'],
      streetAddress: map['streetAddress'],
      city: map['city'],
      postalCode: map['postalCode'],
    );
  }
}







