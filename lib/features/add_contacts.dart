import 'package:contact_app/core/snackbar_theme.dart';
import 'package:contact_app/core/text_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewContact extends StatefulWidget {
  const AddNewContact({super.key});

  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _typeSelected = '';
  late CollectionReference _ref;
  @override
  void initState() {
    super.initState();
    _ref = FirebaseFirestore.instance.collection('contacts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contacts'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 5, right: 5),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Enter Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Name',
                      hintStyle: textInputDecorationTheme.hintStyle,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor:
                          textInputDecorationTheme.suffixIconColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _contactController,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Enter Name';
                    } else if (input.length < 10) {
                      return 'Enter 10 digit number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Contact Number',
                      hintStyle: textInputDecorationTheme.hintStyle,
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconColor:
                          textInputDecorationTheme.suffixIconColor),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 40, left: 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _contactRelation('Work'),
                      const SizedBox(
                        width: 10,
                      ),
                      _contactRelation('Home'),
                      const SizedBox(
                        width: 10,
                      ),
                      _contactRelation('Family'),
                      const SizedBox(
                        width: 10,
                      ),
                      _contactRelation('Others'),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  margin: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary),
                      onPressed: () {
                        saveContact(_nameController.text,
                            _contactController.text, _typeSelected);
                      },
                      child: const Text(
                        'Save Contacts',
                        style: TextStyle(fontSize: 18),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactRelation(String title) {
    return InkWell(
        onTap: () {
          setState(() {
            _typeSelected = title;
          });
        },
        child: Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
            color: _typeSelected == title
                ? Colors.green
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(title,
                style: const TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ));
  }

  Future<void> saveContact(String name, String number, String type) async {
    if (_formKey.currentState!.validate()) {
      QuerySnapshot nameResult = await FirebaseFirestore.instance
          .collection('contacts')
          .where('name', isEqualTo: name)
          .get();
      QuerySnapshot numberResult = await FirebaseFirestore.instance
          .collection('contacts')
          .where('number', isEqualTo: number)
          .get();

      if (nameResult.docs.isEmpty && numberResult.docs.isEmpty) {
        return _ref
            .add({'name': name, 'number': number, 'type': type}).then((value) {
          snackBarMessage(
            context,
            '$name\'s contact saved',
          );

          Navigator.of(context).pop();
        }).catchError((error) {
          snackBarMessage(context, '$name cannot be saved');
        });
      } else {
        // ignore: use_build_context_synchronously
        snackBarMessage(
          context,
          'contact already exist',
        );
      }

      // return _ref
      //     .add({'name': name, 'number': number, 'type': type}).then((value) {
      //   snackBarMessage(
      //     context,
      //     '$name\'s contact saved',
      //   );

      //   Navigator.of(context).pop();
      // }).catchError((error) {
      //   snackBarMessage(context, '$name cannot be saved');
      // });
    }
  }
}
