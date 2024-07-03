import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:provider/provider.dart';
import '../Models/country_model.dart';
import '../Providers/country_provider.dart';
import '../screens/country_details_screen.dart';

/// CountryListItem widget is used to display each item of country data in [CountryListScreen]
class CountryListItem extends StatelessWidget {
  final Country country;

  CountryListItem({required this.country});

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ValueKey(country.name),
      trailingActions: [
        SwipeAction(
          title: "Details",
          color: Colors.blueAccent,
          icon: const Icon(Icons.info_outline, color: Colors.white),
          onTap: (CompletionHandler handler) async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetailsScreen(country: country),
              ),
            );
          },
        ),
        SwipeAction(
          title: "Remove",
          color: Colors.redAccent,
          icon: const Icon(Icons.delete_outline, color: Colors.white),
          onTap: (CompletionHandler handler) async {
            bool confirm = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Remove ${country.name}?',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  'Are you sure you want to remove ${country.name}?',
                  style: const TextStyle(color: Colors.black54),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            );

            // remove country item from country list of provider if user selected Yes
            if (confirm) {
              Provider.of<CountryProvider>(context, listen: false).removeCountry(country);
            }
            handler(false); // Ensure swipe action cell returns to original position
          },
        ),
      ],
      child: ListTile(
        title: Text(country.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(country.capital ?? 'No Capital'),
        leading: Text(country.emoji, style: const TextStyle(fontSize: 30)),
      ),
    );
  }
}
