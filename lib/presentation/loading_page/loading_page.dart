import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nem_pho/presentation/loading_page/loading_provider.dart';
import 'package:provider/provider.dart';

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

  void progressLoader(double begin, double end) {
    alpha = Tween<double>(
        begin: begin * (MediaQuery.of(context).size.width - 93) / 5,
        end: end * (MediaQuery.of(context).size.width - 93) / 5
    ).animate(controller);
    controller.reset();
    controller.forward();
  }

  void getData() async {
    await context.read<LoadingProvider>().init();
    // await context.read<CartProvider>().getUserData();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      controller.addListener(() {
        setState(() {});
      });
      progressLoader(0, 1);
      await context.read<LoadingProvider>().getHealthCheck();
      progressLoader(1, 2);
      await context.read<LoadingProvider>().getVersions();
      progressLoader(2, 3);
      await context.read<LoadingProvider>().getBanners();
      progressLoader(3, 4);
      await context.read<LoadingProvider>().getMenu();
      progressLoader(4, 5);
      // controller.forward().then((value) =>
      //     Future.delayed(const Duration(milliseconds: 500)).then((value) =>
      //         Navigator.of(context).pushReplacement(MaterialPageRoute(
      //           builder: (context) => const MainPage(),
      //         )))
      // );
    });
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