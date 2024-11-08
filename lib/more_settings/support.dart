import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Help & Support"),
      ),
      body: Container(
        child: Column(
          children:[
            ListTile(
              leading: SocialMediaButton.whatsapp(
        onTap: (){},
          size: 30, color: Colors.green
      ),
              title: Text("Whatsapp Chat"),
              onTap: () async {
                final Uri _url = Uri.parse('https://chat.whatsapp.com/KuWKQ2qR8Fh10pvCzYVBQ2');
                if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
                }
              },
              subtitle: Text("Chat with Us on Whatsapp"),
              splashColor: Colors.orange.shade200, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.green, size: 20,),
              tileColor: Colors.grey.shade50,
            ),

            ListTile(
              leading:SocialMediaButton.facebook(
                  onTap: (){},
                  size: 30, color: Colors.blue
              ),
              title: Text("Facebook Community"),
              onTap: () async {
                final Uri _url = Uri.parse('https://www.facebook.com/equalchess');
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
              subtitle: Text("Ask our Community"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blue, size: 20,),
              splashColor: Colors.orange.shade300,
              tileColor: Colors.grey.shade50,
            ),
            ListTile(
              leading: SocialMediaButton.dribbble(
                  onTap: (){},
                  size: 30, color: Colors.black
              ),
              title: Text("Join Discord"),
              onTap: () async {
                final Uri _url = Uri.parse('https://discord.gg/qkHRHv9y');
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
              subtitle: Text("Ask your Friends"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
              splashColor: Colors.orange.shade300,
              tileColor: Colors.grey.shade50,
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.redAccent, size: 40),
              title: Text("Email Us"),
                onTap: () async {
                  final Uri _url = Uri.parse('mailto:diegolainrodriguez@gmail.com?subject=Help&body=');
                  if (!await launchUrl (_url)
                ) {
                throw Exception('Could not launch $_url');
                }
              },
              subtitle: Text("Send full Detail about your Queries with Pics"),
              splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
              tileColor: Colors.grey.shade50,
            ),
            ]
        )
      )
    );
  }
}
