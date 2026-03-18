import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List locations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    final url = Uri.parse('https://ghibliapi.vercel.app/locations');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          locations = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildLocationCard(location) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          // Image (random scenic placeholder)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://picsum.photos/100/100?random=${location['id'].hashCode}",
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Climate: ${location['climate'] ?? 'Unknown'}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  "Terrain: ${location['terrain'] ?? 'Unknown'}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),

          Icon(Icons.place, color: Colors.redAccent),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return buildLocationCard(locations[index]);
        },
      ),
    );
  }
}
