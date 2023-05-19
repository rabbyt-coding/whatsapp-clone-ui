import 'package:whatsapp_clone/model/model.dart';

final User loggedUser = User(
  id: 101,
  name: 'John Doe',
  imageUrl: 'https://picsum.photos/200/300',
);

final List<User> chatUsers = [
  User( 

  id: 1,
  name: 'John Doe1',
  imageUrl: 'https://picsum.photos/200/300',
  ),

  User( 
  id: 2,
  name: 'John Doe2',
  imageUrl: 'https://picsum.photos/200/300',
  ),
  User( 

  id: 3,
  name: 'John Doe3',
  imageUrl: 'https://picsum.photos/200/300',
  ),
  User( 

  id: 4,
  name: 'John Doe4',
  imageUrl: 'https://picsum.photos/200/300',
  ),
  User( 

  id: 5,
  name: 'John Doe5',
  imageUrl: 'https://picsum.photos/200/300',
  ),
];

final List<MessageList> messageList = [
  MessageList(
      messages: [
        Message(text: 'text1', time: '12:00', isSender: true),
        Message(text: 'text2', time: '12:00', isSender: false),
        Message(text: 'text3', time: '12:00', isSender: true),
      ],
      userId: 1, newMessages:  0,
    ),

  MessageList(
      messages: [
        Message(text: 'text1', time: '12:00', isSender: true),
        Message(text: 'text2', time: '12:00', isSender: false),
        Message(text: 'text3', time: '12:00', isSender: true),
      ],
      userId: 2, newMessages:  3,
    ),
  MessageList(
      messages: [
        Message(text: 'text1', time: '12:00', isSender: true),
        Message(text: 'text2', time: '12:00', isSender: false),
        Message(text: 'text3', time: '12:00', isSender: true),
      ],
      userId: 3, newMessages:  2,
    ),
  MessageList(
      messages: [
        Message(text: 'text1', time: '12:00', isSender: true),
        Message(text: 'text2', time: '12:00', isSender: false),
        Message(text: 'text3', time: '12:00', isSender: true),
      ],
      userId: 4, newMessages:  1,
    ),
  MessageList(
      messages: [
        Message(text: 'text1', time: '12:00', isSender: true),
        Message(text: 'text2', time: '12:00', isSender: false),
        Message(text: 'text3', time: '12:00', isSender: true),
      ],
      userId: 5, newMessages:  0,
    ),
];
