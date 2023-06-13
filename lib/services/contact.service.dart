import 'package:flutter/foundation.dart';
import '../modal/contact.model.dart';
import '../utils/contact.database.dart';

class ContactService {
  final ContactDatabase _contactDatabase = ContactDatabase.instance;

  Future<List<Contact>> getContacts() async {
    return await _contactDatabase.readAllContacts();
  }

  Future<void> createContact(Contact contact) async {
    await _contactDatabase.create(contact);
  }

  Future<void> updateContact(Contact contact) async {
    await _contactDatabase.update(contact);
  }

  Future<void> deleteContact(Contact contact) async {
    await _contactDatabase.delete(contact.id);
  }
}
