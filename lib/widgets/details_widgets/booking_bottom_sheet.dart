import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/booking_cubit/booking_cubit.dart';
import 'package:rent/cubit/booking_cubit/booking_state.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/helper/token_storage.dart';
import 'package:rent/widgets/details_widgets/booked_date_display.dart';
import 'package:rent/widgets/details_widgets/booking_date_picker.dart';
import 'package:rent/widgets/filter_widget/drop_down.dart';
import 'package:rent/widgets/filter_widget/filter_info_row.dart';

class BookingBottomSheet extends StatefulWidget {
  BookingBottomSheet({super.key,
    required this.apartmentId,
    required this.pricePerNight});

  final int apartmentId;
  final String pricePerNight;

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  int? selectedGovernorateId;
  int? selectedCityId;

  int totalPrice = 0;

  void calculateTotalPrice() {
    if (fromDateController.text.isEmpty ||
        toDateController.text.isEmpty) return;

    final from = DateTime.parse(fromDateController.text);
    final to = DateTime.parse(toDateController.text);

    final days = to.difference(from).inDays;

    if (days > 0) {
      setState(() {
        totalPrice = days * int.parse(widget.pricePerNight);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(80),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text('This apartment is pooked : ',
              style:  TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: MyColor.deepBlue,
              ),),
          ),

          const SizedBox(height: 5),
          Center(  // integrate cubit
            child:BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                if (state is BookingLoading) {
                  return const CircularProgressIndicator();
                }

                if (state is BookingLoaded) {
                  return SizedBox(
                    height: 60,
                    child: ListView.builder(
                      itemCount: state.bookedDates.length,
                      itemBuilder: (context, index) {
                        final b = state.bookedDates[index];
                        return BookedDateDisplay(
                          from: b.startDate,
                          to: b.endDate,
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),

          ),

          const SizedBox(height: 15),

          Text('Chose an available date : ',
            style:  TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColor.deepBlue,
            ),),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('From : ',
                style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColor.deepBlue,
                ),),
              BookingDatePicker(
                controller: fromDateController,
                onPicked: calculateTotalPrice,
              ),

            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text('To :     ',
                style:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MyColor.deepBlue,
                ),),
              BookingDatePicker(
                controller: toDateController,
                onPicked: calculateTotalPrice,
              ),
            ],
          ),
          SizedBox(height: 18,),
          Text('Total price :  $totalPrice \$',
            style:  TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColor.deepBlue,
            ),),
          const SizedBox(height: 20),

          FilterInfoRow(label: 'Governorate', field: DropDown()),
          const SizedBox(height: 7),
          FilterInfoRow(label: 'City', field: DropDown()),

          //book botton
          SizedBox(height: 25),
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
                onPressed: () async {
                  final token = await TokenStorage.getToken();

                  if (selectedGovernorateId == null || selectedCityId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select governorate and city')),
                    );
                    return;
                  }


                  context.read<BookingCubit>().submitBooking(
                    startDate: fromDateController.text,
                    endDate: toDateController.text,
                    pricePerNight: widget.pricePerNight,
                    totalPrice: totalPrice.toString(),
                    propertyId: widget.apartmentId,
                    governorateId: selectedGovernorateId!,
                    cityId: selectedCityId!,

                  );
                },

                child: const Text('BOOK', style: TextStyle(fontSize: 20,
                )),
              ),
            ),
          )










        ],
      ),

    ); }
}
