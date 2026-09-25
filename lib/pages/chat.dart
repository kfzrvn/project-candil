import 'package:flutter/material.dart';
import 'package:candil/theme.dart';
import 'package:candil/services/knowledge_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Service untuk mengambil knowledge dari Firestore
  final KnowledgeService _knowledgeService = KnowledgeService();

  // Menyimpan percakapan
  List<Map<String, dynamic>> messages = [
    {
      "text": "Halo, ada yang bisa saya bantu?",
      "isUser": false,
      "type": "text",
    }
  ];

  // Menandakan chatbot sedang memproses pertanyaan
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // MENGIRIM PESAN
  // ============================================================

  Future<void> sendMessage() async {
    final String text = _controller.text.trim();

    if (text.isEmpty || _isLoading) {
      return;
    }

    // Tampilkan pesan user
    setState(() {
      messages.add({
        "text": text,
        "isUser": true,
        "type": "text",
      });

      _isLoading = true;
    });

    _controller.clear();

    scrollToBottom();

    // Beri sedikit jeda agar tampilan terasa natural
    await Future.delayed(const Duration(milliseconds: 300));

    // Ambil jawaban berdasarkan knowledge Firestore
    final String response = await getBotResponse(text);

    if (!mounted) return;

    setState(() {
      messages.add({
        "text": response,
        "isUser": false,
        "type": "text",
      });

      _isLoading = false;
    });

    scrollToBottom();
  }

  // ============================================================
  // MENCARI JAWABAN DARI FIRESTORE
  // ============================================================

  Future<String> getBotResponse(String message) async {
    try {
      // Ubah pertanyaan menjadi huruf kecil
      final String question = message.toLowerCase().trim();

      // Ambil seluruh knowledge dari Firestore
      final List<Map<String, dynamic>> knowledge =
          await _knowledgeService.getKnowledge();

      // Kalau knowledge kosong
      if (knowledge.isEmpty) {
        return "Maaf, informasi belum tersedia pada sistem.";
      }

      // ----------------------------------------------------------
      // MENCARI KNOWLEDGE YANG SESUAI
      // ----------------------------------------------------------

      for (final item in knowledge) {
        final dynamic keywordsData = item['keywords'];

        if (keywordsData == null) {
          continue;
        }

        // Pastikan keywords berupa List
        final List<dynamic> keywords = keywordsData is List ? keywordsData : [];

        for (final keywordData in keywords) {
          final String keyword = keywordData.toString().toLowerCase().trim();

          if (keyword.isEmpty) {
            continue;
          }

          // Jika pertanyaan mengandung keyword
          if (question.contains(keyword)) {
            final dynamic content = item['content'];

            if (content != null && content.toString().trim().isNotEmpty) {
              return content.toString();
            }
          }
        }
      }

      return "Maaf, informasi tersebut belum tersedia pada sistem Candil.";
    } catch (e) {
      print("Error chatbot: $e");

      return "Maaf, terjadi kendala saat mengambil informasi. Silakan coba lagi.";
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // ============================================================
  // CHAT BUBBLE
  // ============================================================

  Widget buildMessageBubble(Map<String, dynamic> msg) {
    final bool isUser = msg["isUser"] == true;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // ICON BOT
          if (!isUser)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE3ECFF),
                child: Icon(
                  Icons.smart_toy,
                  size: 18,
                  color: Colors.blue,
                ),
              ),
            ),

          // PESAN
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [
                          Color(0xFF4A7BFF),
                          Color(0xFF6FA3FF),
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
                  ),
                ],
              ),
              child: Text(
                msg["text"].toString(),
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
  }

  // ============================================================
  // TYPING INDICATOR
  // ============================================================

  Widget buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFE3ECFF),
              child: Icon(
                Icons.smart_toy,
                size: 18,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const SizedBox(
              width: 30,
              child: Text(
                "...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: blue3,
        elevation: 0,
        title: const Text(
          "Chatbot Candil",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Column(
        children: [
          // ======================================================
          // LIST CHAT
          // ======================================================

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),

              // Tambahkan 1 item untuk typing indicator
              itemCount: messages.length + (_isLoading ? 1 : 0),

              itemBuilder: (context, index) {
                // Typing indicator
                if (_isLoading && index == messages.length) {
                  return buildTypingIndicator();
                }

                final msg = messages[index];

                return buildMessageBubble(msg);
              },
            ),
          ),

          // ======================================================
          // INPUT MESSAGE
          // ======================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black12,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // TEXT FIELD
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !_isLoading,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) {
                      sendMessage();
                    },
                    decoration: InputDecoration(
                      hintText: "Tulis pesan...",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
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

                // SEND BUTTON
                GestureDetector(
                  onTap: _isLoading ? null : sendMessage,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
