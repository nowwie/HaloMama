import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Quick Self-Care Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),

           
            ActivityCard(
              title: "Deep Breathing",
              description:
                  "Take a slow breath in and out. Just three minutes to calm your mind and body.",
              imagePath: "assets/images/act1.png",
              progress: 1.0,
              progressText: "Completed 100%",
              color: MyColors.normal,
              textColor: Colors.white,
              progressColor: Colors.white,
              backgroundProgress: MyColors.light,
            ),
            SizedBox(height: size.height * 0.015),

            
            ActivityCard(
              title: "Mini Body Scan",
              description:
                  "Close your eyes and gently notice each part of your body from head to toe.",
              imagePath: "assets/images/act2.png",
              progress: 0.2,
              progressText: "Completed 20%",
              color: Colors.lightBlue.shade200,
              textColor: Colors.black87,
              progressColor: Colors.blue,
              backgroundProgress: Colors.lightBlue.shade100,
            ),
            SizedBox(height: size.height * 0.015),

            
            ActivityCard(
              title: "1-Minute Gratitude",
              description: "Write down one small thing you're grateful for today.",
              imagePath: "assets/images/act3.png",
              progress: 0.0,
              progressText: "Completed 0%",
              color: Colors.orange.shade200,
              textColor: Colors.black87,
              progressColor: Colors.orange,
              backgroundProgress: Colors.orange.shade100,
            ),
            SizedBox(height: size.height * 0.015),

      
            ActivityCard(
              title: "Mini Sound Therapy",
              description:
                  "Put on calming sounds—rain, ocean waves, or soft music—for a quick reset.",
              imagePath: "assets/images/act4.png",
              progress: 0.0,
              progressText: "Completed 0%",
              color: Colors.deepPurple.shade400,
              textColor: Colors.white,
              progressColor: Colors.white,
              backgroundProgress: Colors.deepPurple.shade200,
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double progress;
  final String progressText;
  final Color color;
  final Color textColor;
  final Color progressColor;
  final Color backgroundProgress;

  const ActivityCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.progress,
    required this.progressText,
    required this.color,
    required this.textColor,
    required this.progressColor,
    required this.backgroundProgress,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: size.width * 0.15,
            height: size.width * 0.15,
            fit: BoxFit.cover,
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  description,
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: size.width * 0.032,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  progressText,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: size.width * 0.03,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: backgroundProgress,
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    minHeight: 6,
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
