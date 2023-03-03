import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ViewContact extends StatelessWidget {
  ViewContact(
      {super.key,
      required this.name,
      required this.number,
      required this.type});
  final String name;
  final String number;
  final String type;

  String initials = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.aleo(
        fontSize: 22,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600);
    TextStyle nameStyle =
        GoogleFonts.acme(fontSize: 18, fontWeight: FontWeight.w300);

    if (name != '') {
      initials = initials + name.substring(0, 1).toUpperCase();
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          title: Text('$name\'s Details ')),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(width: 5, color: Colors.white),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Text(
                          initials,
                          style: const TextStyle(fontSize: 30),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(name, style: textStyle),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "User Information",
                              style: GoogleFonts.acme(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Card(
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4),
                                            leading: const Icon(Icons.person),
                                            title: const Text(
                                              "Name",
                                            ),
                                            subtitle: Text(
                                              name,
                                              style: nameStyle,
                                            ),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.phone),
                                            title: const Text(
                                              "Phone",
                                            ),
                                            subtitle: Text(
                                              number,
                                              style: nameStyle,
                                            ),
                                          ),
                                          ListTile(
                                              leading: const Icon(Icons.person),
                                              title: const Text(
                                                "About Me",
                                              ),
                                              subtitle: Text(
                                                type,
                                                style: nameStyle,
                                              )),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Container(
        //       alignment: Alignment.center,
        //       padding: const EdgeInsets.only(top: 40),
        //       child: CircleAvatar(
        //         radius: 50,
        //         backgroundColor: Theme.of(context).colorScheme.primary,
        //         child: Text(
        //           initials.toUpperCase(),
        //           style:
        //               const TextStyle(fontSize: 30, color: Color(0xffffffff)),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 25,
        //     ),
        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 60),
        //       child: Row(
        //         children: [
        //           Icon(
        //             Icons.person_3_rounded,
        //             color: Theme.of(context).colorScheme.secondary,
        //           ),
        //           const SizedBox(
        //             width: 20,
        //           ),
        //           Text(
        //             name,
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 letterSpacing: 2,
        //                 color: Theme.of(context).colorScheme.primary),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        //       child: Row(
        //         children: [
        //           Icon(
        //             Icons.phone_android,
        //             color: Theme.of(context).colorScheme.secondary,
        //           ),
        //           const SizedBox(
        //             width: 20,
        //           ),
        //           Text(
        //             number,
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 letterSpacing: 1,
        //                 color: Theme.of(context).colorScheme.primary),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
        //       child: Row(
        //         children: [
        //           Icon(
        //             Icons.group_work,
        //             color: Theme.of(context).colorScheme.secondary,
        //           ),
        //           const SizedBox(
        //             width: 20,
        //           ),
        //           Text(
        //             type,
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 letterSpacing: 1,
        //                 color: Theme.of(context).colorScheme.primary),
        //           ),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
