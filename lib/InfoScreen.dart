import 'package:flutter/material.dart';
import 'db_helper.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  InfoScreenState createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  DBHelper dbHelper = DBHelper();
  late Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = dbHelper.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Screen'),
      ),
      body: FutureBuilder<List<User>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<User> userList = snapshot.data ?? [];
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                User user = userList[index];
                return ListTile(
                  title: Text('Username: ${user.username}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${user.phone}'),
                      Text('Email: ${user.email}'),
                      Text('Address: ${user.address}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
