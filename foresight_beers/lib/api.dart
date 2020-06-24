import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(
        uri:
            'https://api-eu-central-1.graphcms.com/v2/ckbt8aqma02d701xt01w42mp7/master'),
  ),
);

final String getBeersQuery = """
query {
  beers {
    name
  }
}
""";
