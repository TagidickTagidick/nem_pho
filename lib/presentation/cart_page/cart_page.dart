import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/checkout/choose_street_page.dart';
import 'package:nem_pho/ui/pages/pay/first_stape.dart';
import 'package:nem_pho/ui/widgets/custom/custom_appbar.dart';
import 'package:provider/provider.dart';
import '../../cart_provider.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../ui/widgets/custom/custom_text_field.dart';
import '../../ui/widgets/custom/mask_text_input_formatter.dart';
import '../../ui/widgets/not_working.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  List<ProductModel> newProducts = [];

  List<int> counts = [];

  late UserModel userModel;

  final TextEditingController flatController = TextEditingController();
  final TextEditingController officeController = TextEditingController();
  final TextEditingController entranceController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String street = '';

  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  bool isSelf = true;
  bool isTime = true;
  bool isCash = false;

  int total = 0;
  bool canCheckout = false;

  final List<String> neighbourhoods = [
    'Кировский',
    'Дзержинский',
    'Заволжский',
    'Красноперекопский',
    'Ленинский',
    'Фрунзенский',
    'Выберите район'
  ];

  late AnimationController _streetController;
  late AnimationController _deliveryController;

  String neighbourhood = 'Выберите район';

  void checkCanCheckout() {
    if (isSelf) {
      if (total >= 900) {
        canCheckout = true;
      } else {
        canCheckout = false;
      }
    } else {
      if ((total + (neighbourhood == "Кировский" ? 0 : 200) >= 900) &&
          street.isNotEmpty &&
          (flatController.text.isNotEmpty ||
              officeController.text.isNotEmpty) &&
          nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty) {
        canCheckout = true;
      } else {
        canCheckout = false;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _streetController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _deliveryController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    getData();
  }

  void getData() async {
    userModel = context.read<CartProvider>().userModel!;
    phoneController.text = userModel.phone.replaceAll("_", " ");
    nameController.text = userModel.name;
    street = userModel.street;
    flatController.text = userModel.flat;
    officeController.text = userModel.office;
    entranceController.text = userModel.entrance;
    floorController.text = userModel.floor;

    List<ProductModel> oldCart = userModel.cart;
    for (int i = 0; i < oldCart.length; i++) {
      total += int.parse(oldCart[i].price);
    }
    if (oldCart.isNotEmpty) {
      oldCart.sort((a, b) => a.title.compareTo(b.title));
      if (oldCart.length == 1) {
        newProducts.add(oldCart[0]);
        counts.add(1);
      } else {
        int count = 0;
        for (int i = 1; i < oldCart.length; i++) {
          count++;
          if (oldCart[i].title != oldCart[i - 1].title) {
            newProducts.add(oldCart[i - 1]);
            counts.add(count);
            count = 0;
          }
        }
        count++;
        newProducts.add(oldCart[oldCart.length - 1]);
        counts.add(count);
      }
    }
    checkCanCheckout();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          appBar: const CustomAppBar(isCart: false),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 28, bottom: 7),
                  child: Text(
                    "Корзина",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                for (int i = 0; i < newProducts.length; i++)
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          newProducts[i].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${newProducts[i].price} р",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.symmetric(vertical: 17),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  counts[i]--;
                                  context
                                      .read<CartProvider>()
                                      .removeProduct(newProducts[i]);
                                  total -= int.parse(newProducts[i].price);
                                  if (counts[i] == 0) {
                                    newProducts.removeAt(i);
                                    counts.removeAt(i);
                                  }
                                  checkCanCheckout();
                                },
                                child: Container(
                                  height: 37,
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(37),
                                        bottomLeft: Radius.circular(37)),
                                    border: Border.all(
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  counts[i]++;
                                  context
                                      .read<CartProvider>()
                                      .addProduct(newProducts[i]);
                                  total += int.parse(newProducts[i].price);
                                  checkCanCheckout();
                                },
                                child: Container(
                                  height: 37,
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(37),
                                      bottomRight: Radius.circular(37),
                                    ),
                                    border: Border.all(
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 38,
                                width: 38,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFF451D)),
                                child: Text(
                                  counts[i].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20)
                    ],
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 14, right: 6),
                  padding: const EdgeInsets.only(top: 20, left: 17, right: 16),
                  decoration: BoxDecoration(
                      color: const Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            isSelf ? "Самовывоз: " : "Доставка: ",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xff000000),
                            ),
                          ),
                          const Text(
                            "Ярославль",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Color(0xff000000),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(200),
                              border: Border.all(
                                color: const Color(0xffF0B0B0),
                              ),
                            ),
                          ),
                          AnimatedAlign(
                            alignment: isSelf
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            duration: const Duration(milliseconds: 200),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2.25,
                              decoration: BoxDecoration(
                                color: const Color(0xffFF451D),
                                borderRadius: BorderRadius.circular(200),
                                border: Border.all(
                                  color: const Color(0xffF0B0B0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _deliveryController.forward();
                                    isSelf = false;
                                    checkCanCheckout();
                                  },
                                  child: Text(
                                    "Доставка на дом",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: isSelf
                                          ? const Color(0xff000000)
                                          : const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _deliveryController.reverse();
                                    isSelf = true;
                                    checkCanCheckout();
                                  },
                                  child: Text(
                                    "Забрать самому",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: isSelf
                                          ? const Color(0xffffffff)
                                          : const Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SizeTransition(
                        sizeFactor: _deliveryController.view,
                        child: Column(
                          children: [
                            Container(
                              height: 38,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(200),
                                border: Border.all(
                                  color: const Color(0xffF0B0B0),
                                ),
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: neighbourhood,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color:
                                      const Color(0xff000000).withOpacity(0.42),
                                ),
                                underline: const SizedBox(),
                                onChanged: (String? value) {
                                  if (neighbourhood == 'Выберите район') {
                                    street = '';
                                    _streetController.forward();
                                  } else {
                                    _streetController.reverse();
                                  }
                                  setState(() {
                                    neighbourhood = value!;
                                  });
                                },
                                items: neighbourhoods
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 18),
                            SizeTransition(
                              sizeFactor: _streetController.view,
                              child: GestureDetector(
                                onTap: () async {
                                  final result =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ChooseStreetPage(
                                        index: neighbourhoods.indexWhere(
                                            (element) =>
                                                element == neighbourhood),
                                      ),
                                    ),
                                  );
                                  if (result != null) {
                                    street = result;
                                    checkCanCheckout();
                                  }
                                },
                                child: Container(
                                  height: 38,
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 22),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(200),
                                    border: Border.all(
                                      color: const Color(0xffF0B0B0),
                                    ),
                                  ),
                                  child: Text(
                                    street.isEmpty ? "Укажите улицу" : street,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: street.isEmpty
                                          ? const Color(0xff000000)
                                              .withOpacity(0.42)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: flatController,
                                    hintText: "№ квартиры",
                                    textInputType: TextInputType.number,
                                    onChanged: (value) {
                                      checkCanCheckout();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 19),
                                Expanded(
                                  child: CustomTextField(
                                    controller: officeController,
                                    hintText: "№ офиса",
                                    textInputType: TextInputType.number,
                                    onChanged: (value) {
                                      checkCanCheckout();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: entranceController,
                                    hintText: "Подъезд",
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 19),
                                Expanded(
                                  child: CustomTextField(
                                    controller: floorController,
                                    hintText: "Этаж",
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 22),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(
                            color: const Color(0xffF0B0B0),
                          ),
                        ),
                        child: TextField(
                          controller: phoneController,
                          onChanged: (value) {
                            checkCanCheckout();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Номер телефона",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: const Color(0xff000000).withOpacity(0.42),
                            ),
                          ),
                          inputFormatters: [maskFormatter],
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: nameController,
                        hintText: "Введите ваше имя",
                        textInputType: TextInputType.name,
                        onChanged: (value) {
                          checkCanCheckout();
                        },
                      ),
                      const SizedBox(height: 24),
                      SizeTransition(
                        sizeFactor: _deliveryController.view,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(200),
                                    border: Border.all(
                                      color: const Color(0xffF0B0B0),
                                    ),
                                  ),
                                ),
                                AnimatedAlign(
                                  alignment: isTime
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  duration: const Duration(milliseconds: 200),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width /
                                        (isTime ? 3 : 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFF451D),
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                        color: const Color(0xffF0B0B0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => isTime = false),
                                        child: Text(
                                          "Как можно быстрее",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: isTime
                                                ? const Color(0xff000000)
                                                : const Color(0xffFFFFFF),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            setState(() => isTime = true),
                                        child: Text(
                                          "Ко времени",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: isTime
                                                ? const Color(0xffFFFFFF)
                                                : const Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Container(
                              height: 77,
                              padding: const EdgeInsets.only(left: 22),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(
                                      color: const Color(0xffF0B0B0))),
                              child: TextField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Комментарий курьеру",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.42),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 31, left: 29, bottom: 4),
                  child: Text(
                    "Оплата",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 40,
                    right: 40,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 80,
                              decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(
                                      color: const Color(0xffF0B0B0)))),
                          AnimatedAlign(
                            alignment: isCash
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            duration: const Duration(milliseconds: 200),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 40,
                              width: MediaQuery.of(context).size.width /
                                  (isCash ? 3 : 2),
                              decoration: BoxDecoration(
                                color: const Color(0xffFF451D),
                                borderRadius: BorderRadius.circular(200),
                                border: Border.all(
                                  color: const Color(0xffF0B0B0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => setState(() => isCash = false),
                                  child: Text(
                                    "Переводом СБП",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: isCash
                                          ? const Color(0xff000000)
                                          : const Color(0xffFFFFFF),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() => isCash = true),
                                  child: Text(
                                    "Наличными",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: isCash
                                          ? const Color(0xffFFFFFF)
                                          : const Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 31),
                      const Text(
                          "Соглашаюсь на распространение указанных в заказе персональных данных третьим лицам. С условиями Публичной оферты ознакомлен.",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 9,
                              color: Color(0xff000000))),
                      const SizedBox(height: 12),
                      SizeTransition(
                        sizeFactor: _deliveryController.view,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Доставка",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(0xff000000),
                              ),
                            ),
                            Text(
                              neighbourhood == "Кировский"
                                  ? "Бесплатно"
                                  : "200 р",
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 127),
                      const Text(
                        'Минимальная сумма заказа от 900 р',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("К оплате:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff000000))),
                          Text(
                            "${total + (isSelf ? 0 : (neighbourhood == "Кировский" ? 0 : 200))}р",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xff000000),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      context.watch<CartProvider>().isWorking ? GestureDetector(
                        onTap: () {
                          if (canCheckout) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  street: street,
                                  flat: flatController.text,
                                  office: officeController.text,
                                  entrance: entranceController.text,
                                  floor: floorController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  comment: commentController.text,
                                  total: total,
                                  delivery:
                                      neighbourhood == "Кировский" ? 0 : 200,
                                  id: 0,
                                  isSelf: isSelf,
                                  isCash: isCash,
                                ),
                              ),
                            );
                          }
                        },
                        child: Opacity(
                          opacity: canCheckout ? 1 : 0.5,
                          child: Container(
                            height: 39,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xff19B80B),
                                borderRadius: BorderRadius.circular(1)),
                            child: const Text(
                              "Оформить заказ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ) : const NotWorking(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
