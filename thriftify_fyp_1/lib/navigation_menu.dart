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
    return Scaffold(
      bottomNavigationBar: Obx(
        //this is observer widget, it will rebuild when the selectedIndex changes
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: darkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),


          destinations: const [
            //these are the destinations that will be displayed in the bottom navigation bar
            //each destination has an icon and a label
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.store),
              label: 'Brands',
            ),
            NavigationDestination(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            NavigationDestination(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
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
