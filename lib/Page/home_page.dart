import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surya_tracker/resources/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double mindfulnessLevel = 40.0;
  late Timer _timer;

  final List<String> quotes = [
    "Today is a fresh start, breathe it in.",
    "You are fully present and flowing, stay with it.",
    "You stayed in the moment. Love that for you!",
    "Your focus has left the chat, let's bring it back."
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        mindfulnessLevel = (mindfulnessLevel + 10) % 100;
        if (mindfulnessLevel == 0) mindfulnessLevel = 10;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getMindfulnessQuote() {
    if (mindfulnessLevel >= 80) {
      return quotes[2];
    } else if (mindfulnessLevel >= 50) {
      return quotes[1];
    } else if (mindfulnessLevel >= 20) {
      return quotes[0];
    } else {
      return quotes[3];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: decoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [buildHeader(), buildBody(), buildFooter()],
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: mindfulnessLevel >= 90
            ? [
                const Color(0xffD44D25),
                const Color(0xffBD6B60),
                const Color(0xffA08492),
                const Color(0xff6B7A97),
              ]
            : mindfulnessLevel >= 70
                ? [
                    const Color(0xff4B93FF),
                    const Color(0xff6EA7FC),
                    const Color(0xff8FB6E9),
                    const Color(0xffB5C7CD),
                    const Color(0xffE9CE5D),
                  ]
                : mindfulnessLevel >= 40
                    ? [
                        const Color(0xff8EADD6),
                        const Color(0xffC1D2C5),
                        const Color(0xffF18C2F),
                      ]
                    : [
                        const Color(0xff021218),
                        const Color(0xff052837),
                        const Color(0xff6A3216),
                        const Color(0xff8D370B),
                      ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget buildHeader() {
    return Expanded(
      flex: 3,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(top: 8.5.h, left: 5.w, right: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    imgLightning,
                    height: 5.w,
                    width: 5.w,
                    color: mindfulnessLevel <= 10 ? Colors.red : Colors.white,
                  ),
                  Text(
                    "${mindfulnessLevel.toInt()}%",
                    style: GoogleFonts.poppins(
                      color: mindfulnessLevel <= 10 ? Colors.red : Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  const CircleAvatar(
                    backgroundImage: AssetImage(imgProfile),
                  ),
                ],
              ),
              Text(
                "Hello, Jake.",
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Text(
                getMindfulnessQuote(),
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.poppins(fontSize: 11.sp, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          Container(
              height: 22.h,
              width: 80.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      mindfulnessLevel >= 90
                          ? img100V1
                          : mindfulnessLevel >= 70
                              ? img100V2
                              : mindfulnessLevel >= 40
                                  ? img40
                                  : img20V2,
                    ),
                    fit: BoxFit.cover),
              )),
          SizedBox(height: 2.h),
          Text(
            "${mindfulnessLevel.toInt()}%",
            style: GoogleFonts.poppins(fontSize: 28.sp, color: Colors.white),
          ),
          Text(
            mindfulnessLevel >= 80
                ? "Mindful"
                : mindfulnessLevel >= 40
                    ? "Normal"
                    : "Disengaged",
            style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: mindfulnessLevel >= 40
              ? const Color(0xffE9E3D5)
              : const Color(0xff3D342F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.w),
            topRight: Radius.circular(7.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.5.h),
            Text(
              'Last 30 Minutes',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: mindfulnessLevel >= 40
                    ? const Color.fromARGB(221, 48, 46, 46)
                    : Colors.white,
              ),
            ),
            const Divider(thickness: 2),
            _trendDataRow("Disengaged", "2m 29s", 5, img0V2),
            const Divider(thickness: 2),
            _trendDataRow("Normal", "7m 22s", 25, img40),
            const Divider(thickness: 2),
            _trendDataRow("Mindful", "15m 24s", 45, img100V2),
          ],
        ),
      ),
    );
  }

  Widget _trendDataRow(
      String label, String time, int percentage, String image) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 10.w,
          height: 5.h,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                color: mindfulnessLevel >= 40
                    ? const Color.fromARGB(221, 48, 46, 46)
                    : Colors.white,
                fontSize: 10.sp),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            time,
            style: TextStyle(
                color: mindfulnessLevel >= 40
                    ? const Color.fromARGB(221, 48, 46, 46)
                    : Colors.white,
                fontSize: 10.sp),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            "$percentage%",
            style: TextStyle(
                color: mindfulnessLevel >= 40
                    ? const Color.fromARGB(221, 48, 46, 46)
                    : Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget buildBottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: mindfulnessLevel >= 40
          ? const Color(0xffE1D7D6)
          : const Color(0xff2C2927),
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.white70,
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              imgHome,
              width: 10.w,
              height: 10.w,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Image.asset(
              imgMeditate,
              width: 10.w,
              height: 10.w,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Image.asset(
              imgCommunity,
              width: 10.w,
              height: 10.w,
            ),
            label: ''),
      ],
    );
  }
}
