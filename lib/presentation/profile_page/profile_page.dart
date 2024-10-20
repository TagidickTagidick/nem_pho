import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/profile_page/profile_provider/profile_provider.dart';
import 'package:nem_pho/presentation/profile_page/widgets/my_info.dart';
import 'package:nem_pho/presentation/profile_page/widgets/my_orders.dart';
import 'package:nem_pho/presentation/profile_page/widgets/profile_tabs.dart';
import 'package:nem_pho/core/widgets/app_bar/custom_appbar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isStory = false;

  final PageController _controller = PageController();

  @override
  void initState() {
    context.read<ProfileProvider>().initUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(context.watch<ProfileProvider>().isLoading) {
      return const Scaffold(
        backgroundColor: Colors.indigo,
      );
    }
    return Scaffold(
      appBar: const CustomAppBar(
        isLogin: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            ProfileTabs(pageController: _controller),
            const SizedBox(height: 27),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  MyOrders(),
                  MyInfo(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
