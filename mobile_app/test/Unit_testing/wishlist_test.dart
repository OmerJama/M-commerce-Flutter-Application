import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/wishlist_model.dart';

void main() {
  
  group("Adding to wishlist model test", () {
     const name = "Example name";
    const price = 2.55;
    const description = "description";
    const imageUrl = "exampleUrl";
    const size = "S";
    const uid = "userid";

    test("Adding name to bag model", () {
      final wishlist = Wishlist(
        name: name,
        description: "",
        price: 5,
        imageUrl: "imageUrl",
        size: "S",
        uid: "uid",
      );

      expect(wishlist.name, name);
    });

    test("Adding description to bag model", () {
      final wishlist = Wishlist(
        name: "name",
        description: description,
        price: price,
        imageUrl: "imageUrl",
        size: "S",
        uid: "uid",
      );

      expect(wishlist.price, price);
    });
    test("Adding price to bag model", () {
      final wishlist = Wishlist(
        name: "name",
        description: "description",
        price: price,
        imageUrl: "imageUrl",
        size: "S",
        uid: "uid",
      );

      expect(wishlist.price, price);
    });

    test("Adding price to bag model", () {
      final wishlist = Wishlist(
        name: "name",
        description: "description",
        price: 5,
        imageUrl: imageUrl,
        size: "S",
        uid: "uid",
      );

      expect(wishlist.imageUrl, imageUrl);
    });

    test("Adding size to bag model", () {
      final wishlist = Wishlist(
        name: "name",
        description: "description",
        price: 5,
        imageUrl: "imageUrl",
        size: size,
        uid: "uid",
      );

      expect(wishlist.size, size);
    });

    test("Adding uid to bag model", () {
      final wishlist = Wishlist(
        name: "name",
        description: "description",
        price: 5,
        imageUrl: "imageUrl",
        size: "size",
        uid: uid,
      );

      expect(wishlist.uid, uid);
    });
  });
}