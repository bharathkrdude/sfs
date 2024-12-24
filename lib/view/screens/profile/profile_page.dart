import 'package:flutter/material.dart';
import 'package:sfs/view/screens/orders/orders_screen.dart';
import 'package:sfs/view/screens/profile/widgets/custom_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                     
                      Colors.blue.shade100,
                       Colors.blue.shade700,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/200', // Replace with your image
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Name
                    const Text(
                      'Rahul Kumar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Class
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Class XII - Science',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              CustomTile(
                icon: Icons.my_library_books_outlined,
                title: 'Orders',
                color: Colors.blue,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OrdersScreen()));
                },
              ),
              CustomTile(
                icon: Icons.settings,
                title: 'Settings',
                color: Colors.green,
                ontap: () {},
              ),
              CustomTile(
                icon: Icons.notifications,
                title: 'Notifications',
                color: Colors.orange,
                ontap: () {},
              ),
              CustomTile(
                icon: Icons.security,
                title: 'Privacy',
                color: Colors.purple,
                ontap: () {},
              ),
              CustomTile(
                icon: Icons.help_outline,
                title: 'Help & Support',
                color: Colors.teal,
                ontap: () {},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
