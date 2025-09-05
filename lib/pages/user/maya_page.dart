import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';
import 'package:halomama/pages/services/chat_service.dart';

class MayaPage extends StatefulWidget {
  const MayaPage({super.key});

  @override
  State<MayaPage> createState() => _MayaPageState();
}

class _MayaPageState extends State<MayaPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _showIntro = true;
  bool _isAnimating = false;

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": text});
      _messages.add({"sender": "bot", "text": "Maya is typing..."});
      _controller.clear();
      _showIntro = false;
    });

    try {
      final reply = await ChatService.sendMessage(text);
      setState(() {
        _messages.removeLast();
        _messages.add({"sender": "bot", "text": reply});
      });
    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messages.add({"sender": "bot", "text": "⚠️ Koneksi gagal ke server"});
      });
    }
  }

  void _sendMood(String mood) {
    _sendMessage(mood);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Material(
      color: MyColors.light,
      child: Column(
        children: [
          Container(
          height: kToolbarHeight,
          color: MyColors.light,
          alignment: Alignment.center,
          child: Text(
            "Maya",
            style: TextStyle(
              color: MyColors.normal,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
          if (_showIntro)
            SizedBox(
              height: screenHeight * 0.5, // 2/4 dari layar
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Robot image
                      Flexible(
                        flex: 3,
                        child: Image.asset(
                          "assets/images/robot.png",
                          width: 160,
                          height: 160,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Greeting message
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: MyColors.normal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Hello! How are you feeling today?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Chat messages area
          Expanded(
            child: (_showIntro || _isAnimating)
                ? const SizedBox.shrink() // Kosong saat intro ditampilkan atau sedang animasi
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isBot = msg["sender"] == "bot";
                      return Align(
                        alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isBot ? MyColors.normal : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            msg["text"] ?? "",
                            style: TextStyle(
                              color: isBot ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Mood options - ditampilkan di atas text field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _moodOption("😀"),
                _moodOption("🙂"),
                _moodOption("😐"),
                _moodOption("😢"),
                _moodOption("😡"),
              ],
            ),
          ),

          // Input chat
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: MyColors.light,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (text) => _sendMessage(text),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _sendMessage(_controller.text),
                    child: CircleAvatar(
                      backgroundColor: MyColors.normal,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moodOption(String emoji) {
    return GestureDetector(
      onTap: () => _sendMood(emoji),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          emoji, 
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}