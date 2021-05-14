import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/clock.dart';
import '../components/time_in_hour_and_minute.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE, dd MMMM y').format(now);
    var copyRightdate = DateFormat('y').format(now);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              formattedDate,
              // "Đà Nẵng, Việt Nam | VN",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 20,
            ),
            TimeInHourAndMinute(),
            // Spacer(),
            Clock(),
            Spacer(
              flex: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "© $copyRightdate Hoàng Sang",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            )
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       CountryCard(
            //         country: "New York, USA",
            //         timeZone: "+3 HRS | EST",
            //         iconSrc: "assets/icons/Liberty.svg",
            //         time: "9:20",
            //         period: "PM",
            //       ),
            //       CountryCard(
            //         country: "Sydney, AU",
            //         timeZone: "+19 HRS | AEST",
            //         iconSrc: "assets/icons/Sydney.svg",
            //         time: "1:20",
            //         period: "AM",
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
