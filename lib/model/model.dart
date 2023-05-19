class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

class Message {
  final String text;
  final String time;
  final bool isSender;

  Message({
    required this.text,
    required this.time,
    required this.isSender,
  });
}

class MessageList {
  final List<Message> messages;
  final int newMessages;
  final int userId;

  MessageList({
    required this.messages,
    required this.newMessages,
    required this.userId,
  });
}
