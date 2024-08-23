import 'package:blogcom/models/usermodel.dart';
import 'package:blogcom/service/auth_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _authService = AuthService();
  late User user;
  bool isLoaded = false;

  Future<void> getinfos() async {
    User? tempuser = await _authService.getProfileInfos();
    if (tempuser != null) {
      print("user null değil");
      setState(() {
        user = tempuser;
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getinfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: const Text(
          "Profile",
          style: TextStyle(letterSpacing: 1, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoaded
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.image!),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.firstName!} ${user.lastName!}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Age: ${user.age!}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              'Gender: ${user.gender}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              'Blood Group: ${user.bloodGroup!}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // İletişim Bilgileri
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(user.email!),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(user.phone!),
                  ),
                  // Adres Bilgileri
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Address'),
                    subtitle: Text(
                      '${user.address!.address}, ${user.address!.city}, ${user.address!.state}, ${user.address!.country}',
                    ),
                  ),
                  // Eğitim Bilgileri
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('University'),
                    subtitle: Text(user.university!),
                  ),
                  // Şirket Bilgileri
                  ListTile(
                    leading: const Icon(Icons.work),
                    title: const Text('Company'),
                    subtitle: Text(
                      '${user.company!.title} at ${user.company!.name}',
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
