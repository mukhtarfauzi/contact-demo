import 'package:contact_demo/data/models/contact_list_model.dart';
import 'package:contact_demo/data/models/user_model.dart';
import 'package:contact_demo/providers/auth_firebase.dart';
import 'package:contact_demo/data/services/api_service.dart';
import 'package:contact_demo/providers/base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class ManageContactProvider extends BaseProvider {
  late ApiService _apiService;
  set auth(AuthFirebaseProvider value) {
    _apiService = ApiService(value);
  }

  final _box = Hive.box<ContactList>('contact');
  ContactList get savedContact => _box.get('data') ?? ContactList();

  bool isContactSaved(int? id) => savedContact.contacts?.any((element) => element.id == id) ?? false;

  void saveContact(User user) {
    if (!isContactSaved(user.id)) {
      List<User> users = savedContact.contacts ?? [];
      users.add(user);
      _box.put('data', ContactList(
        contacts: users
      ));
      notifyListeners();
    }
  }

  void deleteContact(int id) {
    if (isContactSaved(id)) {
      List<User> users = savedContact.contacts ?? [];
      users.removeWhere((user) => user.id == id);
      _box.put('data', ContactList(
          contacts: users
      ));
      notifyListeners();
    }
  }


  ContactList _contacts = ContactList();
  ContactList get contacts => _contacts;
  set contacts(ContactList value) {
    _contacts = value;
    notifyListeners();
  }

  Future<void> getContact({
    ValueSetter<ContactList>? onSuccess,
    ValueSetter<String>? onFailure,
  }) async {
    try {
      loadingState = true;
      var response = await _apiService.restClient.getContact();
      if (response != null) {
        contacts = response;
        if(onSuccess != null)onSuccess(response);
      }
      return;
    } on DioException catch (e) {
      Response? response = e.response;
      if (response != null) {
        if(onFailure != null)onFailure("${response.data}");
      } else {
        throw Exception();
      }
    } catch (e) {
      if(onFailure != null)onFailure('Something went wrong');
    } finally {
      loadingState = false;
    }
  }

}
