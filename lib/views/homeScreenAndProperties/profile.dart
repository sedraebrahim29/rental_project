import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/models/property_model.dart';
import 'package:rent/widgets/filter_widget/filter_info_row.dart';
import 'package:rent/widgets/filter_widget/input.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.apart});

 final PropertyModel apart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body:  Container(

        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/android_compact_1.jpg'),
        fit: BoxFit.fill)
            ),
          child: Column(
            children: [
              SizedBox(height: 100),
              const CircleAvatar(
        radius: 75,
        backgroundColor: Colors.white,
              ),
              SizedBox(height: 30,),
              Text('${apart.ownerName}',
              style: TextStyle(color: MyColor.deepBlue,fontSize: 30),),
              SizedBox(height: 30,),

              Center(
        child: SizedBox(
          width: 210,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
            },
            child: const Text('Edit profile', style: TextStyle(fontSize: 17,
                color: MyColor.deepBlue,
            )),
          ),
        ),
              ),
              SizedBox(height: 30),
              FilterInfoRow(label: 'Phone number', field: Input()),
              SizedBox(height: 25),
              FilterInfoRow(label: 'Birth date', field: Input()),
              SizedBox(height: 25),
              FilterInfoRow(label: 'Properties', field: Input()),
              SizedBox(height: 25),
              FilterInfoRow(label: 'Balance', field: Input()),

              SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: 270,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                    },
                    child: const Text('Top Up Balance', style: TextStyle(fontSize: 17,
                      color: MyColor.deepBlue,
                    )),
                  ),
                ),
              ),

            ],
            )
          ));

  }
}
