import 'dart:io';

import 'package:chessby/aaaaa/send.dart';
import 'package:chessby/l10n/app_localization.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class MovesPage extends StatefulWidget {
  final List<String> moves;String players;

 MovesPage({Key? key, required this.moves,required this.players}) : super(key: key);

  @override
  State<MovesPage> createState() => _MovesPageState();
}

class _MovesPageState extends State<MovesPage> {
  double i = 1, j = 5;
  final ExportDelegate exportDelegate = ExportDelegate();
  @override
  void initState() {
    super.initState();
    j = widget.moves.length.toDouble(); // Set upper range to the maximum moves
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          '${AppLocalizations.of(context)!.translate("Moves")}',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Frame with moves
          Expanded(
            child: ExportFrame(
              frameId: 'someFrameId',
              exportDelegate: exportDelegate,
              child: Container(
                width: w,
                height: w * 1.35,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2),
                  child: Column(
                    children: [
                      // Title Section
                      Container(
                        width: w,
                        height: 57,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/logo.png"),
                              radius: w / 14,
                            ),
                            SizedBox(width: 12),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${AppLocalizations.of(context)!.translate("CHESSBY CHESSBOARD PLAY SHEET")}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: w / 27)),
                                Text("${AppLocalizations.of(context)!.translate("Players")} : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: w / 31)),
                                Text("${AppLocalizations.of(context)!.translate("DateTime")} : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: w / 32)),
                              ],
                            )
                          ],
                        ),
                      ),
                      // Green Line Divider
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: const Color(0xff00CE9D),
                          width: w - 10,
                          height: 3,
                        ),
                      ),
                      // Moves List based on Slider Range
                      Container(
                        width: w - 8,
                        height: w * 1.1 - 2,
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: List.generate(
                            (j - i + 1).clamp(0, widget.moves.length - i + 1).toInt(),
                                (index) {
                              int actualIndex = (i + index - 1).toInt();

                              if (actualIndex >= 0 && actualIndex < widget.moves.length) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  width: (w - 8) / 5,
                                  child: Text(
                                    widget.moves[actualIndex],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      height: 1.2,
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          ss(),
                          ss(),
                          Text("${AppLocalizations.of(context)!.translate("Thanks")}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: w / 28)),
                          const Spacer(),
                        ],
                      ),
                      Container(
                        color: const Color(0xff00CE9D),
                        width: w - 40,
                        height: 3,
                      ),
                      s(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom Slider Section
          Container(
            color: Colors.black,
            width: w,
            height: h - w * 1.35 - 88,
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Text(
                  "Drag the Slider until you export All Frame",
                  style: TextStyle(color: Colors.white),
                ),
                FlutterSlider(
                  values: [i, j],
                  max: widget.moves.length.toDouble(),
                  min: 1,
                  rangeSlider: true,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      i = lowerValue.clamp(1, widget.moves.length).toDouble();
                      j = upperValue.clamp(1, widget.moves.length).toDouble();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap:() async {
                        try{
                          var status = await Permission.storage.status;
                          if (!status.isGranted) {
                            await Permission.storage.request();
                          }
                          final ExportOptions overrideOptions = ExportOptions(
                            textFieldOptions: TextFieldOptions.uniform(interactive: false),
                            pageFormatOptions: PageFormatOptions.custom(
                              width: w,
                              height: w * 1.35,
                              clip: true,
                              marginAll: 0,
                            ),
                            checkboxOptions: CheckboxOptions.uniform(interactive: false),
                          );
                          final pdf = await exportDelegate.exportToPdfDocument(
                              "someFrameId",
                              overrideOptions: overrideOptions);
                          final filePath = await saveFile(pdf,"${widget.players}_${DateTime.now().day}-${DateTime.now().month}_+${DateTime.now().month}___${DateTime.now().hour}:${DateTime.now().month}");
                          Send.message(context, "Success ! File saved on $filePath",true);
                          if (filePath != null) {
                            Share.shareXFiles([XFile(filePath)], text: 'Here is your PDF file.');
                          }else{
                            print("hjmjn");
                          }
                        }catch(e){
                          print(e);
                          Send.message(context, "$e",false);
                        }
                      },
                      child: Container(
                        height:45,width:w/2-15,
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
                        child: Center(child: Text("${AppLocalizations.of(context)!.translate("Export Frame to PDF")}",style: TextStyle(
                            color: Colors.white,
                            fontFamily: "RobotoS",fontWeight: FontWeight.w800
                        ),)),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await exportToCSV(widget.moves, widget.players, "Game_Moves");
                      },
                      child: Container(
                        height:45,width:w/2-15,
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
                        child: Center(child: Text("${AppLocalizations.of(context)!.translate("Download All as CSV")}",style: TextStyle(
                            color: Colors.white,
                            fontFamily: "RobotoS",fontWeight: FontWeight.w800
                        ),)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap:() async {
                        try{
                          final ExportOptions overrideOptions = ExportOptions(
                            textFieldOptions: TextFieldOptions.uniform(interactive: false),
                            pageFormatOptions: PageFormatOptions.custom(
                              width: w,
                              height: w * 1.35,
                              clip: true,
                              marginAll: 0,
                            ),
                            checkboxOptions: CheckboxOptions.uniform(interactive: false),
                          );
                          final pdf = await exportDelegate.exportToPdfDocument(
                              "someFrameId",
                              overrideOptions: overrideOptions);
                          final filePath = await saveFile(pdf,"Player_${DateTime.now().day}-${DateTime.now().month}_+${DateTime.now().month}___${DateTime.now().hour}:${DateTime.now().month}");
                          Send.message(context, "Success ! File saved on $filePath",true);
                          if (filePath != null) {
                            Share.shareXFiles([XFile(filePath)], text: 'Here is your PDF file.');
                          }else{
                            print("hjmjn");
                          }
                        }catch(e){
                          print(e);
                          Send.message(context, "$e",false);
                        }
                      },
                      child: Container(
                        height:45,width:w/2-15,
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
                        child: Center(child: Text("Export Frame to PDF",style: TextStyle(
                            color: Colors.white,
                            fontFamily: "RobotoS",fontWeight: FontWeight.w800
                        ),)),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await exportToCSV(widget.moves, "cgbcbgc", "bcbcv");
                      },
                      child: Container(
                        height:45,width:w/2-15,
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
                        child: Center(child: Text("Download All as CSV",style: TextStyle(
                            color: Colors.white,
                            fontFamily: "RobotoS",fontWeight: FontWeight.w800
                        ),)),
                      ),
                    ),
                  ],
                )*/
  Widget s()=>SizedBox(height:10);
  Widget ss()=>SizedBox(width:10);
  Future<void> exportToCSV(List<String> docs, String id, String classu) async {
    // Initialize rows for the CSV
    List<List<dynamic>> rows = [];

    // Add header row
    rows.add(["Name", "cgvhn"]);

    // Add a blank row
    rows.add([]);

    for (int i = 0; i < 60; i++) {
      if (i < docs.length) {
        var record = docs[i];
        rows.add([
          record,
        ]);
      } else {
        rows.add([]);
      }
    }

    // Convert rows to CSV string
    String csv = const ListToCsvConverter().convert(rows);

    // Check and request storage permissions
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (status.isGranted) {
      // Get external storage directory
      Directory? dir = await getExternalStorageDirectory();
      if (dir != null) {
        String filePath = "${dir.path}/id_${id}_${classu}_list.csv";

        // Write CSV to file
        File file = File(filePath);
        await file.writeAsString(csv);
        Send.message(context, "Success ! File saved on $filePath",true);
      } else {
        Send.message(context, "Error: Could not get external storage directory",false);
        print("Error: Could not get external storage directory.");
      }
    } else {
      print("Permission denied for storage.");
      Send.message(context, "${AppLocalizations.of(context)!.translate("Permission denied for storage")}",false);
    }
  }
  Future<String?> saveFile( document, String name) async {
    try {
      final Directory? dir = await getExternalStorageDirectory();
      if (dir != null) {
        final String downloadsPath = '${dir.path}';
        final String filePath = '$downloadsPath/$name.pdf';
        final File file = File(filePath);
        await file.writeAsBytes(await document.save());
        debugPrint('Saved exported PDF at: $filePath');
        return filePath;
      } else {
        debugPrint('Could not access external storage directory.');
        return null;
      }
    } catch (e) {
      print(e);

      return null;
    }
  }
}
