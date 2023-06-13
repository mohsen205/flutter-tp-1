import 'package:flutter/material.dart';
import '../modal/contact.model.dart';
import '../services/contact.service.dart';
import 'dart:math';

class AjoutModifContactPage extends StatefulWidget {
  @override
  _AjoutModifContactPageState createState() => _AjoutModifContactPageState();
}

class _AjoutModifContactPageState extends State<AjoutModifContactPage> {
  final ContactService _contactService = ContactService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _telController;
  late bool _isEditMode;
  late Contact? _contact;
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _telController = TextEditingController();
    _isEditMode = false;
    _contact = null;
  }

  @override
  void dispose() {
    _nomController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Modifier le contact' : 'Ajouter un contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telController,
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveContact,
                child: Text(_isEditMode ? 'Modifier' : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveContact() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String nom = _nomController.text.trim();
    final String tel = _telController.text.trim();

    if (_isEditMode) {
      // Rest of the code...
    } else {
      final newContact = Contact(
        id: _random.nextInt(1000000), // Generate a random ID
        nom: nom,
        tel: tel,
      );
      await _contactService.createContact(newContact);

      // Display a snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contact ajouté'),
        ),
      );

      // Clear the input fields
      _nomController.clear();
      _telController.clear();
    }
  }
}
