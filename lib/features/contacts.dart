import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/features/add_contacts.dart';
import 'package:contact_app/features/contact_info.dart';
import 'package:contact_app/features/view_contacts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late Query collectionReference;
  @override
  void initState() {
    super.initState();
    collectionReference =
        FirebaseFirestore.instance.collection("contacts").orderBy('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Contact Application')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewContact()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 20),
                child: Text(
                  'List of Contacts',
                  style: GoogleFonts.acme(fontSize: 29),
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('contacts')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: 600,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewContact(
                                                name: data['name'],
                                                number: data['number'],
                                                type: data['type'],
                                              )));
                                },
                                child: buildContactItem(
                                    id: data.id,
                                    name: data['name'],
                                    context: context,
                                    number: data['number'],
                                    type: data['type']),
                              );
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
