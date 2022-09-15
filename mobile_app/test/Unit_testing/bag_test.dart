import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/cart_item_model.dart';

void main() {
  group("Adding to bag test", () {
    const name = "Example name";
    const price = 2.55;
    const imageUrl = "exampleUrl";
    const size = "S";
    const uid = "userid";

    test("Adding name to bag model", () {
      final cart = CartItemModel(
        name: name,
        price: 5,
        imageUrl: "imageUrl",
        size: "S",
        uid: "uid",
      );

      expect(cart.name, name);
    });

    test("Adding price to bag model", () {
      final cart = CartItemModel(
        name: "name",
        price: price,
        imageUrl: "imageUrl",
        size: "S",
        uid: "uid",
      );

      expect(cart.price, price);
    });

    test("Adding price to bag model", () {
      final cart = CartItemModel(
        name: "name",
        price: 5,
        imageUrl: imageUrl,
        size: "S",
        uid: "uid",
      );

      expect(cart.imageUrl, imageUrl);
    });

    test("Adding size to bag model", () {
      final cart = CartItemModel(
        name: "name",
        price: 5,
        imageUrl: "imageUrl",
        size: size,
        uid: "uid",
      );

      expect(cart.size, size);
    });

    test("Adding uid to bag model", () {
      final cart = CartItemModel(
        name: "name",
        price: 5,
        imageUrl: "imageUrl",
        size: "size",
        uid: uid,
      );

      expect(cart.uid, uid);
    });
  });
}
