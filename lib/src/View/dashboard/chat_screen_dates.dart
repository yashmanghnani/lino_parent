import 'package:flutter/material.dart';
import 'package:lino_parents/src/Controller/all_controllers.dart';
import 'package:lino_parents/src/Model/Response/chat_hostory_res.dart';
import 'package:lino_parents/src/View/dashboard/detailed_chat_screen.dart';
import 'package:lino_parents/src/View/widgets/gradient_section.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreenDates extends StatefulWidget {
  const ChatScreenDates({super.key});

  @override
  State<ChatScreenDates> createState() => _ChatScreenDatesState();
}

class _ChatScreenDatesState extends State<ChatScreenDates> {
  late AllController _con;
  List<Datum> groupedData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _con = AllController();
    loadData();
  }

  Future<void> loadData() async {
    final data = await _con.fetchUserChatLogsContro();
    setState(() {
      groupedData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Chat History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.08,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [const GradientBottomSection(), _chatHistorySection(size)],
      ),
    );
  }

  Widget _chatHistorySection(Size size) {
    return Column(
      children: [
        const SizedBox(height: 15),
        // Weekly Overview Card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xff7C3AED),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LAST 7 DAY'S CHATS",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 45),
        Expanded(
          child: isLoading
              ? _buildShimmerLoading()
              : groupedData.isEmpty
              ? const Center(child: Text("No history found"))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: groupedData.length,
                  itemBuilder: (context, index) {
                    final item = groupedData[index];
                    final formattedDate =
                        "${item.id?.day}-${item.id?.month}-${item.id?.year}";
                    return _buildHistoryCard(formattedDate, item.sessions);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(String date, List<Session> sessions) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          leading: const Icon(
            Icons.calendar_today_rounded,
            color: Color(0xFFB366FF),
          ),
          title: Text(
            date,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[900],
            ),
          ),
          trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          children: sessions.isEmpty
              ? [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("No chats this day"),
                  ),
                ]
              : sessions.map((session) => _buildTimeTile(session)).toList(),
        ),
      ),
    );
  }

  Widget _buildTimeTile(Session session) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: Text(
        "Chat at ${session.time}",
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 20,
        color: Color(0xFFB366FF),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedChatScreen(session: session),
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 7, // Kitne placeholders dikhane hain
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 12.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 12.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(width: 40.0, height: 12.0, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
