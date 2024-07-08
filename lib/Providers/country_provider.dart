import 'package:flutter/material.dart';
import '../Models/country_model.dart';
import '../Services/graphql_service.dart';

/// A provider class that manages the state and logic for handling country data.
class CountryProvider with ChangeNotifier {
  // The complete list of countries fetched from the GraphQL API.
  List<Country> _countries = [];

  // Getter for the filtered list of countries.
  List<Country> get countries => _countries;

  // Text editing controller for the search bar.
  final TextEditingController _searchController = TextEditingController();

  // Getter for the search controller.
  TextEditingController get searchController => _searchController;

  // Constructor that adds a listener to the search controller for filtering countries.
  CountryProvider() {
    _searchController.addListener(_filterCountries);
  }

  // Fetches the list of countries from the GraphQL API and updates the state.
  Future<void> fetchCountries({String? filter}) async {
    final result = await GraphQLService().fetchCountries(filter: filter);
    _countries = (result.data?['countries'] as List)
        .map((country) => Country.fromJson(country))
        .toList();
    notifyListeners();
  }

  // Filters the list of countries based on the search query.
  void _filterCountries() {
    final query = _searchController.text;
    fetchCountries(filter: query);
  }

  // Removes a country from the list and updates the filtered list.
  void removeCountry(Country country) {
    _countries.remove(country);
    notifyListeners();
  }

  // Disposes the search controller when the provider is disposed.
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
