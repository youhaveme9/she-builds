import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

class Share extends StatefulWidget {
  const Share({Key? key}) : super(key: key);

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  final user = FirebaseAuth.instance.currentUser!;
  final timeList = ['1 hour', '2 hour'];
  late var time = '1 hour';
  var actualTime = 3600;
  var link = '';
  final success = const SnackBar(
    content: Text('Copied to clipboard'),
  );

  Future<http.Response> getLink() async {
    return await http.post(
      Uri.parse(
          'https://us-central1-test-project-019.cloudfunctions.net/makeExpiryCopy'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'uid': user.uid, 'ttl': actualTime}),
    );
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
                  "Share",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 47, 46, 65),
                  ),
                ),
                const SizedBox(
                  width: 160,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Set Expiry Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InputDecorator(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: Text(time),
                      items: timeList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          time = newValue!;
                          if (newValue == '1 hour') {
                            actualTime = 3600;
                          } else {
                            actualTime = 7200;
                          }
                        });
                      }),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                http.Response response = await getLink();

                Map<String, dynamic> data = jsonDecode(response.body);
                setState(() {
                  link = data['expirable_link'];
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 47, 46, 65),
              ),
              child: const Text("Get Link"),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                child: Text(link),
                onTap: () {
                  // ignore: avoid_print
                  FlutterClipboard.copy(link).then(
                    // ignore: avoid_print
                    (value) =>
                        ScaffoldMessenger.of(context).showSnackBar(success),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            link == ""
                ? const Text('')
                : QrImage(
                    data: link,
                    size: 300,
                  )
          ],
        ),
      ),
    );
  }
}
