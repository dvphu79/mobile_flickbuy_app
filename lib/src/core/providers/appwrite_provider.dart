import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String appwriteEndpoint = 'https://fra.cloud.appwrite.io/v1';
const String appwriteProjectId = '68413fe7001941b40808';
const String appwriteDatabaseId = '684141a6001cb57a8288';
const String appwriteProductsCollectionId = '684141c0002a656e4c2e';

final appwriteClientProvider = Provider<Client>((ref) {
  Client client = Client();
  client
      .setEndpoint(appwriteEndpoint)
      .setProject(appwriteProjectId)
      .setSelfSigned(
        status: true,
      ); // Use true for self-signed certificates during development
  return client;
});

final appwriteAccountProvider = Provider<Account>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabasesProvider = Provider<Databases>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});
