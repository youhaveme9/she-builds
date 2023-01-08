import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/tags.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  final _formkey = GlobalKey<FormState>();
  final disease = <String>[];
  final allergies = <String>[];
  final medicines = <String>[];

  final diseaseList = TextEditingController();
  final allergyList = TextEditingController();
  final mediList = TextEditingController();
  final name = TextEditingController();
  final age = TextEditingController();
  final blood = TextEditingController();
  final complication = TextEditingController();
  final starting = TextEditingController();

  Future createUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    final user1 = FirebaseFirestore.instance.collection('user').doc(user.uid);

    final data = {
      'age': age.text,
      'allergies': allergies,
      'blood_group': blood.text,
      'complications': complication.text,
      'current_medicines': medicines,
      'diseases': disease,
      'email': user.email,
      'name': user.displayName,
      'starting_date': starting.text,
      'uid': user.uid
    };
    await user1.set(data, SetOptions(merge: true));
  }

  void addDisease(value) {
    if (value == '') {
      null;
    } else {
      disease.add(value);
    }
    diseaseList.clear();
    setState(() {});
  }

  void addAllergy(value) {
    if (value == '') {
      null;
    } else {
      allergies.add(value);
    }
    allergyList.clear();
    setState(() {});
  }

  void addMedicine(value) {
    if (value == '') {
      null;
    } else {
      medicines.add(value);
    }
    mediList.clear();
    setState(() {});
  }

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
                  "Edit Profile",
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
            //Image
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL.toString()),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        enabled: false,
                        initialValue: user.displayName,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: user.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: age,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Age",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Age can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: blood,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                labelText: "Blood Group",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Blood Group can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: starting,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: "Starting Date",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Starting date can't be Empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: complication,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: "Complications",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: diseaseList,
                        onFieldSubmitted: (val) {
                          setState(() {
                            addDisease(val);
                          });
                        },
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Diseases",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 164,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: SizedBox(
                          height: double.infinity,
                          child: Wrap(
                            children: disease.map((d) {
                              return Tags(d);
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: allergyList,
                        onFieldSubmitted: (val) {
                          setState(() {
                            addAllergy(val);
                          });
                        },
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Allergies",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 164,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: SizedBox(
                          height: double.infinity,
                          child: Wrap(
                            children: allergies.map((d) {
                              return Tags(d);
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: mediList,
                        onFieldSubmitted: (val) {
                          setState(() {
                            addMedicine(val);
                          });
                        },
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Medicines",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 164,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child: SizedBox(
                          height: double.infinity,
                          child: Wrap(
                            children: medicines.map((d) {
                              return Tags(d);
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            createUser();
                            Navigator.pop(context);
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
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
