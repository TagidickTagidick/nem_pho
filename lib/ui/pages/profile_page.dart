import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 76,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 33,
            ),
            child: Text('Авторизация',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: Color(0xff0000000)
              ),),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 33,
            ),
            child: Text('введите номер мобильного телефона',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff0000000)
              ),),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            height: 63,
            width: double.infinity,
            color: Color(0xffF3F3F3),
            alignment: Alignment.center,
            child: TextField(
              maxLength: 11,
              autofocus: true,
              textAlign: TextAlign.center,
              cursorHeight: 26,
              cursorColor: Color(0xffff9900),
              onChanged: (value) {
                if (value.length == 11) {
                  showButton = true;
                  setState(() {});
                }
                else {
                  showButton = false;
                  setState(() {});
                }
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                //hintText: '+7 (###) ###-##-##',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.white.withOpacity(0.3)),
              ),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xffF0000008)
              ),
            ),
          ),
          SizedBox(
            height: 116,
          ),
          const SizedBox(
            height: 28,
          ),
          if (showButton)
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  'Получить код',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff000000)
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Text(
                        'Нажимая “получить код”, вы принимаете условия',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12),
                      ),
                      CupertinoButton(
                        onPressed: () {},
                        borderRadius: BorderRadius.circular(5),
                        child: Text(
                          'Пользовательского соглашения',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Center(
                //   child: Stack(
                //     alignment: Alignment.topCenter,
                //     children: <Widget>[
                //       Text(
                //         'Нажимая “получить код”, вы принимаете условия',
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //             color: Colors.white.withOpacity(0.7),
                //             fontSize: 12),
                //       ),
                //       CupertinoButton(
                //         onPressed: () {},
                //         borderRadius: BorderRadius.circular(5),
                //         child: Text(
                //           'Пользовательского соглашения',
                //           style: const TextStyle(
                //             color: Colors.white,
                //             fontSize: 12,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),

    );
  }

  buildTextField(BuildContext context, state) {}
}


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.child,
    this.color = Colors.yellow,
    this.height = 50,
  });

  factory PrimaryButton.icon(
      {Key? key,
        required VoidCallback? onTap,
        required IconData icon,
        required Widget label}) = _PrimaryButtonWithIcon;

  final VoidCallback? onTap;
  final Widget child;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Align(alignment: Alignment.center, child: child),
        ),
      ),
    );
  }
}
class _PrimaryButtonWithIcon extends PrimaryButton {
  _PrimaryButtonWithIcon({
    super.key,
    required super.onTap,
    required IconData icon,
    required Widget label,
  }) : super(
    child: _PrimaryButtonWithIconChild(
      icon: icon,
      label: label,
    ),
  );
}

class _PrimaryButtonWithIconChild extends StatelessWidget {
  const _PrimaryButtonWithIconChild({required this.icon, required this.label});

  final IconData icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        label
      ],
    );
  }
}