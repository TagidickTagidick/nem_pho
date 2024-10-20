import 'package:flutter/material.dart';

class AboutAppTile extends StatefulWidget {
  const AboutAppTile({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  State<AboutAppTile> createState() => _AboutAppTileState();
}

class _AboutAppTileState extends State<AboutAppTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this
    );
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(onTap: () {
          if (isExpanded) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
          isExpanded = !isExpanded;
          setState(() {});
        },
            child: Row(children: [
              const SizedBox(width: 39),
              Expanded(
                  child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  )
              ),
              Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xff000000)
              ),
              const SizedBox(width: 29.01)
            ])
        ),
        SizeTransition(
            sizeFactor: _controller.view,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 31),
              child: Text(
                widget.text,
              ),
            )
        ),
      ],
    );
  }
}