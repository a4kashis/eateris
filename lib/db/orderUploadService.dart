import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FoodService {
  Firestore _firestore = Firestore.instance;
  String collection = 'orders';

  void uploadOrder({String productName, double price}) {
    var id = Uuid();
    String orderId = id.v1();
    _firestore.collection(collection).document(orderId).setData({
      'name': "productName",
      'id': orderId,
      'price': "price",
    });
  }
}
