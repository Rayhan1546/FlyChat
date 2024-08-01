import 'package:flutter/cupertino.dart';
import 'package:flychat/data/response_models/message_model.dart';
import 'package:flychat/data/response_models/room_response.dart';
import 'package:flychat/data/response_models/user_model.dart';

abstract class MessageRepository {
  Future<bool> sendMessage(MessageModel message);
  Future<UserModel?> getReceiverData(String id);
  Stream<MessageModel> getMessage(String roomId);
  Future<List<MessageModel>> fetchInitialMessages(String roomId, int numOfMessages);
  Future<List<Message>?> fetchChat();
}
