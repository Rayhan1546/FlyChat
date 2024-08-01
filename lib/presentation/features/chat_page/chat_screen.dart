import 'package:flutter/material.dart';
import 'package:flychat/data/response_models/user_model.dart';
import 'package:flychat/presentation/features/chat_page/chat_screen_viewmodel.dart';
import 'package:flychat/presentation/features/chat_page/profile_view/profile_view_screen.dart';
import 'package:flychat/presentation/features/chat_page/widgets/chat_bubbles.dart';
import 'package:flychat/util/values/dimens.dart';
import 'package:flychat/data/response_models/message_model.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;
  final String receiverId;

  const ChatScreen({super.key, required this.roomId, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatScreenViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = ChatScreenViewmodel();
    viewmodel.fetchUserData(widget.receiverId);
    viewmodel.fetchInitialMessages(widget.roomId, true);
    viewmodel.scrollController.addListener(_scrollListener);
    viewmodel.messageSubscription(widget.roomId);
  }

  @override
  void dispose() {
    viewmodel.scrollController.removeListener(_scrollListener);
    viewmodel.subscription?.cancel();
    viewmodel.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (viewmodel.scrollController.position.atEdge) {
      if (viewmodel.scrollController.position.pixels == 0) {
        viewmodel.upperScroll(widget.roomId);
      }
    }
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
    return ValueListenableBuilder<UserModel?>(
      valueListenable: viewmodel.userData,
      builder: (context, user, _) => Transform.translate(
        offset: const Offset(-10, 0),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileViewScreen(user: user!),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  size: Dimens.getDimen(30),
                ),
              ),
              Container(
                width: Dimens.getDimen(35),
                height: Dimens.getDimen(35),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                      user?.profilePictureUrl ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: Dimens.getDimen(15)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user?.username ?? '',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userMessages(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<MessageModel>>(
        valueListenable: viewmodel.messages,
        builder: (context, messages, _) {
          if (messages.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            controller: viewmodel.scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatBubbles(
                message: messages[messages.length - index - 1].content ?? '',
                isSentByMe: messages[messages.length - index - 1].receiverId ==
                    widget.receiverId,
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.getDimen(10)),
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.getDimen(10)),
          ),
          child: TextField(
            controller: viewmodel.messageController,
            minLines: 1,
            maxLines: null,
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
