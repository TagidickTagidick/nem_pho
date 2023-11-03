import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/drawer/profile/my_order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/user_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool isExpanded = true;

  late final UserModel userModel;

  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    final snapshot = await FirebaseDatabase.instance
        .ref("users/${prefs.getString('phone')}")
        .get();
    userModel = UserModel.fromJson(snapshot.value as Map);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: Text(
                  userModel.name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000)),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  userModel.phone,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080)),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: userModel.orders.length,
                  itemBuilder: (context, index) => MyOrder(orderModel: userModel.orders[index],),
                ),
              ),
            ],
          );
  }
}
