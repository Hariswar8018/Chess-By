
import 'package:chessby/l10n/app_localization.dart';
import 'package:chessby/main%20page/Notifications/mynavigation.dart';
import 'package:chessby/main%20page/Teacher.dart';
import 'package:chessby/main%20page/chat.dart';
import 'package:chessby/main%20page/home.dart';
import 'package:chessby/main%20page/profile.dart';
import 'package:chessby/main%20page/shop/navigation.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/more_settings/support.dart';
import 'package:chessby/providers/declare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../first_l.dart';

class Global {
  static Widget buildDrawer(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context,listen:false).getUser;
    return Drawer(
      backgroundColor: Global.blac,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>Profile(on:true)),
              );
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child:Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: Row(
                    children: [
                      SizedBox(width: 5,),
                      CircleAvatar(
                        backgroundImage: NetworkImage(_user!.Pic_link),
                        radius: 45,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_user.Name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                          Text(_user.Email,style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w300))
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size:25,),
                      SizedBox(width: 15,),
                    ],
                  ),
                )
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>HomePage()),
                );
              },
              child: a(context,true,Icon(Icons.view_carousel, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("DiscoverPlayers"),"https://sites.google.com/view/new-camera/home")),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Notifications()),
                );
              },
              child: a(context,true,Icon(Icons.notifications_active_rounded, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("MyNotification"),"https://sites.google.com/view/usedcamera0/home")),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Clubs(y: 0,)),
                );
              },
              child: a(context,true,Icon(Icons.place_rounded, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("ChessPlaces"),"https://sites.google.com/view/sellcamera1/home")),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Clubs(y: 1,)),
                );
              },
              child: a(context,true,Icon(Icons.school, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("ChessTeachers"),"https://sites.google.com/view/cameradekhonews/home")),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Chat()),
                );
              },
              child: a(context,true,Icon(Icons.voice_chat_sharp, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("MyChats"),"https://sites.google.com/view/cameraservices00/home")),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ShopM()),
                );
              },
              child: a(context,true,Icon(Icons.shop_2, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("ShopsAndCourses"),"https://sites.google.com/view/cameraservices00/home")),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>First1()),
                );
              },
              child: a(context,true,Icon(Icons.translate, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("Language"),"https://sites.google.com/view/cameraservices00/home")),

          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("About"),style: TextStyle(color: Colors.white),),
            tileColor: Colors.black,
          ),
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Support()),
                );

              },
              child: a(context,false,Icon(Icons.support_agent, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("ContactUs"),"https://sites.google.com/view/contactusanyenqury/home")),
          cr(context,false,Icon(Icons.newspaper, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("OurWebsite"),"https://chessby.com/"),
          cr(context,false,Icon(Icons.light_mode, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("OurMission"),"https://chessby.com/#about-us"),
          cr(context,false,Icon(Icons.admin_panel_settings_sharp, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("PrivacyPolicy"),"https://chessby.com/#chess-starter"),
          cr(context,false,Icon(Icons.pan_tool_rounded, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("TermsAndCondition"),"https://chessby.com/#chess-starter"),
          ListTile(
            title: Text(AppLocalizations.of(context)!.translate("Others"),style: TextStyle(color: Colors.white),),
            tileColor:Colors.black,
          ),
          InkWell(
              onTap: ()async{
                Share.share('*Join ChessBy* Today and Find unlimited Chess Players around you, challenge with App, and much much more 🤗 \n♙ ♟ \n \n https://play.google.com/store/apps/details?id=com.starwish.chessby');
              },
              child: a(context,false,Icon(Icons.share, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("ShareApp"),"h")),
          InkWell(
              onTap: ()async{
                final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=com.starwish.chessby&hl=en_IN');
                if (!await launchUrl(_url)) {
                }
                throw Exception('Could not launch $_url');
              },
              child: a(context,false,Icon(Icons.update, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("UpdateApp"),"https://sites.google.com/view/contact-us-x/home")),
          InkWell(
        
                onTap: ()async{
                  final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=com.starwish.chessby&hl=en_IN');
                  if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
                }
              
              },
              child: a(context,false,Icon(Icons.star, color: Colors.white, size: 30),AppLocalizations.of(context)!.translate("RateUs"),"h")),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
  static Widget a(BuildContext context, bool b,Widget r,String str,String link){
    return ListTile(
      leading: r,
      title: Text(str,style: TextStyle(color: Colors.white),),
      splashColor: Colors.orange.shade300,
      trailing:!b?Icon(
        Icons.open_in_new,
        color: Colors.black,
        size: 12,
      ): Icon(
        Icons.arrow_forward_ios_sharp,
        color: Colors.black,
        size: 12,
      ),
      tileColor: Colors.black,
    );
  }
  static Widget cr(BuildContext context, bool b,Widget r,String str,String link){
    return ListTile(
      leading: r,
        onTap: ()async{
          final Uri _url = Uri.parse(link);
          if (!await launchUrl(_url)) {
            throw Exception('Could not launch $_url');
          }},
          title: Text(str,style: TextStyle(color: Colors.white),),
      splashColor: Colors.orange.shade300,
      trailing:!b?Icon(
        Icons.open_in_new,
        color: Colors.black,
        size: 12,
      ): Icon(
        Icons.arrow_forward_ios_sharp,
        color: Colors.black,
        size: 12,
      ),
      tileColor: Colors.black,
    );
  }

  static Widget c(BuildContext context, bool b,Widget r,String str,String link){
    return ListTile(
      leading: r,
      title: Text(str),
      onTap: () async {

      },
      splashColor: Colors.orange.shade300,
      tileColor: Colors.grey.shade50,
    );
  }

  static Widget yellow(double w,String str){
    return Container(
      height: 55,
      width: w-30,
      decoration: BoxDecoration(
        color: Color(0xffffda44),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 15,),
          Text(str,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),),
          Spacer(),
          Icon(Icons.arrow_forward_outlined,color: Colors.black,),
          SizedBox(width: 15,),
        ],
      ),
    );
  }
  static Widget yellowwithout(double w,String str){
    return Container(
      height: 55,
      width: w-30,
      decoration: BoxDecoration(
        color: Color(0xffffda44),
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Center(child: Text(str,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),)),
    );
  }
  static Widget yellowcustom(double w,double h,Widget r,Color ft,String str){
    return Container(
      height: h,
      width: w-30,
      decoration: BoxDecoration(
        color: ft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 15,),
          Text(str,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17),),
          Spacer(),
          r,
          SizedBox(width: 15,),
        ],
      ),
    );
  }
  static Widget yellowcustomcentetr(double w,double h,Color ft,Color ftt, String str){
    return Container(
      height: h,
      width: w-30,
      decoration: BoxDecoration(
        color: ft,
        borderRadius: BorderRadius.circular(8),
      ),
      child:
          Center(
            child: Text(str,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: ftt),
                  ),
          ),
    );
  }
  static Widget white(double w,String str,Widget w1){
    return Container(
      height: 55,
      width: w - 30,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade300.withOpacity(0.8), // Adjust opacity here
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          w1,
          SizedBox(width: 9),
          Text(
            str,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
  static Color blac=Color(0xff202020);
  static Color yell=Colors.yellowAccent;
  static Widget height(double h)=>SizedBox(height: h,);
  static Widget width(double w)=>SizedBox(width: w,);

  static Widget emptypic(BuildContext context,String gt){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
              "assets/crying-chess-queen-cartoon-shape-crying-chess-queen-cartoon-shape-vector-illustration-151857712-removebg-preview.png",
              height: 130),
          SizedBox(height: 10),
          Text("Sorry, No $gt in Your City",textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.white)),
          Text(
            "Why don't you Share your App to your Friends ?",textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300,color: Colors.white),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: (){
              Share.share('*Join ChessBy* Today and Find unlimited Chess Players around you, challenge with App, and much much more 🤗 \n♙ ♟ \n \n https://play.google.com/store/apps/details?id=com.starwish.chessby');
            },
            child: Container(
              height:45,width:130,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(7),
                color:Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4), // Shadow color with transparency
                    spreadRadius: 5, // The extent to which the shadow spreads
                    blurRadius: 7, // The blur radius of the shadow
                    offset: Offset(0, 3), // The position of the shadow
                  ),
                ],
              ),
              child: Center(child: Text("Share Now",style: TextStyle(
                  color: Colors.white,
                  fontFamily: "RobotoS",fontWeight: FontWeight.w800
              ),)),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
  static Widget emptybox(BuildContext context,String gt){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
              "assets/9841554.png",
              height: 130),
          SizedBox(height: 10),
          Text("Looks like we don't have any $gt Today",textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.white)),
          Text(
            "Check back Later !",textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300,color: Colors.white),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
   /*
    Navigator.push(
        context,
        PageTransition(
            child: First2(),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 80)));
   */
 static Widget d(TextEditingController c, String label, String hint, bool number,bool on,{int ui=1}) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0,right: 14),
      child:Container(
        decoration: BoxDecoration(
          color: Color(0xff202020),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: c,
            readOnly: on,
            minLines: ui,
            maxLines: ui+1,
            keyboardType: number ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              labelText: "  " + label,
              hintText: hint,
              isDense: true,
              filled: true,
              fillColor: Color(0xff202020), // Set the editor background color to black
              labelStyle: TextStyle(color: Colors.white, fontSize: 16), // Set label color and font size
              hintStyle: TextStyle(color: Colors.white54, fontSize: 16), // Set hint color and font size
              border: InputBorder.none, // Remove the underline
              focusedBorder: InputBorder.none, // Remove the underline when focused
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please type it';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  static text1(String str,double w)=>  Text(str,style: TextStyle(fontSize: w/12,color: Colors.white,fontWeight: FontWeight.w600),);
  static text11(String str,double w)=>  Text(str,style: TextStyle(fontSize: w/14,color: Colors.white,fontWeight: FontWeight.w600),);
  static text16(String str,double w)=>  Text(str,style: TextStyle(fontSize: w/20,color: Colors.white,fontWeight: FontWeight.w600),);
  static text23(String str,double w)=>  Text(str,style: TextStyle(fontSize: w/23,color: Colors.white,fontWeight: FontWeight.w600),);

  static text12(String str,double w)=>  Text(str,style: TextStyle(fontSize: w/18,color: Colors.white,fontWeight: FontWeight.w600),);

  static text2(String str, double w)=>Text(str,style: TextStyle(fontSize: w/25,color: Colors.white,fontWeight: FontWeight.w400),);
/*

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
             opacity: 0.7
          ),
        ),
        child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }

  */
}