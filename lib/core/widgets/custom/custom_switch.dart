import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch(
      {super.key,
      required this.first,
      required this.second,
      required this.ratio});

  final String first;
  final String second;
  final double ratio;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSecond = false;

  @override
  Widget build(BuildContext context) => Stack(children: [
        Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
                color: const Color(0xffFF451D),
                borderRadius: BorderRadius.circular(200))),
        AnimatedAlign(
            alignment: isSecond ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 40,
                width: widget.ratio,
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(color: const Color(0xffF0B0B0))))),
        SizedBox(
            height: 40,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () => setState(() => isSecond = false),
                      child: Text(widget.first,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: isSecond
                                  ? const Color(0xffFFFFFF)
                                  : const Color(0xff000000)))),
                  GestureDetector(
                      onTap: () => setState(() => isSecond = true),
                      child: Text(widget.second,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: isSecond
                                  ? const Color(0xff000000)
                                  : const Color(0xffFFFFFF))))
                ]))
      ]);
}
