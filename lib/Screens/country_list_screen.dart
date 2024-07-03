import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/country_provider.dart';
import '../widgets/country_list_item.dart';

/// CountryListScreen widget that displays a list of countries with search bar and swipe actions.
class CountryListScreen extends StatefulWidget {
  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryProvider>(context, listen: false).fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Explorer'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<CountryProvider>(
              builder: (context, countryProvider, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: countryProvider.searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search Countries',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<CountryProvider>(
          builder: (context, countryProvider, child) {
            final countriesToShow = countryProvider.countries;

            if (countriesToShow.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: countriesToShow.length,
              itemBuilder: (context, index) {
                final country = countriesToShow[index];
                return CountryListItem(country: country);
              },
            );
          },
        ),
      ),
    );
  }
}
