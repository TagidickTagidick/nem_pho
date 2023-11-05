import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/drawer/profile/my_order.dart';
import 'package:provider/provider.dart';
import '../../../../cart_provider.dart';
import '../../../../models/user_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseDatabase.instance
            .ref("users/${context.read<CartProvider>().phone}")
            .onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = UserModel.fromJson(snapshot.data?.snapshot.value as Map);
            return Column(
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
                    itemBuilder: (context, index) => MyOrder(
                      orderModel: userModel.orders[index],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
          }
        );
  }
}
