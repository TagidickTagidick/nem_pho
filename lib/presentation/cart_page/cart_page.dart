import 'package:flutter/material.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';
import 'package:nem_pho/core/widgets/app_bar/custom_appbar.dart';
import 'package:nem_pho/presentation/cart_page/constants/cart_constants.dart';
import 'package:nem_pho/presentation/cart_page/widgets/cart_button.dart';
import 'package:nem_pho/presentation/cart_page/widgets/cart_products.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/widgets/custom/custom_text_field.dart';
import 'package:nem_pho/core/widgets/custom/mask_text_input_formatter.dart';
import 'package:nem_pho/core/widgets/not_working.dart';
import 'package:nem_pho/presentation/cart_page/cart_provider/cart_provider.dart';
import 'package:nem_pho/presentation/checkout_page/choose_street_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _entranceController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  final Map<String, TextEditingController> _controllers = {
    CartConst.flat: TextEditingController(),
    CartConst.building: TextEditingController(),
    CartConst.entrance: TextEditingController(),
    CartConst.floor: TextEditingController(),
    CartConst.name: TextEditingController(),
    CartConst.phone: TextEditingController(),
    CartConst.comment: TextEditingController(),
  };

  String _street = '';
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  bool _isSelf = true;
  bool isTime = true;
  bool _isCard = false;

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

  @override
  void initState() {
    super.initState();
    AppMetricaService().sendLoadingPageEvent('CartPage');
    _streetController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _deliveryController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    initFields();
  }

  void initFields() async {
    await context.read<CartProvider>().getProducts();
    final user = context.read<CartProvider>().user;
    if (user == null) return;
    _nameController.text = user.name ?? "";
    _street = user.street ?? '';
    _phoneController.text = user.orderPhone ?? (user.phone ?? "");
    _buildingController.text = user.building ?? '';
    _floorController.text = user.floor == null ? '' : user.floor.toString();
    _entranceController.text =
        user.entrance == null ? '' : user.entrance.toString();
    _flatController.text = user.flat == null ? '' : user.flat.toString();
    _commentController.text =
        user.comment == null ? '' : user.comment.toString();
    _isSelf = user.isSelf ?? false;
    _isCard = user.isCard ?? false;
  }

  bool get canOrder {
    final int total = context.read<CartProvider>().total;

    if (_isSelf) {
      return _nameController.text.isNotEmpty &&
          _phoneController.text.length == 18 &&
          total >= 900;
    }
    return _nameController.text.isNotEmpty &&
        _street.isNotEmpty &&
        _buildingController.text.isNotEmpty &&
        _phoneController.text.length == 18 &&
        total >= 900;
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<CartProvider>().isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final newProducts = context.watch<CartProvider>().newProducts;
    final counts = context.watch<CartProvider>().counts;
    final total = context.watch<CartProvider>().total;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: const CustomAppBar(isCart: false),
        body: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(top: 10, left: 28, bottom: 7),
              sliver: Text(
                "Корзина",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xff000000),
                ),
              ),
            ),
            CartProducts(newProducts: newProducts, counts: counts),
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
                        _isSelf ? "Самовывоз: " : "Доставка: ",
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
                        alignment: _isSelf
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
                                _isSelf = false;
                                setState(() {});
                              },
                              child: Text(
                                "Доставка на дом",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: _isSelf
                                      ? const Color(0xff000000)
                                      : const Color(0xffffffff),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _deliveryController.reverse();
                                _isSelf = true;
                                setState(() {});
                              },
                              child: Text(
                                "Забрать самому",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: _isSelf
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
                              color: const Color(0xff000000).withOpacity(0.42),
                            ),
                            underline: const SizedBox(),
                            onChanged: (String? value) {
                              if (neighbourhood == 'Выберите район') {
                                _street = '';
                                _streetController.forward();
                              } else {
                                _streetController.reverse();
                              }
                              setState(() {
                                neighbourhood = value!;
                              });
                            },
                            items: neighbourhoods
                                .map<DropdownMenuItem<String>>((String value) {
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
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChooseStreetPage(
                                    index: neighbourhoods.indexWhere(
                                        (element) => element == neighbourhood),
                                  ),
                                ),
                              );
                              if (result != null) {
                                _street = result;
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
                                _street.isEmpty ? "Укажите улицу" : _street,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: _street.isEmpty
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
                                controller: _flatController,
                                hintText: "№ квартиры",
                                textInputType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 19),
                            Expanded(
                              child: CustomTextField(
                                controller: _buildingController,
                                hintText: "№ дома",
                                textInputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: _entranceController,
                                hintText: "Подъезд",
                                textInputType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 19),
                            Expanded(
                              child: CustomTextField(
                                controller: _floorController,
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
                      controller: _phoneController,
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
                    controller: _nameController,
                    hintText: "Введите ваше имя",
                    textInputType: TextInputType.name,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => setState(() => isTime = false),
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
                                    onTap: () => setState(() => isTime = true),
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
                              border:
                                  Border.all(color: const Color(0xffF0B0B0))),
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Комментарий курьеру",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color:
                                    const Color(0xff000000).withOpacity(0.42),
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
                              border:
                                  Border.all(color: const Color(0xffF0B0B0)))),
                      AnimatedAlign(
                        alignment: _isCard
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 40,
                          width: MediaQuery.of(context).size.width /
                              (_isCard ? 3 : 2.3),
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
                              onTap: () => setState(() => _isCard = false),
                              child: Text(
                                "Переводом СБП",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: _isCard
                                      ? const Color(0xff000000)
                                      : const Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _isCard = true),
                              child: Text(
                                "Наличными",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: _isCard
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
                          neighbourhood == "Кировский" ? "Бесплатно" : "200 р",
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
                        "${total + (_isSelf ? 0 : (neighbourhood == "Кировский" ? 0 : 200))}р",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  CartButton(
                    controllers: _controllers,
                    canOrder: canOrder,
                    street: _street,
                    isCard: _isCard,
                    isSelf: _isSelf,
                  ),
                  const NotWorking(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
