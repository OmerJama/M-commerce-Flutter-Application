class CartItemModel{
  final String name;
  final double price;
  final String imageUrl;
  final String size;
  final String? optionalId;
  final String uid;

  CartItemModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.size,
    this.optionalId,
    required this.uid,
  });

  Map<String, dynamic> toMap(String optionalId){
    return{
      'name' : name,
      'price' : price,
      'ImageUrl' : imageUrl,
      'id' : optionalId,
      'Size' : size,
      'uid' : uid,
    };
  }

  CartItemModel.fromMap(Map<String,dynamic> map)
  : name = map['name'] ?? "",
    price = map['price'] ?? "",
    imageUrl = map['ImageUrl'] ?? "",
    optionalId = map['id'] ?? "",
    size = map['Size'] ?? "",
    uid= map['uid'] ?? "";

}