import 'package:flutter/material.dart';
import 'package:lino_parents/src/Model/Response/chat_hostory_res.dart';
import 'package:state_extended/state_extended.dart';
import 'package:intl/intl.dart';

class DetailedChatScreen extends StatefulWidget {
  final Session session;
  const DetailedChatScreen({super.key, required this.session});

  @override
  StateX<DetailedChatScreen> createState() => _DetailedChatScreenState();
}

class _DetailedChatScreenState extends StateX<DetailedChatScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    const primaryPurple = Color(0xff7C3AED);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: primaryPurple),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              "CHATS",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.065,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFFFFFF), Color(0xffF3E8FF)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.015),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildSummaryCard(size),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: widget.session.chats.length,
                itemBuilder: (context, index) {
                  final chat = widget.session.chats[index];

                  return _buildMessageBubble(
                    message: chat.message ?? "",
                    isSender: chat.role == "user",
                    time: chat.time != null
                        ? DateFormat('hh:mm a').format(chat.time!.toLocal())
                        : "",
                    size: size,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(Size size) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1E293B).withValues(alpha: .05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xff7C3AED).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: Colors.blue[400],
                size: size.width * 0.05,
              ),
              const SizedBox(width: 8),
              Text(
                "CHAT SUMMARY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7C3AED),
                  fontSize: size.width * 0.04,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.session.summary ?? "No summary available.",
            style: TextStyle(
              color: Colors.black87,
              fontSize: size.width * 0.043,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required String message,
    required bool isSender,
    required String time,
    required Size size,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: isSender ? 35 : 0,
        right: isSender ? 0 : 35,
      ),
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSender
                        ? const Color(0xff7C3AED)
                        : const Color.fromARGB(255, 236, 231, 245),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: Radius.circular(isSender ? 20 : 0),
                      bottomRight: Radius.circular(isSender ? 0 : 20),
                    ),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isSender ? Colors.white : Colors.black87,
                      fontSize: size.width * 0.043,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 15, right: 15),
            child: Text(
              time,
              style: TextStyle(color: Colors.grey, fontSize: size.width * 0.03),
            ),
          ),
        ],
      ),
    );
  }
}
