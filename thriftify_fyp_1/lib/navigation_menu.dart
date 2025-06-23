import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/settings/settings.dart';
import 'package:thriftify_fyp_1/features/shop/screens/Chatbot/chat_screen.dart';
import 'package:thriftify_fyp_1/features/shop/screens/Post%20Ad/post_ad_screen.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home.dart';
import 'package:thriftify_fyp_1/features/shop/screens/store/store.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

final NavigationController controller = Get.put(NavigationController());

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    const comfyGreen = Color(0xFF26A69A);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent, // No rectangle border
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (states) => TextStyle(
                color: states.contains(MaterialState.selected)
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
              (states) => IconThemeData(
                color: states.contains(MaterialState.selected)
                    ? comfyGreen
                    : const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          child: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: darkMode ? Colors.black : Colors.white,
            // indicatorColor is now handled by NavigationBarTheme

            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home), // filled when active
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.store_outlined),
                selectedIcon: Icon(Icons.store), // filled when active
                label: 'Brands',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_outlined),
                selectedIcon: Icon(Icons.add), // filled when active
                label: 'Add',
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_outlined),
                selectedIcon: Icon(Icons.chat), // filled when active
                label: 'Chat',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person), // filled when active
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex
          .value]), //this is the screen that will be displayed based on the selected index
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs; //obs variable is observed by widgets

  final screens = [
    const HomeScreen(),
    StoreScreen(),
    PostAdScreen(),
    ChatScreen(),
    const SettingsScreen(),
  ]; //list of screens to be displayed
}
