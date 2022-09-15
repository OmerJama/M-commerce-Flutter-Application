
class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? optionalId;
  final String category;
  final String sizes;
  final int smallStock;
  final int mediumStock;
  final int largeStock;
  final int xLargeStock;
  final int stock;
  final List<String> searchArray;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.optionalId,
    required this.category,
    required this.sizes,
    required this.smallStock,
    required this.mediumStock,
    required this.largeStock,
    required this.xLargeStock,
    required this.stock,
    required this.searchArray,
  });

  Map<String, dynamic> toMap(String optionalId){
    return{
      'name' : name,
      'description' : description,
      'price' : price,
      'ImageUrl' : imageUrl,
      'id' : optionalId,
      'Category' : category,
      'Sizes' : sizes,
      'Small stock' : smallStock,
      'Medium stock' : mediumStock,
      'Large stock' : largeStock,
      'X Large stock' : xLargeStock,
      'Stock' : stock,
      'Search Index' : searchArray,
    };
  }

  Product.fromMap(Map<String,dynamic> map)
  : name = map['name'] ?? "",
    description = map['description'] ?? "",
    price = map['price'] ?? "",
    imageUrl = map['ImageUrl'] ?? "",
    optionalId = map['id'] ?? "",
    category = map['Category'] ?? "",
    sizes = map['Sizes'] ?? "",
    smallStock = map['Small stock'] ?? "",
    mediumStock = map['Medium stock'] ?? "",
    largeStock = map['Large stock'] ?? "",
    xLargeStock = map['X Large stock'] ?? "",
    stock = map['Stock'] ?? "",
    searchArray = map['Search Index'] ?? "";



}
