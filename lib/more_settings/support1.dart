import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class Support1 extends StatelessWidget {
  const Support1({super.key});

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
                    title: Text("Whatsapp Chat < Teacher >"),
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
                    leading: SocialMediaButton.whatsapp(
                        onTap: (){},
                        size: 30, color: Colors.greenAccent
                    ),
                    title: Text("Whatsapp Direct Message"),
                    onTap: () async {
                      final Uri _url = Uri.parse('https://wa.me/34643177944');
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    subtitle: Text("Chat with Us directly on Whatsapp"),
                    splashColor: Colors.orange.shade200, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.greenAccent, size: 20,),
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
                    subtitle: Text("Ask from Discord Admins"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                    splashColor: Colors.orange.shade300,
                    tileColor: Colors.grey.shade50,
                  ),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.redAccent, size: 40),
                    title: Text("Email Support"),
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
