import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/product_model.dart';
import 'models/user_model.dart';
import 'package:ntp/ntp.dart';

class CartProvider with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  String? _phone;

  String? get phone => _phone;

  bool _isWorking = false;

  bool get isWorking => _isWorking;

  Future<void> getIsWorking() async {
    final time = await NTP.now();
    DateTime startTime = DateTime(time.year, time.month, time.day, 11, 30);
    DateTime endTime = DateTime(time.year, time.month, time.day, 20, 30);
    if (time.isAfter(startTime) && time.isBefore(endTime)) {
      _isWorking = true;
    } else {
      _isWorking = false;
    }
    notifyListeners();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _phone = prefs.getString('phone');
    if (_phone != null) {
      await Future.delayed(const Duration(seconds: 1)).then((value) async {
        final snapshot =
            await FirebaseDatabase.instance.ref("users/$_phone").get();
        _userModel = UserModel.fromJson(snapshot.value as Map);
      });
    }
    notifyListeners();
  }

  void addProduct(ProductModel product) {
    userModel?.cart.add(product);
    List cart = [];
    for (var product in userModel!.cart) {
      cart.add(product.toJson());
    }
    FirebaseDatabase.instance
        .ref()
        .child('users/$phone')
        .update({"cart": cart});
    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    ProductModel removedProduct =
        userModel!.cart.firstWhere((element) => element.title == product.title);
    userModel!.cart.remove(removedProduct);
    List cart = [];
    for (var product in userModel!.cart) {
      cart.add(product.toJson());
    }
    FirebaseDatabase.instance
        .ref()
        .child('users/$phone')
        .update({"cart": cart});
    notifyListeners();
  }

  void clearProducts() {
    userModel!.cart.clear();
    FirebaseDatabase.instance.ref().child('users/$phone').update({
      "cart": [],
    });
    notifyListeners();
  }
}
