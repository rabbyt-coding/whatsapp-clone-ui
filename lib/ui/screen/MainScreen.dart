import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/model.dart';
import 'package:whatsapp_clone/service/service.dart';
import 'package:whatsapp_clone/ui/screen/ChatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = getChatusers();
    final loggedUser = getLoggeduser();

    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [
            SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  floating: true,
                  pinned: true,
                  backgroundColor: const Color(0xFF075E54),
                  title: Row(children: const [
                    Text('Whatsapp clone'),
                    Spacer(),
                    Icon(Icons.search),
                    Icon(Icons.more_vert),
                  ]),
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(45),
                      child: Row(children: [
                        _buildTabButton(
                            0, const Icon(Icons.groups, size: 15), 1),
                        _buildTabButton(1, _buildTextTab('Chats'), 3),
                        _buildTabButton(2, _buildTextTab('Status'), 3),
                        _buildTabButton(3, _buildTextTab('Calls'), 3),
                      ])),
                ))
          ];
        },
        body: Padding(
                padding: EdgeInsets.only(top: 45),
                child: TabBarView(
          controller: _tabController,
          children: [
            const Text('content photo'),
            _buildChatList(users),
            _buildStatusList(loggedUser),
            _buildCallList(users),
          ],
        ),
              ),
      ),
    );
  }

  _buildTextTab(String text) {
    return Text(text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
  }

  _buildTabButton(int index, Widget child, int flex) {
    return Expanded(
        flex: flex,
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                _tabController.animateTo(index);
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0)),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              child,
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 4,
                  width: 150,
                  color: _tabController.index == index
                      ? Colors.white
                      : Colors.transparent)
            ])));
  }

  _buildChatList(List<User> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final messages = getMessagesByUserId(users[index].id);
          final lastMessage = messages.messages[0];

          return ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chat',
                arguments: ChatScreenType(user: users[index])
              );

            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0)),
            child: Avatar(
                user: users[index],
                textWidget: Text(lastMessage.text,
                    style: const TextStyle(color: Colors.black)),
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(lastMessage.time,
                        style: TextStyle(
                          color: messages.newMessages == 0
                              ? Colors.grey
                              : const Color(0xFF075E54),
                        )),
                    const SizedBox(height: 10),
                    if (messages.newMessages > 0)
                      Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: Center(
                              child: Text(messages.newMessages.toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))))
                  ])
                ]),
          );
        });
  }

  _buildFloatingActionButton() {
    switch (_tabController.index) {
      case 1:
        return FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xFF075E54),
            child: const Icon(Icons.message));

      case 2:
        return FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xFF075E54),
            child: const Icon(Icons.camera_alt));
      case 3:
        return FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xFF075E54),
            child: const Icon(Icons.phone));
    }
  }

  _buildCallList(List<User> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final messages = getMessagesByUserId(users[index].id);
          final lastMessage = messages.messages[0];

          return ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.all(0)),
            child: Avatar(
                user: users[index],
                textWidget: Row(children: [
                  const Icon(Icons.call_received, color: Colors.red, size: 15),
                  const SizedBox(width: 10),
                  Text(lastMessage.text,
                      style: const TextStyle(color: Colors.black)),
                ]),
                children: const [
                  Icon(Icons.call, color: Color(0xFF075E54)),
                  SizedBox(width: 10)
                ]),
          );
        });
  }

  _buildStatusList(User user) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            margin: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Stack(children: [
              user.imageUrl == ''
                  ? const Icon(Icons.person, size: 50, color: Colors.white)
                  : CircleAvatar(
                      radius: 50, backgroundImage: NetworkImage(user.imageUrl)),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child:
                          const Icon(Icons.add, color: Colors.white, size: 15)))
            ])),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('My status',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          SizedBox(height: 10),
          Text(
            'Tap to add status update',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
          )
        ]),
      ]),
    ]);
  }
}

class Avatar extends StatelessWidget {
  final User user;
  final Widget textWidget;
  final List<Widget> children;

  const Avatar({
    Key? key,
    required this.user,
    required this.textWidget,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.all(10),
        width: 50,
        height: 50,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        child: user.imageUrl == ''
            ? const Icon(Icons.person, size: 50, color: Colors.white)
            : CircleAvatar(
                radius: 50, backgroundImage: NetworkImage(user.imageUrl)),
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(user.name,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        const SizedBox(height: 10),
        textWidget
      ]),
      const Spacer(),
      ...children
    ]);
  }
}
// THANKS for watching
