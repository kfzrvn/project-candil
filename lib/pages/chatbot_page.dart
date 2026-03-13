import 'package:flutter/material.dart';
import 'package:candil/theme.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [
    {
      "text": "Halo 👋 Ada yang bisa saya bantu?",
      "isUser": false,
      "type": "text"
    }
  ];

  String getBotResponse(String message) {
    message = message.toLowerCase();

    if (message.contains("teknologi")) {
      return "Buku Teknologi yang tersedia saat ini adalah:";
    } else if (message.contains("pinjam")) {
      return "Maksimal peminjaman adalah 4 buku selama 7 hari.";
    } else {
      return "Maaf, saya belum memahami pertanyaan itu 🙏";
    }
  }

  void sendMessage() {
    String text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"text": text, "isUser": true, "type": "text"});
    });

    _controller.clear();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add(
            {"text": getBotResponse(text), "isUser": false, "type": "text"});

        if (text.toLowerCase().contains("teknologi")) {
          messages.add(
              {"title": "Programmer Giardia", "isUser": false, "type": "card"});
        }
      });
      scrollToBottom();
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        backgroundColor: blue3,
        elevation: 0,
        title: const Text(
          "Chatbot Candil",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var msg = messages[index];
                bool isUser = msg["isUser"];

                if (msg["type"] == "card") {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFE3ECFF),
                            child: Icon(Icons.smart_toy, color: Colors.blue),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Programmer Giardia",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Buku pemrograman dasar yang cocok untuk pemula.",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!isUser)
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFFE3ECFF),
                            child: Icon(Icons.smart_toy,
                                size: 18, color: Colors.blue),
                          ),
                        ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: isUser
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF4A7BFF),
                                      Color(0xFF6FA3FF)
                                    ],
                                  )
                                : null,
                            color: isUser ? null : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Text(
                            msg["text"],
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // ================= INPUT =================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black12,
                  offset: Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Tulis pesan...",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      filled: true,
                      fillColor: const Color(0xFFF1F3F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4A7BFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
