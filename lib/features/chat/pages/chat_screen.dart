import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/services/user.dart';
import 'package:commet_chat/features/chat/bloc/chat_bloc.dart';
import 'package:commet_chat/features/chat/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String formatToHHMM(String isoString) {
  final dateTime = DateTime.parse(isoString).toLocal();
  final hours = dateTime.hour.toString().padLeft(2, '0');
  final minutes = dateTime.minute.toString().padLeft(2, '0');
  return "$hours:$minutes";
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatBloc bloc;

  TextEditingController messageField = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = context.read<ChatBloc>();
    bloc.add(GetMessagesEvent(conversationId: widget.conversationId));
    bloc.add(GetUserDetailsEvent(conversationId: widget.conversationId));
    bloc.add(StartListenToNewMessages(conversationId: widget.conversationId));
  }

  @override
  void dispose() {
    super.dispose();
    bloc.add(StopListenToNewMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              child: Icon(Icons.person, size: 24.sp),
            ),
            8.widthBox,
            BlocBuilder<ChatBloc, ChatState>(
              buildWhen: (previous, current) =>
                  current is GetUserDetailsEventStates,
              builder: (context, state) {
                if (state is GetUserDetailsEventLoadingState) {
                  return CircularProgressIndicator();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bloc.user?.name ?? "Unnamed User",
                      style: TextStyle(
                        fontFamily: Fonts.semiBold,
                        fontSize: 24.sp,
                      ),
                    ),
                    4.heightBox,
                    Text(
                      bloc.user?.status ?? "offline",
                      style: TextStyle(
                        fontFamily: Fonts.regular,
                        fontSize: 14.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is GetMessagesEventLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: bloc.messages.length,
                  reverse: true,
                  padding: EdgeInsets.all(16.h),
                  itemBuilder: (context, index) =>
                      MessageTile(message: bloc.messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.r)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageField,
                    decoration: InputDecoration(
                      hintText: "Enter your message",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                8.widthBox,

                InkWell(
                  onTap: () {
                    bloc.add(SendMessageEvent(message: messageField.text));
                    messageField.clear();
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: BlocBuilder<ChatBloc, ChatState>(
                      buildWhen: (previous, current) =>
                          current is SendMessageEventStates,
                      builder: (context, state) {
                        return state is SendMessageEventLoadingState
                            ? CircularProgressIndicator()
                            : Icon(Icons.send, color: Colors.white);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == User().userId
          ? Alignment.centerRight
          : Alignment.centerLeft,

      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Container(
          padding: EdgeInsets.all(12.h),
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.text ?? "NA",
                style: TextStyle(color: Colors.white, fontFamily: Fonts.medium),
              ),
              4.heightBox,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatToHHMM(message.createdAt!),
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                  10.widthBox,
                  Icon(
                    Icons.check,
                    size: 16,
                    color: message.status == "seen"
                        ? Colors.blue
                        : Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
