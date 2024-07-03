import 'package:flutter/material.dart';
import '../Models/country_model.dart';
import '../Services/graphql_service.dart';

/// A provider class that manages the state and logic for handling country data.
class CountryProvider with ChangeNotifier {
  // The complete list of countries fetched from the GraphQL API.
  List<Country> _countries = [];

  // The filtered list of countries based on the search query.
  // This list is displayed to the user, while `_countries` serves as the master list
  // containing all countries fetched from the API.
  List<Country> _filteredCountries = [];

  // Getter for the filtered list of countries.
  List<Country> get countries => _filteredCountries;

  // Text editing controller for the search bar.
  final TextEditingController _searchController = TextEditingController();

  // Getter for the search controller.
  TextEditingController get searchController => _searchController;

  // Constructor that adds a listener to the search controller for filtering countries.
  CountryProvider() {
    _searchController.addListener(_filterCountries);
  }

  // Fetches the list of countries from the GraphQL API and updates the state.
  Future<void> fetchCountries() async {
    final result = await GraphQLService().fetchCountries();
    _countries = (result.data?['countries'] as List)
        .map((country) => Country.fromJson(country))
        .toList();
    _filteredCountries = _countries;
    notifyListeners();
  }

  // Removes a country from the list and updates the filtered list.
  void removeCountry(Country country) {
    _countries.remove(country);
    _filterCountries();
  }

  // Filters the list of countries based on the search query.
  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    _filteredCountries = _countries.where((country) {
      return country.name.toLowerCase().contains(query);
    }).toList();
    notifyListeners();
  }

  // Disposes the search controller when the provider is disposed.
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
