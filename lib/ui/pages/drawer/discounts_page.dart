import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/drawer/We_have.dart';
import 'package:nem_pho/ui/pages/drawer/combo_terms.dart';
import 'package:nem_pho/ui/pages/drawer/dish_day.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                          padding: EdgeInsets.only(right: 10.69),
                          child: Icon(Icons.close,
                              color: Color(0xffF66666), size: 43.2)))),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (sheetContext) => Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: const ComboTerms(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 249,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        0), // Здесь задайте нужный вам радиус скругления
                    child: Container(
                      child: Image.asset(
                        'images/Discount1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (sheetContext) => Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: const WeHave(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 249,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        0), // Здесь задайте нужный вам радиус скругления
                    child: Container(
                      child: Image.asset(
                        'images/Discount2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              // GestureDetector(
              //   onTap: () {
              //     showModalBottomSheet(
              //       context: context,
              //       isScrollControlled: true,
              //       backgroundColor: Colors.transparent,
              //       builder: (sheetContext) => Padding(
              //         padding: EdgeInsets.only(
              //             top: MediaQuery.of(context).padding.top),
              //         child: const DishDay(),
              //       ),
              //     );
              //   },
              //   child: SizedBox(
              //     height: 249,
              //     width: double.infinity,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(
              //           0), // Здесь задайте нужный вам радиус скругления
              //       child: Container(
              //         child: Image.asset(
              //           'images/Discount3.png',
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
