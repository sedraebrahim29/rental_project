class Apartment {
  final String image;
  final String owner;
  final String location;
  final String type;
  final String size;
  final double price;

  final int? bedrooms;
  final int? bathrooms;
  final List<String>? amenities;
  final double? rating;

  const Apartment({
    required this.image,
    required this.owner,
    required this.location,
    required this.type,
    required this.size,
    required this.price,

    this.bedrooms,
    this.bathrooms,
    this.amenities,
    this.rating,

  });
}
