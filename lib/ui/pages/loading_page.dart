import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  int progress = 0;

  late final AnimationController controller;
  Animation<double>? alpha;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      alpha =
          Tween<double>(begin: 0, end: MediaQuery.of(context).size.width - 93)
              .animate(controller);
      controller.addListener(() {
        setState(() {});
      });
      controller.forward().then((value) =>
          Future.delayed(const Duration(milliseconds: 500)).then(
              (value) => Navigator.of(context).pushReplacementNamed("/main")));
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
                      fit: BoxFit.fitWidth)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 40, right: 53),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(200)),
                    child: Stack(children: [
                      Container(
                          width: alpha?.value ?? 0.0,
                          decoration: BoxDecoration(
                              color: const Color(0xffFF451D),
                              borderRadius: BorderRadius.circular(200))),
                      const Center(
                          child: Text("đi ăn*",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color(0xffFFFFFF))))
                    ])),
                SizedBox(height: MediaQuery.of(context).size.height / 7),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("*Пойдем кушать",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Color(0xff000000)))))
              ]))));
}
