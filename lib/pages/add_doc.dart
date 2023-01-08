import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:prega/widgets/heading.dart';

class AddDoc extends StatefulWidget {
  const AddDoc({Key? key}) : super(key: key);

  @override
  State<AddDoc> createState() => _AddDocState();
}

class _AddDocState extends State<AddDoc> {
  final _formkey = GlobalKey<FormState>();
  final date = TextEditingController();
  final type = TextEditingController();
  final dName = TextEditingController();
  final discribe = TextEditingController();
  final title = TextEditingController();

  final docDate = TextEditingController();

  bool isChecked = false;
  bool isDocument = false;
  File? file;

  var docTypeList = ['Document', 'Issue', 'Medicine Updates', 'Baby Health'];
  var documentTypeList = ['Prescription', 'Report', 'Ultrasonography'];
  var docTypeValue = 'Issue';
  var documentType = 'Prescription';

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (isDocument) {
      final filePath = file!.path;
      final finalFile = File(filePath);

      // final metadata = SettableMetadata(contentType: "image/jpeg");

      final storageRef = FirebaseStorage.instance.ref();

      final uploadTask = await storageRef
          .child("images/${basename(file!.path)}")
          .putFile(finalFile);
      final meta = await uploadTask.ref.getMetadata();

      var dowurl = await uploadTask.ref.getDownloadURL();
      final user = FirebaseAuth.instance.currentUser!;
      final user1 =
          FirebaseFirestore.instance.collection('user/${user.uid}/documents');

      final data = {
        'title': title.text,
        'date': docDate.text,
        'doc_type': documentType,
        'doctor_clinic': dName.text,
        'description': discribe.text,
        'visibility': isChecked,
        'doc_url': dowurl,
        'doc_format': meta.contentType,
        'type': docTypeValue,
        "hasDoc": true,
      };

      final docID = await user1.add(data);

      FirebaseFirestore.instance
          .collection('user/${user.uid}/documents')
          .doc(docID.id)
          .set({'doc_id': docID.id}, SetOptions(merge: true));
    } else {
      final user = FirebaseAuth.instance.currentUser!;
      final user1 =
          FirebaseFirestore.instance.collection('user/${user.uid}/documents');

      final data = {
        'title': title.text,
        'date': docDate.text,
        'type': docTypeValue,
        'doctor_clinic': dName.text,
        'description': discribe.text,
        'visibility': isChecked,
        "hasDoc": false,
      };
      final docID = await user1.add(data);
      FirebaseFirestore.instance
          .collection('user/${user.uid}/documents')
          .doc(docID.id)
          .set({'doc_id': docID.id}, SetOptions(merge: true));
    }
  }

  final snbar = const SnackBar(
    content: Text('Data added successfully'),
  );

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : "No file Selected";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 55,
              ),
              Heading(title: "Add Doc"),
              Image.asset(
                'assets/images/docPic.png',
                height: 260,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: title,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: docDate,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              labelText: "Enter Date"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                docDate.text = formattedDate.toString();
                              });
                            } else {}
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InputDecorator(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                hint: Text(docTypeValue),
                                items: docTypeList.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    docTypeValue = newValue!;
                                    if (newValue == 'Document') {
                                      isDocument = true;
                                    } else {
                                      isDocument = false;
                                    }
                                  });
                                }),
                          ),
                        ),
                        if (docTypeValue == 'Document') ...[
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: selectFile,
                              icon: const FaIcon(FontAwesomeIcons.file),
                              label: const Text('Open File'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 47, 46, 65),
                                  fixedSize: const Size(double.infinity, 46)),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(fileName),
                          const SizedBox(
                            height: 15,
                          ),
                          InputDecorator(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: Text(documentType),
                                  items: documentTypeList.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      documentType = newValue!;
                                      isDocument = true;
                                    });
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: dName,
                          decoration: const InputDecoration(
                            labelText: 'Doctor Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: discribe,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Discription',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Visiblity',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              uploadFile();
                              // ignore: deprecated_member_use
                              ScaffoldMessenger.of(context).showSnackBar(snbar);
                            },
                            icon: const FaIcon(FontAwesomeIcons.bagShopping),
                            label: const Text('Save'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 47, 46, 65),
                                fixedSize: const Size(double.infinity, 46)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
