import 'dart:math';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:chessby/main%20page/navigation.dart';
import 'package:chessby/models/noti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chessby/aaaaa/global.dart';
import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/cards/Club_Cards.dart';
import 'package:chessby/first/countries.dart';
import 'package:chessby/models/club_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add_Calender extends StatefulWidget {
  UserModel user;
  Add_Calender({super.key, required this.user});

  @override
  State<Add_Calender> createState() => _Add_CalenderState();
}

class _Add_CalenderState extends State<Add_Calender> {
  DateTime nq = DateTime.now();

  String h = " ";
  void initState(){
    v();
  }

  v() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      h  = prefs.getString('State') ?? "Canary Islands";
    });
  }

  List<ClubModel> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.black,  // Set the background color here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "   Nearby Places",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                "     Kindly select Place and Double Press to Confirm",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        elevation: 80,
        backgroundColor: Colors.transparent,  // Keep the background transparent
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('clubs').where('State', isEqualTo : h).snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final data = snapshot.data?.docs;
                _list = data
                    ?.map((e) => ClubModel.fromJson(e.data() as Map<String, dynamic>))
                    .toList() ??
                    [];
                if(_list.isEmpty){
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network("https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/33843/woman-girl-smartphone-clipart-md.png", height: 150),
                          Text("Sorry, No Clubs in Your City", style: TextStyle(fontSize : 22, fontWeight : FontWeight.w600)),
                          Text("Why don't you Share your App to your Friends", style: TextStyle(fontSize : 14, fontWeight : FontWeight.w500)),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: (){}, child:Text("Share App now >>"),),
                          SizedBox(height: 10,),
                          ElevatedButton(onPressed: (){
                            Navigator.push(
                                context, PageTransition(
                                child: Country(justname: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 800)
                            ));
                            setState(() {

                            });
                          }, child:Text("Use Another City"),),
                        ],
                      )
                  );
                }
                return ListView.builder(
                  itemCount: _list.length,
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Hoye(
                      user: _list[index], user1: widget.user,
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

String select="";

class Hoye extends StatefulWidget {
  ClubModel user;
UserModel user1;
  Hoye({super.key, required this.user,required this.user1});

  @override
  State<Hoye> createState() => _HoyeState();
}

class _HoyeState extends State<Hoye> {
  String s = " ";
  initState(){
    super.initState();
    vq();
  }

  vq() async{
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();

    s = FirebaseAuth.instance.currentUser!.uid ?? "h";
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          setState(() {
            select=widget.user.uid;
          });
          if(select==widget.user.uid){
            Navigator.push(
                context,
                PageTransition(
                    child: NowSelect(user: widget.user1, rating: widget.user.ratingsnumber.toDouble(), id:widget.user.uid,
                      name: widget.user.Name,
                      distance:calculateDistance(_user!.Lat, _user.Lon, widget.user.Lat, widget.user.Lon)+" kms Away",
                      location: widget.user.Location, pic: widget.user.Pic_link, Lat: widget.user.Lat, Lon: widget.user.Lon ,),
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 80)));
          }
        },
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Global.blac,
                border: Border.all(
                  color:  select==widget.user.uid?Colors.yellowAccent:Global.blac,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(widget.user.Pic_link),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:5,),
                      Text(widget.user.Name,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 19),),
                      SizedBox(height:2,),
                      Text(trim(widget.user.Location),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 13),),
                      SizedBox(height:10,),
                      Row(
                        children: [
                          Icon(CupertinoIcons.location_fill,color: Colors.white,size: 20,),
                          SizedBox(width: 4,),
                          Text(calculateDistance(_user!.Lat, _user.Lon, widget.user.Lat, widget.user.Lon)+" kms Away",
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                          SizedBox(width: 15,),
                          Icon(CupertinoIcons.star_fill,color: Colors.yellow,size: 20,),
                          SizedBox(width: 4,),
                          Text(" ${doubl()}",
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                        ],
                      ),
                      select==widget.user.uid?SizedBox(height:10,):SizedBox(),
                      select==widget.user.uid? Global.yellowcustom(w-150, 40, Icon(Icons.accessibility_new), Colors.yellowAccent, "Yes, Invite here"):SizedBox()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  String doubl() {
    print("Rating people: ${widget.user.ratingpeople}, Ratings number: ${widget.user.ratingsnumber}");
    try {
      if (widget.user.ratingpeople == null || widget.user.ratingpeople == 0) {
        return "0.0";
      }
      double averageRating = widget.user.ratingsnumber / widget.user.ratingpeople;
      return averageRating.toStringAsFixed(1);
    } catch (e) {
      return "0.0";
    }
  }
  String trim(String input) {
    return input.length <= 28 ? input : input.substring(0, 28)+"....";
  }


  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    final lat1Rad = _degreesToRadians(lat1);
    final lon1Rad = _degreesToRadians(lon1);
    final lat2Rad = _degreesToRadians(lat2);
    final lon2Rad = _degreesToRadians(lon2);

    // Calculate the differences between coordinates
    final dLat = lat2Rad - lat1Rad;
    final dLon = lon2Rad - lon1Rad;

    //calculateDistance(user.Lat, user.Lon, _user!.Lat, _user.Lon) + " km"),


    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    final distance = R * c;

    if( distance > 100 ){
      return "100+" ;
    }
    // Format the distance as a string
    return distance.toStringAsFixed(1); // Adjust the precision as needed
  }
}

