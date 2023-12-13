import 'package:contact_demo/providers/auth_firebase.dart';
import 'package:contact_demo/view/screens/home/bookmark_tab.dart';
import 'package:contact_demo/view/screens/home/cloud_tab.dart';
import 'package:contact_demo/view/theme/hicon_icons.dart';
import 'package:contact_demo/view/theme/images.dart';
import 'package:contact_demo/view/theme/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthFirebaseProvider>(context);
    User? user = provider.currentUser;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(spacing1xHalf),
            child: ClipOval(child: Image.asset(logo)),
          ),
          title: Text("KawanLama Contact"),
          actions: [
            if (user != null)
              MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    child: Text(
                      user.email ?? '-',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  MenuItemButton(
                      onPressed: () {
                        provider.logout().then((_) => Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Logout',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.error),
                          ),
                          const SizedBox(
                            width: spacing1xHalf,
                          ),
                          Icon(Hicon.logout,
                              color: Theme.of(context).colorScheme.error)
                        ],
                      ))
                ],
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return IconButton(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: CircleAvatar(
                      child: Image.network(user.photoURL ??
                          "https://ui-avatars.com/api/?name=${user.displayName?.split(" ").join("+")}"),
                    ),
                  );
                },
              ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              text: "Cloud",
              icon: Icon(Icons.cloud),
            ),
            Tab(
              text: "Bookmark",
              icon: Icon(Icons.bookmark),
            ),
          ]),
        ),
        body: TabBarView(
          children: [CloudTab(), BookmarkTab()],
        ),
      ),
    );
  }
}
