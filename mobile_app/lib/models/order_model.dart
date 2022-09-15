import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/models/cart_item_model.dart';

class Order {
  final String name;
  final Timestamp timestamp;
  final List<CartItemModel> product;
  final String userid;
  final String optionalid;
  final String address;
  final String cancelled;

  Order({required this.name,required this.timestamp, required this.product, required this.userid, required this.optionalid, required this.address, required this.cancelled,});

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        name: map['name'],
        timestamp: map['timestamp'],
        userid: map['uid'],
        optionalid: map['id'],
        address: map['deliveryaddress'],
        cancelled: map['cancelled'],
        product: (map['products'] as List<dynamic>)
            .map((product) => CartItemModel.fromMap(product))
            .toList());
  }
}
