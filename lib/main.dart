import 'package:faker/faker.dart' as faker_pkg;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  List<Tab> myTabs = [
    Tab(icon: Icon(Icons.chat_outlined), text: 'Chats'),
    Tab(icon: Icon(Icons.emoji_emotions_outlined), text: 'Status'),
    Tab(icon: Icon(Icons.call), text: 'Calls'),
  ];

  var faker = faker_pkg.Faker();
  var avatarIndex = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Chat App'),
            bottom: TabBar(tabs: myTabs),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ChatItem(
                    imageUrl: "https://picsum.photos/id/$index/200/300",
                    title: faker.person.name(),
                    subtitle: faker.lorem.sentence(),
                    trailing: faker.date.time(),
                  );
                },
              ),
              GridView.count(
                padding: EdgeInsets.all(5),
                crossAxisCount: 2,
                children: List.generate(100, (index) {
                  index *= 10 + 1;
                  avatarIndex++;
                  return Card(
                    margin: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          // Lapisan 1: Gambar sebagai latar belakang
                          Image.network(
                            "https://picsum.photos/id/$index/300/300",
                            fit: BoxFit.cover,
                          ),
                          // Lapisan 2: Widget untuk konten yang ditumpangkan
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(
                                    "https://picsum.photos/id/$avatarIndex/300/300",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Tambahkan warna teks agar terlihat di atas gambar
                                Text(
                                  faker.person.firstName(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1.0, 1.0),
                                        blurRadius: 3.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return LogCallItem(
                    imageUrl: "https://picsum.photos/id/$index/200/300",
                    title: faker.person.name(),
                    subtitle: faker.date.dateTime().toString(),
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

class ChatItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String trailing;

  const ChatItem({
    required this.imageUrl,
    required this.subtitle,
    required this.title,
    required this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      title: Text(title),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(trailing),
    );
  }
}

class LogCallItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const LogCallItem({
    required this.imageUrl,
    required this.subtitle,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      title: Text(title),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Icon(Icons.call),
    );
  }
}
