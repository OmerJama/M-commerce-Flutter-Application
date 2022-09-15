class Category {
  final String name;
  final String? optionalId;
  final String imageUrl;


  Category({
    required this.name, this.optionalId, required this.imageUrl,
  });

  Map<String, dynamic> toMap(String optionalId){
    return{
      'name' : name,
      'optionalId' : optionalId,
      'imageUrl' : imageUrl,
    };
  }

  Category.fromMap(Map<String,dynamic> map)
  : name = map['name'] ?? "",
    optionalId = map['optionalID'] ?? "",
    imageUrl = map['imageUrl'] ?? "";
}