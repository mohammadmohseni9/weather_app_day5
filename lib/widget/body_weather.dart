import '../Widget/weather_bottom_details.dart';
import '../component/color.dart';
import '../models/dataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'get_day_time_based_on_time_ranges.dart';

String date = DateFormat("y MMMM d " + 'HH:mm a').format(DateTime.now());
String nowTime = DateTime.now().toString();

class CenterBody extends StatelessWidget {
  CenterBody({super.key, this.dataModels, required this.index});

  final int index;

  DataModels? dataModels;

  //final s = SnapshotProvider(snapshotData: , child: centerBody());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final formatter = DateFormat.jm();
    var sunrise = formatter.format(new DateTime.fromMillisecondsSinceEpoch(
        dataModels!.sunrise * 1000,
        isUtc: false));
    var sunset = formatter.format(new DateTime.fromMillisecondsSinceEpoch(
        dataModels!.sunset * 1000,
        isUtc: false));

    return Container(
      padding: const EdgeInsets.all(20),
      //all of content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //just location column
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 90,
                    ),
                    Text(
                      locationName[index],
                      style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 45, color: Colors.white),
                      ),
                    ),
                    Text(
                      dataModels!.Description,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataModels!.temp.round().toString() + "\u2103",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 75,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Min " +
                                dataModels!.temp_min.round().toString() +
                                "\u2103",
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 2,
                            height: 20,
                            child: Container(
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        Text(
                          "Max " +
                              dataModels!.temp_max.round().toString() +
                              "\u2103",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        addressIconSvg(),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          getDayTimeBasedOnTimeRanges(nowTime),
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: screenWidth,
                height: screenHeight * 0.001,
                decoration: const BoxDecoration(
                  color: Colors.white54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weather_details_widget(
                      color: Green,
                      name: "Wind Speed",
                      Ms: true,
                      degree: true,
                      value: dataModels!.windSpeed.toString(),
                    ),
                    weather_details_widget(
                      color: Red,
                      name: "Sunrise",
                      Ms: false,
                      degree: false,
                      value: sunrise,
                    ),
                    weather_details_widget(
                      color: Red,
                      name: "Sunset",
                      Ms: false,
                      degree: false,
                      value: sunset,
                    ),
                    weather_details_widget(
                      color: Red,
                      name: "Humidity",
                      Ms: false,
                      degree: false,
                      value: dataModels!.humidity.toString() + "%",
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}





SvgPicture addressIconSvg() {
  String t = getDayTimeBasedOnTimeRanges(nowTime);

  if (t == "Night") {
    return SvgPicture.asset(
      "assets/icons/moon.svg",
      color: Colors.white,
      width: 45,
      height: 45,
    );
  } else if (t == "AfterNoon" || t == "noonday") {
    return SvgPicture.asset(
      "assets/icons/sun.svg",
      color: Colors.white,
      width: 45,
      height: 45,
    );
  } else {
    return SvgPicture.asset(
      "assets/icons/sun.svg",
      color: Colors.white,
      width: 45,
      height: 45,
    );
  }
}
