import 'package:ecommerceassim/components/appBar/custom_app_bar.dart';
import 'package:ecommerceassim/screens/profile/components/custom_ink.dart';
import 'package:ecommerceassim/screens/screens_index.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';
import 'package:ecommerceassim/shared/core/user_storage.dart';
import 'package:ecommerceassim/shared/components/BottomNavigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserStorage userStorage = UserStorage();
    int selectedIndex = 3; // Assuming index 3 is for the profile tab

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomNavigation(selectedIndex: selectedIndex),
      body: Column(
        children: [
          // Green header with user information
          Container(
            color: kDetailColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg"), // Placeholder image
                    radius: 30,
                  ),
                  const SizedBox(width: 16),
                  FutureBuilder<String>(
                    future:
                        userStorage.getUserName(), // Async user name loading
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Carregando...',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18));
                      } else if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const Text('Convidado',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500));
                      } else {
                        return Text(snapshot.data!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Profile menu options
          Expanded(
            child: ListView(
              // Assuming CustomInkWell is a previously defined widget for menu items
              children: [
                CustomInkWell(
                  icon: Icons.shopping_bag,
                  text: 'Pedidos',
                  onTap: () => Navigator.pushNamed(context, Screens.purchases),
                ),
                CustomInkWell(
                  icon: Icons.location_on,
                  text: 'Endereços',
                  onTap: () => Navigator.pushNamed(context, Screens.adress),
                ),
                // ... Add more items here
              ],
            ),
          ),
          // Add a logout button or other actions at the bottom if needed
        ],
      ),
    );
  }
}



// BottomNavigation widget is assumed to be defined elsewhere
