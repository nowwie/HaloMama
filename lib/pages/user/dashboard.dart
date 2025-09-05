import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';

class HomeContent extends StatelessWidget {
    final VoidCallback onChatNow;
  const HomeContent({super.key, required this.onChatNow});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // =========================
            // HEADER PINK
            // =========================
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.pinkAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Good Morning,", style: TextStyle(fontSize: 18, color: Colors.white)),
                          SizedBox(height: 4),
                          Text("Mama Emma 🌞",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 45),
                        child: Image.asset(
                          "assets/images/greeting.png",
                          width: 180,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: -40,
                  child: _buildEmojiCard(),
                ),
              ],
            ),

            // =========================
            // KONTEN BAWAH
            // =========================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 100),
              child: Column(
                children: [
                  _buildAICompanion(onChatNow),

                  const SizedBox(height: 20),

                  // =========================
                  // QUICK SELF-CARE
                  // =========================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quick Self-Care Activity",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text("See All", style: TextStyle(color: MyColors.darkPink, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSelfCareCard(
                          "Deep Breathing (2 min)",
                          "Take a breath and relax",
                          Icons.self_improvement,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSelfCareCard(
                          "Mind Body Scan (5 min)",
                          "Clear your mind gently",
                          Icons.spa,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // DAILY MOOD
                  // =========================
                  const Text(
                    "Your Daily Mood",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        "Mood Chart Placeholder 📊",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // TIPS FOR YOU
                  // =========================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tips For You",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {},
                        child: Text("See All", style: TextStyle(color: MyColors.darkPink, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildTipItem("Self-Care Recharge: Quick 5-min Tips", "assets/images/tip1.png"),
                  const SizedBox(height: 10),
                  _buildTipItem("Simple Ways to Bond with Your Baby", "assets/images/tip2.png"),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// EMOJI CARD
// =========================
Widget _buildEmojiCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("How are you today?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ["😡", "😭", "😖", "🙂", "😁"].map((e) {
            return GestureDetector(
              onTap: () => print("Selected mood: $e"),
              child: Text(e, style: const TextStyle(fontSize: 36)),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// =========================
// AI COMPANION
// =========================
Widget _buildAICompanion(VoidCallback onChatNow) {
  return Container(
    height: 160,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.pink[50], borderRadius: BorderRadius.circular(16)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/robot_hai.png", height: 160, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Text("Mama's AI Companion",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text("Hi Mama, I’m here if you want to talk 💕",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                    maxLines: 2),
              ),
              ElevatedButton(
                onPressed: onChatNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.normal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Chat Now"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =========================
// QUICK SELF-CARE CARD WIDGET
// =========================
Widget _buildSelfCareCard(String title, String subtitle, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: MyColors.normal.withOpacity(0.5),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: MyColors.normal),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    ),
  );
}

// =========================
// TIP ITEM WIDGET
// =========================
Widget _buildTipItem(String title, String imagePath) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 3))],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
          child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 12),
      ],
    ),
  );
}