class NowSelect extends StatefulWidget {
  UserModel user;String id, name, distance,location,pic;
  double Lat, Lon, rating;
   NowSelect({super.key,required this.Lat, required this.Lon,required this.user,required this.rating,required this.id,required this.name,required this.distance,required this.location, required this.pic});

  @override
  State<NowSelect> createState() => _NowSelectState();
}

class _NowSelectState extends State<NowSelect> {
  late DateTime _selectedDateTime;
  late TimeOfDay _selectedTime;
  late DateTime _now;
  late DateTime _minimumDateTime;
  late DateTime _maximumDateTime;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _selectedDateTime = _now;
    _selectedTime = TimeOfDay.fromDateTime(_now);
    _minimumDateTime = _now.subtract(const Duration(days: 40));
    _maximumDateTime = _now.add(const Duration(days: 365));
  }

  /// The context comes from the `Builder` above the widget tree.
  void _onTimeChanged(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
  }

  void _onDateTimeChanged(DateTime newDate) {
    setState(() {
      _selectedDateTime = newDate;
    });
  }

  int i=0;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: w,height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back.png"),
              fit: BoxFit.cover,
              opacity: 0.3
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: InkWell(
                    onTap: (){
                      if(i==0){
                        Navigator.pop(context);
                      }else{
                        i=i-1;
                        setState((){

                        });
                      }

                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                  ),
                ),
              ],
            ),  SizedBox(height: 20,),
            s(w),
            SizedBox(height: 10,),
          ],
        ),
      ),
      persistentFooterButtons: [
        InkWell(
            onTap: () async {
              if(i>=2){
                String uid=DateTime.now().toString();
                NotificationModel yi=NotificationModel(myname: _user!.Name, myid: _user.uid,
                    datee: _singleDatePickerValueWithDefaultValue[0].toString(),
                    timee: chessby_level, preference: preference, locationpic:
                    widget.pic, locationname: widget.location,
                    locationaddress: widget.distance, locationlat: widget.Lat,
                    locationlon: widget.Lon, locationrating: widget.rating,
                    locationid: widget.id, accept: false, reject: false, seen: "",
                    sendername: widget.user.Name, senderid: widget.user.uid, senderpic: widget.user.Pic_link,
                    mypic: _user.Pic_link, mytoken: _user.token, sendertoken: widget.user.token, id: uid,
                    added: [], added2: []
                );
                try{
                  await FirebaseFirestore.instance.collection("Notification").doc(uid).set(yi.toJson());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>ConfirmPassword1()),
                  );
                  Send.message(context, "Match Fight Sended ! Successfully ", true);
                }catch(e){
                  Send.message(context, "$e", false);
                }

              }else{
                i=i+1;
                setState((){

                });
              }
            },
            child: Center(child: Global.yellow(w, "Save & Next"))),
      ]
    );
  }
  Widget s(double w){
    if(i==0){
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Global.text11("  Choose From Calender", w),
            Global.text2("    Choose Date & Time to decide ", w),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Container(
                color:Global.blac,
                child:  _buildSingleDatePickerWithValue(),
              ),
            ),
            SizedBox(height: 18,),
            r("8 Am to 10 Am", w),
            r("10 Am to 12 Pm", w),
            r("12 Pm to 3 Pm", w),
            r("3 Pm to 6 Pm", w),
            SizedBox(height: 9,),
          ],
        ),
      );
    }else if(i==1){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Global.text11("  Game Preferences", w),
          Global.text2("    Choose your type of chessbyPlayer ", w),
          SizedBox(height: 18,),
          r1("Classical chessby",w),
          r1("Rapid chessby",w),
          r1("Bitz chessby",w),
          r1("Bullet chessby",w),
          r1("Corresponded chessby",w),
          r1("chessby 960",w),
          r1("Equal chessby",w),
          SizedBox(height: 9,),
        ],
      );
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Global.text11("  Confirm Match", w),
          Global.text2("    Finally Confirm these Match Invitation", w),
          SizedBox(height: 23,),
          Center(
            child: CircleAvatar(
              radius: 38,
              backgroundImage: NetworkImage(widget.user.Pic_link),
            ),
          ),
          SizedBox(height:7),
          Center(child: Text(widget.user.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 21),)),
          Center(child: Text(widget.user.Name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
          SizedBox(height: 9,),
          Text("    Location",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(widget.pic),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:5,),
                        Text(widget.name,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white,fontSize: 19),),
                        SizedBox(height:2,),
                        Text(trim(widget.location),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 13),),
                        SizedBox(height:10,),
                        Row(
                          children: [
                            Icon(CupertinoIcons.location_fill,color: Colors.white,size: 20,),
                            SizedBox(width: 4,),
                            Text(widget.distance,
                              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                            SizedBox(width: 15,),
                            Icon(CupertinoIcons.star_fill,color: Colors.yellow,size: 20,),
                            SizedBox(width: 4,),
                            Text(" ${widget.rating}",
                              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 12,),
          Text("    Date & Time",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
          Text("    ${formatDateTime(_singleDatePickerValueWithDefaultValue[0]!)}   $chessby_level",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
          SizedBox(height: 12,),
          Text("    Game Preference",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
          buildThreeRowList(preference),
        ],
      );
    }
  }
  String formatDateTime(DateTime dateTime) {
    try {
      final DateFormat formatter = DateFormat('MMMM d, yyyy');
      return formatter.format(dateTime);
    }catch(e){
      return "Error";
    }
  }
  Widget buildThreeRowList(List<dynamic> items) {
    // Cast the dynamic list to List<String> and limit to 9 items
    List<String> limitedItems = items.cast<String>().take(9).toList();

    // Chunk the list into groups of 3 items each
    List<List<String>> rows = [];
    for (int i = 0; i < limitedItems.length; i += 3) {
      rows.add(limitedItems.sublist(i, (i + 3) > limitedItems.length ? limitedItems.length : i + 3));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: row.map((item) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Global.blac,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item, style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
  String chessby_level="";

  Widget r(String r1, double w){
    return Center(
      child: InkWell(
        onTap: (){
          setState(() {
            chessby_level=r1;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 55,
            width: w-30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: chessby_level==r1?Colors.yellow:Colors.grey,
                ),
                color: chessby_level==r1?Colors.yellow.withOpacity(0.2):Colors.transparent
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                chessby_level==r1?Icon(Icons.check_circle_rounded,color: Colors.yellow,):Icon(Icons.circle,color: Colors.grey,),
                SizedBox(width: 8,),
                Text(r1,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }
  List preference=[];
  Widget r1(String r1, double w){
    return InkWell(
      onTap: (){
        setState(() {
          if(preference.contains(r1)){
            preference.remove(r1);
          }else{
            preference=preference+[r1];
          }
        });
      },
      child:Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 55,
            width: w-30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: preference.contains(r1)?Colors.yellow:Colors.grey,
                ),
                color: preference.contains(r1)?Colors.yellow.withOpacity(0.2):Colors.transparent
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                preference.contains(r1)?Icon(Icons.check_circle_rounded,color: Colors.yellow,):Icon(Icons.circle,color: Colors.grey,),
                SizedBox(width: 8,),
                Text(r1,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 17,color: Colors.white),),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Colors.amber[900],
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      dayMaxWidth: 25,
      animateToDisplayedMonthDate: true,
      controlsTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      centerAlignModePicker: true,
      useAbbrLabelForMonthModePicker: true,
      modePickersGap: 0,
      modePickerTextHandler: ({required monthDate, isMonthPicker}) {
        if (isMonthPicker ?? false) {
          // Custom month picker text
          return '${getLocaleShortMonthFormat(const Locale('en')).format(monthDate)} C';
        }

        return null;
      },
      firstDate: DateTime(DateTime.now().year - 2, DateTime.now().month - 1,
          DateTime.now().day - 5),
      lastDate: DateTime(DateTime.now().year + 3, DateTime.now().month + 2,
          DateTime.now().day + 10),
      selectableDayPredicate: (day) =>
      !day
          .difference(DateTime.now().add(const Duration(days: 3)))
          .isNegative &&
          day.isBefore(DateTime.now().add(const Duration(days: 30))),
    );
    return SizedBox(
      width: 375,
      child: SizedBox(
        width: 360,
        child: CalendarDatePicker2(
          displayedMonthDate: _singleDatePickerValueWithDefaultValue.first,
          config: config,
          value: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (dates) => setState(
                  () => _singleDatePickerValueWithDefaultValue = dates),
        ),
      ),
    );
  }
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now().add(const Duration(days: 1)),
  ];
  String trim(String input) {
    return input.length <= 28 ? input : input.substring(0, 28)+"....";
  }
  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}

class ConfirmPassword1 extends StatefulWidget {
  ConfirmPassword1({super.key});

  @override
  State<ConfirmPassword1> createState() => _ConfirmPasswordState1();
}

class _ConfirmPasswordState1 extends State<ConfirmPassword1> {
  TextEditingController pass1=TextEditingController();

  TextEditingController pass2=TextEditingController();

  bool done=true;

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
            opacity: 0.3,
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            SizedBox(height: 50,),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.yellowAccent,
                  child: Icon(Icons.verified,color: Colors.black,size: 40,),
                ),
              ),
            ), SizedBox(height: 15,),
            Global.text1("Request Sent", w),
            SizedBox(height: 15,),
            Global.text2("Your Request had to been Sen to t", w),
            Global.text2("Once Accepted, Match will be sheduled", w),
            Global.height(20),
            InkWell(
                onTap: () async {
                  Navigator.pushReplacement(
                      context, PageTransition(
                      child: Home(), type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 80)
                  ));
                },
                child: Center(child: Global.yellowwithout(w, "Back to Home"))),
          ],
        )
      ),
    );
  }
}
