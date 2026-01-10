import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class BookedDateDisplay extends StatelessWidget {
   BookedDateDisplay({
     required this.bookedDates});

   final List bookedDates;
  @override
  Widget build(BuildContext context) {
    return Container(

      width: 320,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColor.deepBlue),
      ),
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(right: 15,top: 5,bottom: 5),
          child: Scrollbar(
            thickness: 6,
            radius: const Radius.circular(10),
            child:  ListView.builder(
            itemCount: bookedDates.length,
            itemBuilder: (context, index) {
              final b = bookedDates[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Center(
                  child: Text(
                    'from : ${b.startDate}      to : ${b.endDate}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            },
          ),

        ),
        ),
      )


    );
  }
}
