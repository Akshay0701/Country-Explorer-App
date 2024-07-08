import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Service class for handling GraphQL operations to fetch country data.
class GraphQLService {
  // HTTP link to the GraphQL API.
  static final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');

  // GraphQL client with caching.
  static final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
  );

  // GraphQL query to fetch country data with a filter.
  static const String countriesQuery = '''
      query GetCountries(\$regexPattern: String) {
        countries(filter: { name: { regex: \$regexPattern } }) {
          name
          capital
          currency
          emoji
          languages {
            name
          }
        }
      }
    ''';

  /// Fetches countries from the GraphQL API.
  /// Returns a QueryResult containing the data or throws an exception on error.
  Future<QueryResult> fetchCountries({String? filter}) async {
    final QueryOptions options = QueryOptions(
      document: gql(countriesQuery),
      variables: {'regexPattern': filter ?? ''},
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );

    try {
      return await client.query(options);
    } catch (e) {
      debugPrint('Error fetching countries: $e');
      throw Exception('Failed to load countries');
    }
  }
}
