/// A model class representing a country.
class Country {
  final String name;

  final String? capital;

  final String? currency;

  final List<String> languages;

  final String emoji;

  /// Constructs a [Country] instance.
  /// [name]: The name of the country.
  /// [capital]: The capital city of the country.
  /// [currency]: The currency used in the country.
  /// [languages]: The languages spoken in the country.
  /// [emoji]: The emoji representing the country's flag.
  Country({
    required this.name,
    this.capital,
    this.currency,
    required this.languages,
    required this.emoji,
  });

  /// Constructs a [Country] instance from a JSON map.
  /// [json]: The JSON map containing country data.
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String,
      capital: json['capital'] as String?,
      currency: json['currency'] as String?,
      languages: (json['languages'] as List)
          .map((lang) => lang['name'] as String)
          .toList(),
      emoji: json['emoji'] as String,
    );
  }
}