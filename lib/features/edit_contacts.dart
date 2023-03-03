import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/core/snackbar_theme.dart';
import 'package:contact_app/core/text_input_decoration.dart';
import 'package:contact_app/features/services/edit_user.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  const EditContact(
      {super.key,
      required this.id,
      required this.name,
      required this.number,
      required this.type});
  final String id;
  final String name;
  final String number;
  final String type;

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String _typeSelected = '';
  late String id;
  @override
  void initState() {
    super.initState();
    id = widget.id;
    _nameController.text = widget.name;
    _numberController.text = widget.number;
    _typeSelected = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${widget.name}\'s Contact'),
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
                  controller: _numberController,
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
                      onPressed: () async {
                        QuerySnapshot nameResult = await FirebaseFirestore
                            .instance
                            .collection('contacts')
                            .where('name', isEqualTo: _nameController.text)
                            .get();
                        QuerySnapshot numberResult = await FirebaseFirestore
                            .instance
                            .collection('contacts')
                            .where('number', isEqualTo: _numberController.text)
                            .get();

                        // ignore: use_build_context_synchronously

                        if (nameResult.docs.isEmpty &&
                            numberResult.docs.isEmpty) {
                          editContact(
                            id: id,
                            name: _nameController.text,
                            number: _numberController.text,
                            type: _typeSelected,
                          ).then((value) {
                            snackBarMessage(
                                context, '${widget.name}\'s contact updated');
                            Navigator.of(context).pop();
                          });
                        } else {
                          // ignore: use_build_context_synchronously
                          snackBarMessage(context, 'Contact already exist');
                        }
                      },
                      child: const Text(
                        'Edit Contacts',
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
}
