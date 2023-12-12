import 'package:contact_demo/data/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get Contact', () async {
    final repository = ApiService();
    final contactList = await repository.restClient.getContact();
    expect(contactList.contacts?.length, (int length) => length > 0);
  });
}
