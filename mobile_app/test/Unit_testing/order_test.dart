import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/cart_item_model.dart';
import 'package:mobile_app/models/order_model.dart';

void main() {
  test("Adding item to order model", () {
    const name = "Item";
    final cartItem = CartItemModel(name: "name", price: 4, imageUrl: "imageUrl", size: "size", uid: "uid");
    final order = Order(name: name, timestamp: Timestamp.now(), product: [cartItem,cartItem,cartItem], userid: "userid", optionalid: "optionalid", address: "address", cancelled: "cancelled");

    expect(order.name, name);
  });
}
