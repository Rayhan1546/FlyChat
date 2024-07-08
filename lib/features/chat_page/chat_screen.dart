import 'package:flutter/material.dart';
import 'package:flychat/features/chat_page/chat_screen_viewmodel.dart';
import 'package:flychat/features/chat_page/widgets/chat_bubbles.dart';
import 'package:flychat/util/values/dimens.dart';
import 'package:flychat/data/response_models/message_model.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  final String receiverId;

  ChatScreen({required this.roomId, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatScreenViewmodel viewmodel = ChatScreenViewmodel();

  @override
  void initState() {
    super.initState();
    viewmodel.fetchMessage(widget.roomId);
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(Dimens.getDimen(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _topView(context),
              SizedBox(height: Dimens.getDimen(15)),
              _userMessages(context),
              SizedBox(height: Dimens.getDimen(5)),
              _userMessageInput(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topView(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-10, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              size: Dimens.getDimen(30),
              Icons.arrow_back,
            ),
          ),
          Icon(
            Icons.account_circle,
            size: Dimens.getDimen(40),
          ),
          SizedBox(width: Dimens.getDimen(5)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rayhan Mahmud',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.getDimen(14),
                ),
              ),
              const Text('Active Now'),
            ],
          ),
          const Spacer(),
          const Icon(Icons.call),
          const SizedBox(width: 15),
          Icon(
            Icons.video_call,
            size: Dimens.getDimen(30),
          )
        ],
      ),
    );
  }

  Widget _userMessages(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<MessageModel>?>(
        valueListenable: viewmodel.messages,
        builder: (context, messages, _) {
          if (messages == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: viewmodel.scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatBubbles(
                message: messages[index].content ?? '',
                isSentByMe: messages[index].receiverId == widget.receiverId ? true : false,
              );
            },
          );
        },
      ),
    );
  }

  Widget _userMessageInput(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.attach_file_rounded, size: 25),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.getDimen(10)),
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.getDimen(10)),
          ),
          child: TextField(
            controller: viewmodel.messageController,
            decoration: const InputDecoration(
              fillColor: Colors.black12,
              border: InputBorder.none,
              hintText: "Write your message",
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => viewmodel.sendMessage(widget.roomId, widget.receiverId),
          child: const CircleAvatar(
            radius: 24,
            child: Icon(Icons.send_rounded),
          ),
        ),
      ],
    );
  }
}
