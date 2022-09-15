class Wishlist {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? optionalId;
  final String size;
  final String uid;

  Wishlist({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.optionalId,
    required this.size,
    required this.uid,
  });

  Map<String, dynamic> toMap(String optionalId) {
    return {
      'name': name,
      'description': description,
      'price': price,
      'ImageUrl': imageUrl,
      'id': optionalId,
      'Size': size,
      'uid': uid,
    };
  }

  Wishlist.fromMap(Map<String, dynamic> map)
      : name = map['name'] ?? "",
        description = map['description'] ?? "",
        price = map['price'] ?? "",
        imageUrl = map['ImageUrl'] ?? "",
        optionalId = map['id'] ?? "",
        size = map['Sizes'] ?? "",
        uid = map['uid'] ?? "";
}
