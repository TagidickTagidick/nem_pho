import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/drawer/terrm_use.dart';
import 'package:video_player/video_player.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> with SingleTickerProviderStateMixin {
  bool isExpanded = true;

  late AnimationController _controller;

  late VideoPlayerController _videoPlayerController;

  bool isPlaying = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this
    );
    _controller.forward();
    _videoPlayerController = VideoPlayerController.asset('images/video.mp4');
    _videoPlayerController.initialize();
    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.value.isPlaying) {
        isPlaying = false;
        setState(() {

        });
      }
      else {
        isPlaying = true;
        setState(() {

        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 21),
                        decoration: BoxDecoration(
                            color: const Color(0xffF6F6F6),
                            border: Border.all(
                                color: const Color(0xffF8DFDF)
                            ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
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
                              Center(
                                  child: Image.asset("images/drawer/drawer_logo.png")
                              ),
                              Center(
                                  child: Image.asset("images/drawer/drawer_title.png")
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("IP",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermUse()));
                              },
                                  child: Row(
                                      children: [
                                        const SizedBox(width: 39),
                                        const Expanded(
                                            child: Text(
                                                "Пользовательское соглашение",
                                                style: TextStyle(
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
                                      ]
                                  )
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (isExpanded) {
                                      _controller.reverse();
                                    } else {
                                      _controller.forward();
                                    }
                                    isExpanded = !isExpanded;
                                  },
                                  child: Row(
                                      children: [
                                        const SizedBox(width: 39),
                                        const Expanded(
                                            child: Text(
                                                "Политика конфидециальности",
                                                style: TextStyle(
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
                                      ]
                                  )
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (isExpanded) {
                                      _controller.reverse();
                                    } else {
                                      _controller.forward();
                                    }
                                    isExpanded = !isExpanded;
                                  },
                                  child: Row(
                                      children: [
                                        const SizedBox(width: 39),
                                        const Expanded(
                                            child: Text(
                                                "Положение об обработке персональных данных",
                                                style: TextStyle(
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
                                      ]
                                  )
                              ),
                              const Divider(color: Color(0xffF0E0E0)),
                              SizeTransition(
                                  sizeFactor: _controller.view,
                                  child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 9,
                                          horizontal: 31
                                      ),
                                      child: Text(
                                          "Описание!3\n\n",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Color(0xff000000)
                                          )
                                      )
                                  )
                              )
                            ]
                        )
                    ),
                  ]
              )
          )
      )
  );
}