import 'package:flutter/material.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';
import 'package:nem_pho/presentation/promotions/widgets/combo_page.dart';
import 'package:nem_pho/presentation/promotions/widgets/we_have_page.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    AppMetricaService().sendLoadingPageEvent('StockPage');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                          padding: EdgeInsets.only(right: 10.69),
                          child: Icon(
                              Icons.close,
                              color: Color(0xffF66666),
                              size: 43.2
                          )
                      )
                  )
              ),
              GestureDetector(onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (sheetContext) => Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: const ComboPage(),
                  ),
                );
              },
                child: SizedBox(
                  height: 249,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0), // Здесь задайте нужный вам радиус скругления
                    child: Image.asset(
                      'images/Discount1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36),
              GestureDetector(onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (sheetContext) => Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: const WeHavePage(),
                  ),
                );
              },
                child: SizedBox(
                  height: 249,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0), // Здесь задайте нужный вам радиус скругления
                    child: Image.asset(
                      'images/Discount2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36),
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
              SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}