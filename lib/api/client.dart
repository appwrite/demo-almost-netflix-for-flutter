//
// provider.dart
// figures
// 
// Author: Wess Cope (me@wess.io)
// Created: 06/15/2021
// 
// Copywrite (c) 2021 Wess.io
//

import 'package:appwrite/appwrite.dart';

class ApiClient {
  Client get _client {
    Client client = Client();

    client
    .setEndpoint('https://demo.appwrite.io/v1')
    .setProject('almostNetflix2')
    .setSelfSigned();
    
    return client;
  }

  static Account get account => Account(_instance._client);
  static Database get database => Database(_instance._client);
  static Storage get storage => Storage(_instance._client);

  static final ApiClient _instance = ApiClient._internal();
  ApiClient._internal();
  factory ApiClient() => _instance;
}