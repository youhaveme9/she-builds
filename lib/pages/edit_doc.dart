import 'package:flutter/material.dart';

class EditDoc extends StatefulWidget {
  const EditDoc({Key? key}) : super(key: key);

  // final String userID;
  // const EditDoc(this.userID, {Key? key, required userId}) : super(key: key);

  @override
  State<EditDoc> createState() => _EditDocState();
}

class _EditDocState extends State<EditDoc> {
  final _formkey = GlobalKey<FormState>();
  late var isChecked = false;
  final changeTitle = TextEditingController();
  final changeDoctorName = TextEditingController();
  final changeDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 55,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Image.asset(
                'assets/icons/icon.png',
                height: 45,
                width: 45,
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                "Edit Doc",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 47, 46, 65),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: changeTitle,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: changeDoctorName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Doctor Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: changeDescription,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      child: ElevatedButton(
                        onPressed: () {
                          // createUser();
                          // final user = FirebaseAuth.instance.currentUser!;
                          // final user1 = FirebaseFirestore.instance
                          //     .collection('user/${user.uid}/documents');
                          // user1.doc(user1.)

                          // Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 47, 46, 65),
                            fixedSize: const Size(double.infinity, 46)),
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
