import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(57.62987, 39.87368),
  //   zoom: 12.5
  // );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar()
    ),
    body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
            top: 15,
            left: 23,
            right: 13,
            bottom: 15
          ),
          // child: const GoogleMap(
          //     initialCameraPosition: _kGooglePlex
          // )
        )
      ]
    )
  );
}