import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Image.asset('assets/images/logo.png', width: 60, height: 60),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/ondua.png',
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HaloMama will gently check in with you",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: MyFont.fontName,
                    ),
                  ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              Text(
                "Because you deserve to be asked, ‘How are you today?’ everyday.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black,
                  fontFamily: MyFont.fontName,
                  height: 1.4,
                ),
              ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.06),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildDot(false),
                      _buildDot(true),
                      _buildDot(false),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/onboarding3');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: MyColors.normal,
                      side: BorderSide(color: MyColors.normal, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045, // ukuran normal
                        fontWeight: FontWeight.bold,
                        fontFamily: MyFont.fontName,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.045),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? MyColors.normal : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
