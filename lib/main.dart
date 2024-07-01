import 'dart:async';
import 'dart:ui';
import 'package:weather_app_day5/widget/get_day_time_based_on_time_ranges.dart';

import '../Widget/body_weather.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/dataModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.lato().fontFamily,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _NameController = TextEditingController();

  late Future<DataModels> _getData;
  //late Future<DataModels> CurrentDataForweather;

  //List<String> cities = ['tehran', 'shiraz', 'London'];

  var CityName = 'tehran';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //for (int i = 0; i <= cities.length; i++) {
    _getData = sendReqApiweather(CityName);
    // }
    //print(_getData);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(''),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          padding: EdgeInsets.only(top: 20),
          icon: const Icon(Icons.search),
          iconSize: 30,
          color: Colors.white,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10, top: 20),
            child: GestureDetector(
              onTap: () => print("cliked menu!"),
              child: SvgPicture.asset(
                "assets/icons/menu.svg",
                height: 40,
                width: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<DataModels>(
        stream: _getData.asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DataModels? data = snapshot.data;

            return Stack(
              children: [
                ImageFiltered(
                    imageFilter: ImageFilter.blur(),
                    child: bodyImage(nowTime, screenHeight, screenWidth)),
                Container(
                  decoration: const BoxDecoration(color: Colors.black26),
                ),
                // Container(
                //   margin: EdgeInsets.only(
                //     top: screenHeight * 0.1,
                //     left: screenWidth * 0.03,
                //   ),
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //             horizontal: screenWidth * 0.005),
                //         width: 25,
                //         height: 10,
                //         decoration: BoxDecoration(
                //             color: Colors.white54,
                //             borderRadius: BorderRadius.circular(5)),
                //       ),
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //             horizontal: screenWidth * 0.002),
                //         width: 7,
                //         height: 7,
                //         decoration: BoxDecoration(
                //             color: Colors.white54,
                //             borderRadius: BorderRadius.circular(5)),
                //       ),
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //             horizontal: screenWidth * 0.002),
                //         width: 7,
                //         height: 7,
                //         decoration: BoxDecoration(
                //             color: Colors.white54,
                //             borderRadius: BorderRadius.circular(5)),
                //       ),
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //             horizontal: screenWidth * 0.002),
                //         width: 7,
                //         height: 7,
                //         decoration: BoxDecoration(
                //             color: Colors.white54,
                //             borderRadius: BorderRadius.circular(5)),
                //       ),
                //     ],
                //   ),
                //),
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return CenterBody(
                      dataModels: data,
                      index: i,
                    );
                  },
                ),
              ],
            );
          } else {
            return Center(
                child: Container(
              width: 70,
              height: 70,
              child: LiquidCircularProgressIndicator(
                value: 0.45, // Defaults to 0.5.
                valueColor: AlwaysStoppedAnimation(Colors
                    .pink), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors
                    .white, // Defaults to the current Theme's backgroundColor.
                borderColor: Colors.red,
                borderWidth: 6.0,
              ),
            ));
          }
        },
      ),
    );
  }

  Image bodyImage(String time, double height, double width) {
    String n = getDayTimeBasedOnTimeRanges(time);
    if (n == "Morning" || n == "noonday" || n == "AfterNoon") {
      return Image.asset(
        "assets/images/teh-day.jpg",
        fit: BoxFit.cover,
        height: height,
        width: width,
      );
    } else if (n == "night") {
      return Image.asset(
        "assets/images/tehran.jpg",
        fit: BoxFit.cover,
        height: height,
        width: width,
      );
    } else {
      return Image.asset(
        "assets/images/teh-day.jpg",
        fit: BoxFit.cover,
        height: height,
        width: width,
      );
    }
  }

  Future<DataModels> sendReqApiweather(String cityName) async {
    var clientId = 'bca6f8aac3de0b4757979a5bd55a5818';

    var response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {'q': cityName, 'appid': clientId, 'units': 'metric'});

    //print(response.statusCode);
    print(response.data);

    var dataModel = DataModels(
        response.data['name'],
        response.data['coord']['lat'],
        response.data['weather'][0]['description'],
        response.data['coord']['lon'],
        response.data['weather'][0]['main'],
        response.data['pressure'],
        response.data['main']['temp'],
        response.data['main']['temp_max'],
        response.data['main']['temp_min'],
        response.data['country'],
        response.data['timezone'],
        response.data['main']['humidity'],
        response.data['sys']['sunrise'],
        response.data['sys']['sunset'],
        response.data['wind']['speed']);
    return dataModel;
  }
}
