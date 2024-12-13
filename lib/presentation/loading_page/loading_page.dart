import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';
import 'package:nem_pho/core/services/push_notifications_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_provider/loading_provider.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/providers/common_provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  Animation<double>? alpha;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<dynamic> _progressLoader(double progress, Future<dynamic> onLoad) async {
    alpha = Tween<double>(
        begin: (progress - 1) * (MediaQuery.of(context).size.width - 93) / 5,
        end: progress * (MediaQuery.of(context).size.width - 93) / 5
    ).animate(controller);
    controller.reset();
    controller.forward();
    final onLoadValue = onLoad;
    await Future.delayed(const Duration(milliseconds: 500));
    return await onLoadValue;
  }

  void getData() async {
    AppMetricaService().sendLoadingPageEvent('LoadingPage');
    await context.read<LoadingProvider>().init();
    // await context.read<CartProvider>().getUserData();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
    final IPushNotificationService pushToken = PushNotificationService();
    pushToken.init();
    final healthCheck = mounted ? await _progressLoader(
      1,
      context.read<LoadingProvider>().getHealthCheck(),
    ) : false;
    final versions = mounted ? await _progressLoader(
      2,
      context.read<LoadingProvider>().getVersions(),
    ) : [];
    await _progressLoader(
      3,
      context.read<CommonProvider>().getBanners(),
    );
    await _progressLoader(
      4,
      context.read<CommonProvider>().getMenu(),
    );
    await _progressLoader(
        5,
        context.read<CommonProvider>().getBasketAndOrders()
    );
    if (mounted) {
      context.pushReplacement('/main_page');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xffF3DCC8),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/loading_page_bg.png"),
                      fit: BoxFit.fitWidth
                  )
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 40, right: 53),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(200)
                        ),
                        child: Stack(
                            children: [
                              Container(
                                  width: alpha?.value ?? 0.0,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFF451D),
                                      borderRadius: BorderRadius.circular(200)
                                  )
                              ),
                              const Center(
                                  child: Text(
                                      "đi ăn*",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Color(0xffFFFFFF)
                                      )
                                  )
                              ),
                            ])
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 7),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                                "*Пойдем кушать",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: Color(0xff000000)
                                )
                            )
                        )
                    )
                  ]
              )
          )
      )
  );
}