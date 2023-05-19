import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/model.dart';
import 'package:whatsapp_clone/service/service.dart';

class ChatScreenType {
  final User user;

  ChatScreenType({required this.user});
}

class ChatScreen extends StatelessWidget {
  final ChatScreenType props;

  const ChatScreen({Key? key, required this.props}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageList = getMessagesByUserId(props.user.id);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF075E54),
            elevation: 0,
            title: Row(children: [
              Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: props.user.imageUrl == ''
                      ? const Icon(Icons.person, size: 40, color: Colors.grey)
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(props.user.imageUrl))),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(props.user.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                const Text('last seen today at 12:00',
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.normal))
              ])
            ]),
            actions: const [
              IconButton(
                  icon: Icon(Icons.videocam, color: Colors.white),
                  onPressed: null),
              IconButton(
                  icon: Icon(Icons.phone, color: Colors.white),
                  onPressed: null),
              IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: null),
            ]),
        body: Container(
            color: Colors.grey[400],
            child: Column(children: [
              Expanded(child: Center(child: 
                  ListView.builder(
                    itemCount: messageList.messages.length,
                    itemBuilder: (context, index) {
                      final message = messageList.messages[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: message.isSender 
                           ? MainAxisAlignment.end
                           : MainAxisAlignment.start,
                           children: [
                             Container(
                               constraints: BoxConstraints(
                                 maxWidth:  250
                                 ),
                               margin: EdgeInsets.symmetric(horizontal: 10),
                               padding:EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 color: message.isSender
                                   ? Colors.grey[300]
                                   : Colors.grey[700],
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 crossAxisAlignment: CrossAxisAlignment.end,
                                 children: [
                                   Text(
                                     message.text,
                                     style: TextStyle(
                                       fontSize: 16,
                                       color: Colors.black
                                       )
                                     ),
                                    SizedBox(
                                      width: 5
                                      ),
                                    Text(
                                      message.time,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black
                                        )
                                      )
                                 ]
                                 )
                               )
                           ]
                          )
                        );
                    }

                    )
                  )),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              // color: const Color(0xFF075E54),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(children: const [
                              IconButton(
                                  icon: Icon(Icons.emoji_emotions_outlined,
                                      color: Colors.grey),
                                  onPressed: null),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                    ),
                                  )
                                ),
                              IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: null
                                ),
                              IconButton(
                                icon: Icon(Icons.camera_alt,
                                  color: Colors.grey
                                  ),
                                onPressed: null
                                )
                            ]))),
                            const SizedBox(width:10),
                            const FloatingActionButton(
                              onPressed: null,
                              backgroundColor: Color(0xFF075E54),
                              child: Icon(Icons.mic)
                              )
                  ]))
            ])));
  }
}
