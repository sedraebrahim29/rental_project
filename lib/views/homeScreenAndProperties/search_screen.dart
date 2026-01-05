import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/categories/filter_category/type_category.dart';
import 'package:rent/cubit/filter_cubit/filter_cubit.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/widgets/filter_widget/drop_down.dart';
import 'package:rent/widgets/filter_widget/filter_info_row.dart';
import 'package:rent/widgets/filter_widget/input.dart';
import 'package:rent/widgets/filter_widget/price_range_slider.dart';




class SearchScreen extends StatefulWidget {
 const  SearchScreen({super.key});



  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  int? selectedCategoryId;
  int? selectedGovernorateId;
  int? selectedCityId;
  int? minPrice;
  int? maxPrice;
  List<int> selectedAmenities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true, // هي مشان يعرضلي البودي تحت ال app bar
        appBar: AppBar(
          backgroundColor: Colors.transparent, //شفاف

          title: const Text('filter ',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: MyColor.offWhite,
            ),),
          iconTheme: const IconThemeData(color: Colors.white),
        ),

     body: Container(
       decoration: const BoxDecoration(
         image: DecorationImage(
           image: AssetImage('assets/HomeBackground.png'),
           fit: BoxFit.cover,
         ),
       ),

     child: SafeArea(   // هي بتبعد عن مسافة ال app bar  وبتشتغل تحتا
       child: Column(
         children: [
               Padding(
                 padding: const EdgeInsets.only(top: 150, right: 250),
                 child: Text('Category :',
                   style: TextStyle(
                     fontSize: 19,
                     fontWeight: FontWeight.bold,
                     color:  MyColor.deepBlue,
                   ),),
               ),
               SizedBox(height: 10,),
               Row(
                 children: [
                   SizedBox(width:20),
                   TypeCategoryp(onTap: () {}),
                   SizedBox(width:18),
                   TypeCategoryp(onTap: () {}),
                   SizedBox(width:18),
                   TypeCategoryp(onTap: () {}),
                 ],
               ),
               SizedBox(height:5),
               Row(
                 children: [
                   SizedBox(width:20),
                   TypeCategoryp(onTap: () {}),
                   SizedBox(width:18),
                   TypeCategoryp(onTap: () {}),
                   SizedBox(width:18),
                   TypeCategoryp(onTap: () {}),
                 ],
               ),
           SizedBox(height: 20),
           Padding(
             padding: const EdgeInsets.only(right: 240),
             child: Text('Pricing rang :',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color:  MyColor.deepBlue,
               ),
             ),
           ),
           const SizedBox(height: 10),
           const PriceRangeSlider(),
           const SizedBox(height: 40),

           Padding(
             padding: const EdgeInsets.only(left: 20),
             child: Column( // حطيت كولوم مشان اعمل بادينغ للكل مرة وحدة مو اعمل لكل وحدة لحال
               children: [
                 FilterInfoRow(label: 'Bedrooms', field: Input()),
                 const SizedBox(height: 10),
                 FilterInfoRow(label: 'Bathrooms', field: Input()),
                 const SizedBox(height: 10),
                 FilterInfoRow(label: 'Area', field: Input()),

                 const SizedBox(height: 10),

                 FilterInfoRow(label: 'Governorate', field: DropDown()),
                 const SizedBox(height: 10),
                 FilterInfoRow(label: 'City', field: DropDown()),
                 const SizedBox(height: 10),
                 FilterInfoRow(label: 'Amenities', field: DropDown()),
               ],
             ),
           ),

           SizedBox(height: 30,),

           Center(
             child: SizedBox(
               width: 220,
               height: 40,
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: MyColor.deepBlue,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(28),
                   ),
                 ),
                 onPressed: () {
                   context.read<FilterCubit>().applyFilter(
                     categoryId: selectedCategoryId,
                     minPrice: minPrice,
                     maxPrice: maxPrice,
                     governorateId: selectedGovernorateId,
                     cityId: selectedCityId,
                     amenities: selectedAmenities,
                   );
                 },
                 child: const Text('Apply filter', style: TextStyle(fontSize: 17,
                   color: Colors.white
                 )),
               ),
             ),
           ),


         ],
           ),
       ),
     ),
    );
  }
}
