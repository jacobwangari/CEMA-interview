import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Medication {
  final String name;
  final String description;
  final String dosage;
  final int quantity;
  final double price;
  final String expiryDate;
  final String manufacturer;

  Medication({
    required this.name,
    required this.description,
    required this.dosage,
    required this.quantity,
    required this.price,
    required this.expiryDate,
    required this.manufacturer,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'],
      description: json['description'],
      dosage: json['dosage'],
      quantity: json['quantity'],
      price: json['price'],
      expiryDate: json['expiry_date'],
      manufacturer: json['manufacturer'],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Medication>> _medicationsFuture;

  @override
  void initState() {
    super.initState();
    _medicationsFuture = _fetchMedications();
  }

  Future<List<Medication>> _fetchMedications() async {
    final String url = 'http://your-api-url/medications/';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Medication.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load medications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medications'),
      ),
      body: FutureBuilder<List<Medication>>(
        future: _medicationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final medications = snapshot.data!;
            return ListView.builder(
              itemCount: medications.length,
              itemBuilder: (context, index) {
                final medication = medications[index];
                return ListTile(
                  title: Text(medication.name),
                  subtitle: Text('${medication.quantity} in stock'),
                  onTap: () {
                    // Add navigation or other actions when a medication is tapped
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
