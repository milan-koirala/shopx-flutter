import 'package:flutter/material.dart';
import 'package:shopx_flutter/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header: logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.shopping_bag,
                    size: 72,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // shop title
              MyListTile(
                text: "Shop",
                icon: Icons.home,
                onTap: () => Navigator.pop(context),
              ),

              //cart tile
              MyListTile(
                text: "Cart",
                icon: Icons.shopping_cart,
                onTap: () {
                  // pop drawer first
                  Navigator.pop(context);

                  // go to cart page
                  Navigator.pushNamed(context, "/cart_page");
                },
              ),

              //cart tile
              MyListTile(
                text: "Settings",
                icon: Icons.settings,
                onTap: () {
                  // pop drawer first
                  Navigator.pop(context);

                  // go to settings page
                  Navigator.pushNamed(context, "/setting_page");
                },
              ),

              //cart tile
              MyListTile(
                text: "Wishlist",
                icon: Icons.favorite,
                onTap: () {
                  // pop drawer first
                  Navigator.pop(context);

                  // go to wishlist page
                  Navigator.pushNamed(context, "/wishlist_page");
                },
              ),
            ],
          ),

          // exit shop title
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              text: "Exit",
              icon: Icons.logout,
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                "/intro_page",
                (route) => false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
