import 'package:flutter/material.dart';
import 'package:halomama/components/constan.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

Future<void> _registerUser() async {
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();
  String name = _nameController.text.trim();

  if (email.isEmpty || password.isEmpty || name.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all fields")),
    );
    return;
  }

  try {
    // Register user
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Optional: update displayName
    await userCredential.user?.updateDisplayName(name);

    // Registration successful → navigate ke login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registration Successful!")),
    );
    Navigator.pushReplacementNamed(context, '/login');

  } on FirebaseAuthException catch (e) {
    String msg = '';
    if (e.code == 'email-already-in-use') msg = 'Email already registered';
    else if (e.code == 'weak-password') msg = 'Password too weak';
    else msg = e.message ?? 'Registration failed';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Logo
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 80,
                  height: 80,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.045),

              // Title
              Text(
                "Welcome to HaloMama",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: MyFont.fontName,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                "Sign in and access various features from HaloMama!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                  fontFamily: MyFont.fontName,
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.06),

              // Name field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: MyFont.fontName,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.normal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    cursorColor: MyColors.normal,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Email field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: MyFont.fontName,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.normal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    cursorColor: MyColors.normal,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Password field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: MyFont.fontName,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons
                                  .visibility_off_outlined // Mata merem
                              : Icons.visibility_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyColors.normal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    cursorColor: MyColors.normal,
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.045),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _registerUser,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      Set<MaterialState> states,
                    ) {
                      if (states.contains(MaterialState.pressed) ||
                          states.contains(MaterialState.hovered)) {
                        return MyColors.normal;
                      }
                      return Colors.grey[400]!;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Divider with text
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or sign in with"),
                  ),
                  Expanded(child: Divider(thickness: 2)),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Google button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/google.png",
                    width: 24,
                    height: 24,
                  ),
                  label: const Text("Google"),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: MyColors.normal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.06),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text(
                      "Sign In Now",
                      style: TextStyle(
                        color: MyColors.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
