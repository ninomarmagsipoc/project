import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Species extends StatefulWidget {
  const Species({super.key});

  @override
  State<Species> createState() => _SpeciesState();
}

class _SpeciesState extends State<Species> {
  List speciesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSpecies();
  }

  Future<void> fetchSpecies() async {
    final url = Uri.parse('https://ghibliapi.vercel.app/species');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          speciesList = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load species');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildSpeciesCard(species) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpeciesDetailPage(species: species),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: Row(
          children: [

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    species['name'] ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Class: ${species['classification'] ?? 'Unknown'}"),
                  Text("Eyes: ${species['eye_colors'] ?? 'Unknown'}"),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
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
        itemCount: speciesList.length,
        itemBuilder: (context, index) {
          return buildSpeciesCard(speciesList[index]);
        },
      ),
    );
  }
}

// ✅ DETAIL PAGE
class SpeciesDetailPage extends StatelessWidget {
  final Map species;

  const SpeciesDetailPage({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: Text(species['name'] ?? 'Species'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.auto_awesome,
                size: 50,
                color: Colors.deepPurple,
              ),
            ),
          ),

          const SizedBox(height: 20),

          buildInfoCard("Name", species['name']),
          buildInfoCard("Classification", species['classification']),
          buildInfoCard("Eye Colors", species['eye_colors']),
          buildInfoCard("Hair Colors", species['hair_colors']),
        ],
      ),
    );
  }

  Widget buildInfoCard(String title, dynamic value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(value?.toString() ?? "Unknown"),
          ),
        ],
      ),
    );
  }
}