import 'package:flutter/material.dart';
import '../modal/contact.model.dart';
import 'ajout_modif.page.dart';
import '../services/contact.service.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ContactService _contactService = ContactService();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    _contacts = await _contactService.getContacts();
    setState(() {}); // Update the UI after fetching the contacts
    print(_contacts.length);
  }

  Future<void> _deleteContact(Contact contact) async {
    await _contactService.deleteContact(contact);
    _fetchContacts(); // Fetch the contacts again after deleting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact.nom),
            subtitle: Text(contact.tel),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Supprimer le contact'),
                    content: Text('Êtes-vous sûr de vouloir supprimer ce contact ?'),
                    actions: [
                      TextButton(
                        child: Text('Annuler'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Supprimer'),
                        onPressed: () {
                          _deleteContact(contact);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjoutModifContactPage(),
            ),
          ).then((_) {
            _fetchContacts(); // Fetch the contacts again after returning from the add/edit page
          });
        },
      ),
    );
  }
}
