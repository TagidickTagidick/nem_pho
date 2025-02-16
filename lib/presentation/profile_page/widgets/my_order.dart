// import 'package:flutter/material.dart';
// import 'package:nem_pho/cart_provider.dart';
// import 'package:nem_pho/ui/pages/pay/checkout_page.dart';
// import 'package:provider/provider.dart';
// import '../../cart_page/cart_page.dart';
//
// class MyOrder extends StatefulWidget {
//   const MyOrder({
//     super.key,
//     required this.orderModel,
//   });
//
//   final OrderModel orderModel;
//
//   @override
//   State<MyOrder> createState() => _MyOrderState();
// }
//
// class _MyOrderState extends State<MyOrder> with SingleTickerProviderStateMixin {
//   bool isExpanded = false;
//
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//         duration: const Duration(milliseconds: 200), vsync: this);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           color: const Color(0xFFF3F3F3),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 18,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Дата заказа',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF7B7A7A),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 106,
//                     ),
//                     Text(
//                       widget.orderModel.date,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               if (!widget.orderModel.isSelf)
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Адрес доставки',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF7B7A7A),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 106,
//                     ),
//                     Expanded(
//                       child: Text(
//                         widget.orderModel.adress,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF000000),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Тип доставки:',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF7B7A7A),
//                       ),
//                     ),
//                     Text(
//                       widget.orderModel.isSelf ? "Самовывоз" : "Доставка",
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Тип оплаты:',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF7B7A7A),
//                       ),
//                     ),
//                     Text(
//                       widget.orderModel.isCash ? "Наличными" : "Картой",
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Итого',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF7B7A7A),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 106,
//                     ),
//                     Text(
//                       '${widget.orderModel.total + widget.orderModel.delivery} р',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 25,
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 2,
//                       ),
//                       alignment: Alignment.center,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: const Color(0xffff9900),
//                       ),
//                       child: Text(
//                         widget.orderModel.status,
//                         style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xffffffff)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       if (isExpanded) {
//                         _controller.reverse();
//                       } else {
//                         _controller.forward();
//                       }
//                       isExpanded = !isExpanded;
//                       setState(() {});
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         right: 30,
//                       ),
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 20,
//                         width: 41,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Color(0xFFFFFFFF),
//                             border: Border.all(
//                               color: Color(0xfff0b0b0),
//                               width: 2,
//                             )),
//                         child: Icon(
//                           isExpanded
//                               ? Icons.keyboard_arrow_up
//                               : Icons.keyboard_arrow_down,
//                           color: const Color(0xff9B8C8C),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         SizeTransition(
//           sizeFactor: _controller.view,
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 color: Color(0xFFF3F3F3),
//                 child: Column(children: [
//                   SizedBox(
//                     height: 18,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 25,
//                       right: 25,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Номер заказа',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF7B7A7A)),
//                         ),
//                         SizedBox(
//                           width: 106,
//                         ),
//                         Text(
//                           widget.orderModel.id.toString(),
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF000000)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     'Ваш заказ:',
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xFF000000),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   for (int i = 0; i < widget.orderModel.products.length; i++)
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 25,
//                         right: 25,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             widget.orderModel.products[i].title,
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xFF000000)),
//                           ),
//                           SizedBox(
//                             width: 106,
//                           ),
//                           Text(
//                             '${widget.orderModel.products[i].price} р',
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xFF000000)),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ]),
//               ),
//               SizedBox(
//                 height: 7,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Стоймость товаров',
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF7B7A7A)),
//                     ),
//                     SizedBox(
//                       width: 106,
//                     ),
//                     Text(
//                       '${widget.orderModel.total} р',
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF000000)),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 17,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Доставка',
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF7B7A7A)),
//                     ),
//                     SizedBox(
//                       width: 106,
//                     ),
//                     Text(
//                       '${widget.orderModel.delivery} р',
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF000000)),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 17,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 25,
//                   right: 25,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Итого:',
//                       style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF7B7A7A)),
//                     ),
//                     SizedBox(
//                       width: 106,
//                     ),
//                     Text(
//                       '${widget.orderModel.total + widget.orderModel.delivery} р',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 13,
//               ),
//               Padding(
//                   padding: const EdgeInsets.only(
//                     left: 25,
//                   ),
//                   child: widget.orderModel.status == "Готов"
//                       ? GestureDetector(
//                           onTap: () {
//                             for (var product in widget.orderModel.products) {
//                               context.read<CartProvider>().addProduct(product);
//                             }
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => const CartPage()));
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 2,
//                             ),
//                             alignment: Alignment.center,
//                             height: 24,
//                             width: 173,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Color(0xffFF451D),
//                             ),
//                             child: Text(
//                               'Повторить',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xffffffff),
//                               ),
//                             ),
//                           ),
//                         )
//                       : GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) => CheckoutPage(
//                                   street: '',
//                                   flat: '',
//                                   office: '',
//                                   entrance: '',
//                                   floor: '',
//                                   name: '',
//                                   phone: '',
//                                   comment: '',
//                                   total: 0,
//                                   delivery: 0,
//                                   id: widget.orderModel.id,
//                                   isSelf: widget.orderModel.isSelf,
//                                   isCash: widget.orderModel.isCash,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 2,
//                             ),
//                             alignment: Alignment.center,
//                             height: 24,
//                             width: 173,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Color(0xffFF451D),
//                             ),
//                             child: Text(
//                               'Посмотреть информацию',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Color(0xffffffff),
//                               ),
//                             ),
//                           ),
//                         )),
//             ],
//           ),
//         ),
//         const SizedBox(height: 23),
//       ],
//     );
//   }
// }
