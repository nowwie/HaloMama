import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halomama/pages/auth/forgot_password_reset.dart';

class ForgotPasswordVerification extends StatefulWidget {
  final String email; // email dari LoginPage

  const ForgotPasswordVerification({super.key, required this.email});

  @override
  _ForgotPasswordVerificationState createState() =>
      _ForgotPasswordVerificationState();
}

class _ForgotPasswordVerificationState
    extends State<ForgotPasswordVerification> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  bool _isCodeComplete = false;
  bool _isLoading = false;

  String get email => widget.email;

  void _checkCode() {
    setState(() {
      _isCodeComplete = _controllers.every(
        (controller) => controller.text.isNotEmpty,
      );
    });
  }

  Future<void> _onContinue() async {
    if (!_isCodeComplete) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordReset(email: email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the verification code')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent to $email')),
      );

      Navigator.pushNamed(context, '/forgot_password_reset', arguments: email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Failed to send reset email')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onResend() async {

  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter your email first.")),
    );
    return;
  }

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password reset link sent to $email")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Email Verification"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/pwverif.png', height: 120),
            const SizedBox(height: 20),
            const Text(
              "Verification Code Sent",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              "Check your email and enter the verification code you received here.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: MyColors.normal),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index != 3) {
                        FocusScope.of(context).nextFocus();
                      }
                      _checkCode();
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isCodeComplete && !_isLoading ? _onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.normal,
                minimumSize: const Size(double.infinity, 48),
                disabledBackgroundColor: Colors.grey,
              ),
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Continue"),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _onResend,
              child: const Text.rich(
                TextSpan(
                  text: "Didn't receive the email? ",
                  children: [
                    TextSpan(
                      text: "Resend",
                      style: TextStyle(color: Colors.pink),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
