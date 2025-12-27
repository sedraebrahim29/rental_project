import 'package:flutter/material.dart';
import 'package:rent/models/apartment.dart';
import 'package:rent/widgets/details_image.dart';
import 'package:rent/widgets/details_info.dart';

class DetailsCategory extends StatelessWidget {
  const DetailsCategory({ required this.apartment});

  final Apartment apartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/details_page_1.jpg'),
                    fit: BoxFit.cover)
                  ),

              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsImage(
                    images: [
                      'assets/apartment1.jpg',
                      'assets/apartment2.jpg',
                      'assets/apartment3.jpg',
                      'assets/apartment9.jpg'
                    ],
                  ),
                  SizedBox(height: 100,),
                  DetailsInfo(apartment: apartment),

                           ] )
                ,),
          )],),


    );
  }
}
