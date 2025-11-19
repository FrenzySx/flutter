import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("About Us", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "BRINGING INSPIRATION AND INNOVATION TO ALL.",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "We believe in pushing boundaries. From design to technology, we provide the most advanced tools for every individual to reach their full potential.",
              style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 30),
            _buildInfoCard(
              title: "OUR MISSION",
              description:
                  "To bring inspiration and innovation to every athlete in the world. If you have a body, you are an athlete.",
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              title: "OUR VISION",
              description:
                  "Transforming our production processes for a sustainable future and creating a positive impact on communities.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String description}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(description, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
