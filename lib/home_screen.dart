import 'package:flutter/material.dart';
import 'package:mediscanaiapp/flu_eye_screen.dart';
import 'package:mediscanaiapp/info_screen.dart';
import 'package:mediscanaiapp/cataract_eye_screen.dart';
import 'package:mediscanaiapp/lung_tomography_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CardItem> items = [
      CardItem(
        title: "Cataract Eye",
        description:
            "Detect cataracts with a quick eye test. For more details, visit the full section.",
        assetPath: "assets/cataract_eye.png",
        destinationScreen: const CataractEyeScreen(),
      ),
      CardItem(
        title: "Lung Tomography",
        description:
            "We detect lung conditions through advanced tomography scans. For more details, visit the full section.",
        assetPath: "assets/lung_tomography.png",
        destinationScreen: const LungTomographyScreen(),
      ),
      CardItem(
        title: "Flu Eye",
        description:
            "Detect eye flu with a simple test. For more info, visit the details section.",
        assetPath: "assets/flu_eye.png",
        destinationScreen: const FluEyeScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MediScan AI',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.health_and_safety_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoScreen()),
              );
            },
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item.destinationScreen),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.teal.withOpacity(0.7),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(item.assetPath),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.2),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardItem {
  final String title;
  final String description;
  final String assetPath;
  final Widget destinationScreen;

  CardItem({
    required this.title,
    required this.description,
    required this.assetPath,
    required this.destinationScreen,
  });
}
