import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/profile_page/profile_provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/presentation/profile_page/profile_models/user_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    final UserModel userModel = context.read<ProfileProvider>().user!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 25,
          ),
          child: Text(
            "Горячая Головяшкина",
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
            '',
            // userModel.phone,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080)),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: userModel.orders.length,
        //     itemBuilder: (context, index) => MyOrder(
        //       orderModel: userModel.orders[index],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
