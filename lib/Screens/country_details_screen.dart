import 'package:flutter/material.dart';

import '../Models/country_model.dart';
import '../Widgets/detail_row.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Country country;

  CountryDetailsScreen({required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${country.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    country.emoji,
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
                const SizedBox(height: 16),
                buildDetailRow(Icons.location_city, 'Name', country.name),
                const SizedBox(height: 8),
                buildDetailRow(Icons.location_on, 'Capital', country.capital ?? 'N/A'),
                const SizedBox(height: 8),
                buildDetailRow(Icons.attach_money, 'Currency', country.currency ?? 'N/A'),
                const SizedBox(height: 8),
                buildDetailRow(Icons.language, 'Languages', country.languages.join(', ')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
