import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halomama/components/constan.dart';
import 'package:halomama/pages/user/myprofile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      backgroundColor: MyColors.light,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: h * 0.25,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE91E63), Color(0xFFF48FB1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: h * 0.02),
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.055,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            
              Transform.translate(
                offset: Offset(0, -h * 0.08), 
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.03, horizontal: w * 0.05),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🔹 Avatar
                        CircleAvatar(
                          radius: w * 0.12,
                          backgroundColor: MyColors.lightActive,
                          child: Icon(Icons.person, size: w * 0.15, color: Colors.white),
                        ),
                        SizedBox(height: h * 0.015),

                        
                        Text(
                          user?.displayName ?? "No Name",
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.005),
                        Text(user?.phoneNumber ?? "-", style: TextStyle(fontSize: w * 0.035, color: Colors.grey[600])),
                        Text(user?.email ?? "-", style: TextStyle(fontSize: w * 0.035, color: Colors.grey[600])),
                        SizedBox(height: h * 0.02),
                        const Divider(),
                        SizedBox(height: h * 0.01),

                     
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.account_circle, color: Colors.black54, size: w * 0.065),
                          title: Text("My Account", style: TextStyle(fontSize: w * 0.04)),
                          trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04, color: Colors.grey),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyAccountScreen()),
                            );
                          },
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.lock, color: Colors.black54, size: w * 0.065),
                          title: Text("Change Password", style: TextStyle(fontSize: w * 0.04)),
                          trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04, color: Colors.grey),
                          onTap: () {},
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.bookmark, color: Colors.black54, size: w * 0.065),
                          title: Text("Bookmark", style: TextStyle(fontSize: w * 0.04)),
                          trailing: Icon(Icons.arrow_forward_ios, size: w * 0.04, color: Colors.grey),
                          onTap: () {},
                        ),
                        SizedBox(height: h * 0.02),

                       
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => DeleteAccountDialog(),
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red, size: w * 0.06),
                          label: Text("Delete Account", style: TextStyle(fontSize: w * 0.04)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            elevation: 0,
                            minimumSize: Size(double.infinity, h * 0.06),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.015),

                       
                        OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => LogoutDialog(),
                            );
                          },
                          child: Text("Logout", style: TextStyle(fontSize: w * 0.04)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: MyColors.normal,
                            side: BorderSide(color: MyColors.normal),
                            minimumSize: Size(double.infinity, h * 0.06),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: h * 0.015),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.05), 
            ],
          ),
        ),
      ),
    );
  }
}




class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.all(15),
      title: Column(
        children: [
          CircleAvatar(
            backgroundColor: MyColors.light,
            radius: 40,
            child: Icon(Icons.logout, color: MyColors.normal, size: 45),
          ),
          const SizedBox(height: 15),
          const Text(
            'Logout from HaloMama?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5),
          const Text('Are you sure you want to exit?', textAlign: TextAlign.center),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: MyColors.normal)),
        ),
        ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut(); 
            Navigator.pop(context); 
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text('Logout'),
          style: ElevatedButton.styleFrom(backgroundColor: MyColors.normal),
        ),
      ],
    );
  }
}

class DeleteAccountDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: const EdgeInsets.all(15),
      title: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red[100],
            radius: 40,
            child: const Icon(Icons.delete, color: Colors.red, size: 45),
          ),
          const SizedBox(height: 15),
          const Text(
            'Delete Account?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5),
          const Text('Are you sure you want to delete account?', textAlign: TextAlign.center),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              await user.delete(); // ✅ hapus akun dari Firebase
            }
            Navigator.pop(context);
          },
          child: const Text('Delete'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }
}
