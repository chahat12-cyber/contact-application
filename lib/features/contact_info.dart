import 'package:contact_app/core/snackbar_theme.dart';
import 'package:contact_app/features/edit_contacts.dart';
import 'package:contact_app/features/services/delete_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildContactItem(
    {required String id,
    required String name,
    required BuildContext context,
    required String number,
    required String type}) {
  TextStyle textStyle = GoogleFonts.aleo(
      fontSize: 16,
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600);
  Color typeColor = getTypeColor(type, context);
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(10),
    height: 130,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.black,
                size: 20,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(name, style: textStyle),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(
                  Icons.phone_iphone,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(number, style: textStyle),
              ]),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.group_work,
                      color: typeColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(type, style: textStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: GestureDetector(
                  onTap: () async {
                    Uri phoneno = Uri.parse('tel:$number');
                    if (await launchUrl(phoneno)) {
                    } else {}
                  },
                  child: Row(
                    children: [
                      Icon(Icons.call,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(
                        width: 6,
                      ),
                      Text('Call',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditContact(
                              id: id, name: name, number: number, type: type)));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text('Edit',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  deleteProduct(id).then((value) {
                    snackBarMessage(context, '$name\'s contact deleted');
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.delete,
                        size: 20, color: Theme.of(context).colorScheme.error),
                    const SizedBox(
                      width: 6,
                    ),
                    Text('Delete',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Color getTypeColor(String type, BuildContext context) {
  Color color = Theme.of(context).colorScheme.primary;

  if (type == 'Work') {
    color = const Color(0xfff89344);
  }

  if (type == 'Family') {
    color = const Color(0xffff642f);
  }

  if (type == 'Others') {
    color = const Color(0xff575959);
  }
  return color;
}
