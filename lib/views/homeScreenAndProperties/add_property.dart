import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/add_property_cubit.dart';
import '../../cubit/add_property_state.dart';
import '../../data/colors.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Initialize Cubit and Load Data
    return BlocProvider(
      create: (context) => AddPropertyCubit()..loadInitialData(),
      child: BlocListener<AddPropertyCubit, AddPropertyState>(
        listener: (context, state) {
          if (state is AddPropertySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Property Added Successfully!")),
            );
            Navigator.pop(context); // Close screen
          } else if (state is AddPropertyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Scaffold(
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
                child: BlocBuilder<AddPropertyCubit, AddPropertyState>(
                  builder: (context, state) {
                    final cubit = context.read<AddPropertyCubit>();

                    // Show loader if data is fetching initially
                    if (state is AddPropertyLoading && cubit.governorates.isEmpty) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    }

                    return Column(
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

                              // IMAGES SECTION
                              SingleChildScrollView(
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
                              ),
                            ],
                          ),
                        ),

                        // FORM SECTION
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
                                  // DROPDOWNS
                                  _row(
                                    _Dropdown(
                                      'Governorate',
                                      cubit.selectedGovId,
                                      cubit.governorates, // Pass the List<Map>
                                          (v) => cubit.changeGovernorate(v),
                                    ),
                                    _Dropdown(
                                      'City',
                                      cubit.selectedCityId,
                                      cubit.cities, // Pass the List<Map>
                                          (v) => cubit.selectedCityId = v,
                                    ),
                                  ),
                                  _Dropdown(
                                    'Category',
                                    cubit.selectedCatId,
                                    cubit.categories, // Pass the List<Map>
                                        (v) => cubit.selectedCatId = v,
                                  ),
                                  const SizedBox(height: 15),

                                  // AMENITIES CHIPS
                                  const Text("Amenities", style: TextStyle(fontWeight: FontWeight.bold, color: MyColor.deepBlue)),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    children: cubit.amenitiesList.map((item) {
                                      final id = item['id'];
                                      final name = item['name'];
                                      final isSelected = cubit.selectedAmenitiesIds.contains(id);

                                      return FilterChip(
                                        label: Text(name),
                                        selected: isSelected,
                                        selectedColor: MyColor.skyBlue,
                                        checkmarkColor: MyColor.deepBlue,
                                        labelStyle: TextStyle(
                                            color: isSelected ? MyColor.deepBlue : Colors.black,
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                                        ),
                                        onSelected: (bool selected) {
                                          cubit.toggleAmenity(id);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 15),

                                  // TEXT INPUTS
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

                                  // SUBMIT BUTTON
                                  SizedBox(
                                    width: double.infinity,
                                    height: 55,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColor.deepBlue,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      ),
                                      onPressed: state is AddPropertySubmitting
                                          ? null
                                          : cubit.submitProperty,
                                      child: state is AddPropertySubmitting
                                          ? const CircularProgressIndicator(color: Colors.white)
                                          : const Text('Add Property', style: TextStyle(color: Colors.white, fontSize: 18)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HELPERS

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

// UPDATED DROPDOWN to handle API Maps
class _Dropdown extends StatelessWidget {
  final String label;
  final int? value; // Value is now ID (int)
  final List<Map<String, dynamic>> items; // Items are Maps
  final ValueChanged<int?> onChanged;

  const _Dropdown(this.label, this.value, this.items, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: value,
      // Map the List<Map> to DropdownMenuItem<int>
      items: items.map((e) => DropdownMenuItem(
          value: e['id'] as int,
          child: Text(e['name'].toString())
      )).toList(),
      onChanged: onChanged,
      decoration: _decoration(label),
      menuMaxHeight: 300,
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









