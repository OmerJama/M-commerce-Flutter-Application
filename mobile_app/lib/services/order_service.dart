import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/models/cart_item_model.dart';
import 'package:mobile_app/models/order_model.dart';

class OrderService {
  
  createOrder(String uid, String name, String optionalId,List<CartItemModel> cart, double totalPrice, String shipped, String delivered, String address, String cancelled,){
    List<Map> enrichedCart = [];

    for (CartItemModel cartItem in cart) {
      enrichedCart.add(cartItem.toMap(optionalId));
    }

    FirebaseFirestore.instance.collection("Orders").doc(optionalId).set({
      "uid" : uid,
      "name" : name,
      "id" : optionalId,
      "products" : enrichedCart,
      "timestamp" : DateTime.now(),
      "totalprice" : totalPrice,
      "shipped" : shipped,
      "delivered" : delivered,
      "deliveryaddress" : address,
      "cancelled" : cancelled,
    });
  }
  

      Stream<List<Order>> getOrders() {
    return FirebaseFirestore.instance
        .collection("Orders").where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
            
  }
  

  
}