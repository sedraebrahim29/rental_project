import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/models/apartment.dart';
import 'package:rent/widgets/helper_chip.dart';

class DetailsInfo extends StatelessWidget {
  final Apartment apartment;

  const DetailsInfo({required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //owner + heart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                apartment.owner,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: MyColor.deepBlue),
              ),
              const Icon(Icons.favorite_border, color: Colors.red),
            ],
          ),

          const SizedBox(height: 6),

          // type + rating
          Row(
            children: [
              Text(
                apartment.type,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: MyColor.deepBlue),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.star, color: Colors.amber, size: 20),
              Text(
                apartment.rating.toString(),
                style: const TextStyle(fontSize: 16,color: MyColor.deepBlue),
              ),
            ],
          ),

          const SizedBox(height: 8),

          //location
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: MyColor.deepBlue),
              const SizedBox(width: 4),
              Text(
                apartment.location,
                style: TextStyle(color: MyColor.deepBlue,fontSize: 15),
              ),
            ],
          ),

          const SizedBox(height: 15),

          //price
          Text(
            '\$${apartment.price}  per night',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: MyColor.deepBlue,
            ),
          ),

          const SizedBox(height: 16),

          //bed + bath + area
          if (apartment.bedrooms != null &&
              apartment.bathrooms != null &&
              apartment.size.isNotEmpty)
          Row(
            children: [

              Text('bedrooms : ${apartment.bedrooms}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyColor.deepBlue,
                ),),
              const SizedBox(width: 20),
              Text('bathrooms : ${apartment.bathrooms}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyColor.deepBlue,
                ),) ,
              const SizedBox(width: 20),
              Text('area : ${apartment.size}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyColor.deepBlue,
                ),) ,


            ],
          ),

          const SizedBox(height: 15),

          //ameninties
          if (apartment.amenities != null && apartment.amenities!.isNotEmpty) ...[
    Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Text(
          'Amenities :',
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: MyColor.deepBlue,
          ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
          height: 120,
          width: 150,
          padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
          BoxShadow(
          color: Colors.black12,
          blurRadius: 9,),],),
          child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            padding: EdgeInsets.zero,
          itemCount: apartment.amenities?.length ?? 0,
          itemBuilder: (context, index) {
          return Padding(
          padding: const EdgeInsets.only(bottom: 5,top: 7),
          child: Row(
          children: [
          const Icon(Icons.circle, size: 6, color: Colors.black54),
          const SizedBox(width: 8),
          Text(apartment.amenities![index]),
          ],),);},),),),
        ),
      ],
    ),


    const SizedBox(height: 30),

          /// BOOK BUTTON
          Center(
            child: SizedBox(
              width: 270,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColor.deepBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () {},
                child: const Text('BOOK', style: TextStyle(fontSize: 20,
                )),
              ),
            ),
          ),
        ],
     ] ),
    );
  }
}

