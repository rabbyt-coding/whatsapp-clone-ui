import 'package:whatsapp_clone/mock/data.dart';
import 'package:whatsapp_clone/model/model.dart';

User getLoggeduser() {
  return loggedUser;
}

List<User> getChatusers() {
  return chatUsers;
}

MessageList getMessagesByUserId(int userId) {
  return messageList.where((messages) => messages.userId == userId).toList()[0];
}
