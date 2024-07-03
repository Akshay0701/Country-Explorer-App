import 'package:flutter/material.dart';

/// DetailRow widget is used to display item detail of country data in [CountryDetailsScreen]
Widget buildDetailRow(IconData icon, String label, String value) {
  return Row(
    children: [
      Icon(icon, color: Colors.blueAccent),
      const SizedBox(width: 8),
      Text(
        '$label: ',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    ],
  );
}