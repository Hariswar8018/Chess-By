import 'package:chessby/models/teacher_model.dart';
import 'package:chessby/models/usermodel.dart';
import 'package:chessby/providers/declare.dart';
import 'package:flutter/material.dart';
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class HomeT extends StatefulWidget {
  TeacherModel user;
   HomeT({Key? key, required this.user});

  @override
  State<HomeT> createState() => _HomeState();
}

class _HomeState extends State<HomeT> {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedCircularChartState> _chartKey =
    new GlobalKey<AnimatedCircularChartState>();
    final GlobalKey<AnimatedCircularChartState> _chartKey2 =
    new GlobalKey<AnimatedCircularChartState>();
    final GlobalKey<AnimatedCircularChartState> _chartKey3 =
    new GlobalKey<AnimatedCircularChartState>();
    final GlobalKey<AnimatedCircularChartState> _chartKey4 =
    new GlobalKey<AnimatedCircularChartState>();

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(20.0, Colors.white, rankKey: 'Q1'),
          new CircularSegmentEntry(10.0, Colors.black, rankKey: 'Q2'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
    List<CircularStackEntry> data2 = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(90.0, Colors.white, rankKey: 'Q1'),
          new CircularSegmentEntry(10.0, Colors.black, rankKey: 'Q2'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
    List<CircularStackEntry> data3 = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry( (widget.user!.Imp_N.length.toDouble() + 1.0) , Colors.white, rankKey: 'Q1'),
          new CircularSegmentEntry((widget.user!.Tap_N.length.toDouble() + 1.0), Colors.black, rankKey: 'Q2'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];
    List<CircularStackEntry> data4 = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(50.0, Colors.white, rankKey: 'Q1'),
          new CircularSegmentEntry(10.0, Colors.black, rankKey: 'Q2'),
        ],
        rankKey: 'Quarterly Profits',
      ),
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
          extendBodyBehindAppBar: true,

          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Joined :",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                widget.user!.Joined,
                                style:
                                TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Impressions :",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${widget.user!.Imp_N.length}",
                                style:
                                TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "No of Taps : ",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${widget.user!.Tap_N.length}",
                                style:
                                TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Requested for Message/Call :",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${widget.user!.Active_N.length}",
                                style:
                                TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            children: [
                              Text(
                                "Summary :",
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Spacer()
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedCircularChart(
                                    key: _chartKey,
                                    size: const Size(60.0, 60.0),
                                    initialChartData: data,
                                    chartType: CircularChartType.Pie,
                                  ),
                                  Text(
                                    v(widget.user!.Tap_N.length, widget.user!.Imp_N.length),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Tap per Impr",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedCircularChart(
                                    key: _chartKey2,
                                    size: const Size(60.0, 60.0),
                                    initialChartData: data2,
                                    chartType: CircularChartType.Pie,
                                  ),
                                  Text(
                                    v(widget.user!.Active_N.length, widget.user!.Imp_N.length),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                   " Request info ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedCircularChart(
                                    key: _chartKey3,
                                    size: const Size(60.0, 60.0),
                                    initialChartData: data3,
                                    chartType: CircularChartType.Pie,
                                  ),
                                  Text(
                                   "30" /* h(widget.user!.Imp_N.length, widget.user!.Tap_N.length) +*/ "%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Good Profile",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedCircularChart(
                                    key: _chartKey4,
                                    size: const Size(60.0, 60.0),
                                    initialChartData: data4,
                                    chartType: CircularChartType.Pie,
                                  ),
                                  Text(
                                    "4.5%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Ratings",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    )),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text("Your Profile Summary", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),)),
                ),
                Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 4,
                        height:120,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text("Account Status", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text("Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text("Active", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700,),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text(widget.user.Name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text("Phone Number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text(widget.user.Phone.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700,),),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2 - 8,
                                  child:
                                  Text(widget.user.Email, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }

  String v(int s, int d){
    double g = s/d;
    g = g*100;
    int f =  g.toInt() ;
    String h = f.toString() ;
    return h;
  }

 /* String cs (String g){
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(g);
    String fo = DateFormat.yMMMEd().format(tempDate);
    return fo;
  }

  String h(int i, int b){
    i = i+1;
    b = b +1;
    double h =  i/b*100;
    int roundedValue = h.round();
    String d = roundedValue.toString();
    return d;
  }*/
}
