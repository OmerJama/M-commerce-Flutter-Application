import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/models/cart_item_model.dart';
import 'package:mobile_app/models/category_model.dart';
import 'package:mobile_app/models/faq_model.dart';
import 'package:mobile_app/models/order_model.dart';
import 'package:mobile_app/models/product_model.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:mobile_app/models/wishlist_model.dart';

class FirestoreService {
  final String userId;

  FirestoreService({
    required this.userId,
  });

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
  }

  addCategory(Category category) async {
    final documentId = firestore.collection("Categories").doc().id;
    await firestore
        .collection("Categories")
        .doc(documentId)
        .set(category.toMap(documentId));
  }

  Stream<List<Category>> getCategory() {
    return firestore
        .collection("Category")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Category.fromMap(d);
            }).toList());
  }

  Future<void> addProduct(Product product) async {
    final documentId = firestore.collection("Products").doc().id;

    await firestore
        .collection("Products")
        .doc(documentId)
        .set(product.toMap(documentId));
  }

  Stream<List<Product>> getProducts() {
    return firestore
        .collection("products")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Product.fromMap(d);
            }).toList());
  }

  //counts number of users
  Future<int> countDocuments() async {
    QuerySnapshot myDocuments =
        await FirebaseFirestore.instance.collection("users").get();
    List<DocumentSnapshot> myCount = myDocuments.docs;

    return myCount.length;
  }

  //counts number of categories

  Future<int> countCategoryDocuments() async {
    QuerySnapshot myDocuments =
        await FirebaseFirestore.instance.collection("Categories").get();
    List<DocumentSnapshot> myCategoryCount = myDocuments.docs;

    return myCategoryCount.length;
  }

  Future<void> addToWishlist(Wishlist wishlist) async {
    final documentId = firestore.collection("Wishlists").doc().id;

    await firestore
        .collection("Wishlists")
        .doc(documentId)
        .set(wishlist.toMap(documentId));
  }

  Stream<List<Wishlist>> getWishlist() {
    return firestore
        .collection("Wishlists")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Wishlist.fromMap(d);
            }).toList());
  }

  Future<void> addToCart(CartItemModel cartItemModel) async {
    final documentId = firestore.collection("Carts").doc().id;

    await firestore
        .collection("Carts")
        .doc(documentId)
        .set(cartItemModel.toMap(documentId));
  }

  Stream<List<Order>> getOrders() {
    return firestore
        .collection("Orders")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('cancelled', isEqualTo: "false").where('shipped', isEqualTo: "false").where('delivered', isEqualTo: "false")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  

  Future<void> addFaq(FaqModel faqModel) async {
    final documentId = firestore.collection("Faqs").doc().id;

    await firestore
        .collection("Faqs")
        .doc(documentId)
        .set(faqModel.toMap(documentId));
  }

  Stream<List<Order>> getAllOrders() {
    return firestore
        .collection("Orders").where('cancelled', isEqualTo: "false").where('shipped', isEqualTo: 'false').where('delivered', isEqualTo: 'false')
        
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  Stream<List<Order>> getShippedOrders() {
    return firestore
        .collection("Orders")
        .where('shipped', isEqualTo: 'true')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  Stream<List<Order>> getDeliveredOrders() {
    return firestore
        .collection("Orders")
        .where('delivered', isEqualTo: 'true')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  Stream<List<Order>> getAllShippedUserOrders() {
    return firestore
        .collection("Orders")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('shipped', isEqualTo: "true")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  Stream<List<Order>> getAllDeliveredUserOrders() {
    return firestore
        .collection("Orders")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('delivered', isEqualTo: "true")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  Stream<List<Order>> getAllCancelledUserOrders() {
    return firestore
        .collection("Orders")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('cancelled', isEqualTo: "true")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  Stream<List<Order>> getAllCancelledOrders() {
    return firestore
        .collection("Orders")
        .where('cancelled', isEqualTo: "true")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }
}
