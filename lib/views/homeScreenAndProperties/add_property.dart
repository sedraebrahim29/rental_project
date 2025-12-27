import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/add_property_cubit.dart';
import '../../cubit/add_property_state.dart';
import '../../cubit/property_cubit.dart';
import '../../data/colors.dart';
import '../../models/property_model.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPropertyCubit>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/AddProperty.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withAlpha(120)),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Property',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // الصور المختارة
                      BlocBuilder<AddPropertyCubit, AddPropertyState>(
                        builder: (context, state) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...cubit.images.map((file) => Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: FileImage(file),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: -5,
                                      child: IconButton(
                                        icon: const Icon(Icons.cancel, color: Colors.red),
                                        onPressed: () => cubit.removeImage(file),
                                      ),
                                    ),
                                  ],
                                )),
                                if (cubit.images.length < 6)
                                  GestureDetector(
                                    onTap: cubit.pickImage,
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.add_a_photo, color: Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _row(
                            _Dropdown('City', cubit.city, cubit.cities, (v) => cubit.city = v),
                            _Dropdown('Governorate', cubit.governorate, cubit.governorates, (v) => cubit.governorate = v),
                          ),
                          _Dropdown('Category', cubit.category, cubit.categories, (v) => cubit.category = v),
                          const SizedBox(height: 15),

                          //  اختيار الميزات
                          const Text("Amenities", style: TextStyle(fontWeight: FontWeight.bold, color: MyColor.deepBlue)),
                          const SizedBox(height: 8),
                          BlocBuilder<AddPropertyCubit, AddPropertyState>(
                            builder: (context, state) {
                              return Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: cubit.amenitiesList.map((amenity) {
                                  final isSelected = cubit.selectedAmenities.contains(amenity);
                                  return FilterChip(
                                    label: Text(amenity),
                                    selected: isSelected,
                                    selectedColor: MyColor.skyBlue,
                                    checkmarkColor: MyColor.deepBlue,
                                    labelStyle: TextStyle(
                                        color: isSelected ? MyColor.deepBlue : Colors.black,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                                    ),
                                    onSelected: (bool selected) {
                                      cubit.toggleAmenity(amenity);
                                    },
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          const SizedBox(height: 15),

                          _row(
                            _Input('Area', cubit.areaCtrl),
                            _Input('Price', cubit.priceCtrl),
                          ),
                          _row(
                            _Input('Beds', cubit.bedsCtrl),
                            _Input('Baths', cubit.bathsCtrl),
                          ),
                          _Input('Address Details', cubit.addressCtrl),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.deepBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                              onPressed: () {
                                if (cubit.images.isNotEmpty) {

                                  final newProperty = PropertyModel(
                                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                                    ownerName: "Ahmad Rahal",
                                    rating: 0.0,
                                    city: cubit.city ?? '',
                                    governorate: cubit.governorate ?? '',
                                    category: cubit.category ?? '',
                                    amenities: List.from(cubit.selectedAmenities),
                                    area: cubit.areaCtrl.text,
                                    price: cubit.priceCtrl.text,
                                    beds: cubit.bedsCtrl.text,
                                    baths: cubit.bathsCtrl.text,
                                    address: cubit.addressCtrl.text,
                                    localImages: List.from(cubit.images), //  الصور المحلية
                                  );

                                  //  إضافة الشقة للكيوبت الرئيسي
                                  context.read<PropertyCubit>().addProperty(newProperty);

                                  //  إغلاق الصفحة
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please add at least one image')),
                                  );
                                }
                              },
                              child: const Text('Add Property', style: TextStyle(color: Colors.white, fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget _row(Widget a, Widget b) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      children: [
        Expanded(child: a),
        const SizedBox(width: 12),
        Expanded(child: b),
      ],
    ),
  );
}

class _Input extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _Input(this.label, this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: _decoration(label),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _Dropdown(this.label, this.value, this.items, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: _decoration(label),
    );
  }
}

InputDecoration _decoration(String label) {
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: MyColor.offWhite,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
  );
}