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
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: MyColor.offWhite, // Clean background
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              "Add Property",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: MyColor.deepBlue,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // ResizeToAvoidBottomInset so keyboard doesn't break layout
          resizeToAvoidBottomInset: true,
          body: BlocBuilder<AddPropertyCubit, AddPropertyState>(
            builder: (context, state) {
              final cubit = context.read<AddPropertyCubit>();

              // Show loader if data is fetching initially
              if (state is AddPropertyLoading && cubit.governorates.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: MyColor.deepBlue),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // 1. HEADER SECTION (Blue Curve + Camera Icon)
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: MyColor.deepBlue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: cubit.pickImage,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              // If images exist, show the most recent one as background
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              image: cubit.images.isNotEmpty
                                  ? DecorationImage(
                                      image: FileImage(cubit.images.last),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: cubit.images.isNotEmpty
                                ? null // Hide icon if image is shown
                                : const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                          ),
                        ),
                      ),
                    ),

                    // 2. SELECTED IMAGES LIST (To allow deleting them)
                    // We show this only if images exist
                    if (cubit.images.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                        child: SizedBox(
                          height: 70,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.images.length,
                            separatorBuilder: (ctx, i) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: FileImage(cubit.images[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: -5,
                                    top: -5,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () => cubit.removeImage(
                                        cubit.images[index],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                    // 3. FORM SECTION
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DROPDOWNS
                          _row(
                            _Dropdown(
                              'Governorate',
                              cubit.selectedGovId,
                              cubit.governorates,
                              (v) => cubit.changeGovernorate(v),
                            ),
                            _Dropdown(
                              'City',
                              cubit.selectedCityId,
                              cubit.cities,
                              //FIX HERE
                              cubit.cities.isEmpty
                                  ? null
                                  : (v) => cubit.selectCity(v),
                            ),
                          ),
                          _Dropdown(
                            'Category',
                            cubit.selectedCatId,
                            cubit.categories,
                            //FIX HERE
                            (v) => cubit.selectCategory(v),
                          ),
                          const SizedBox(height: 15),

                          // AMENITIES CHIPS
                          const Text(
                            "Amenities",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyColor.deepBlue,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: cubit.amenitiesList.map((item) {
                              final id = item['id'];
                              final name = item['name'];
                              final isSelected = cubit.selectedAmenitiesIds
                                  .contains(id);

                              return GestureDetector(
                                onTap: () => cubit.toggleAmenity(id),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? MyColor.skyBlue
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected
                                          ? MyColor.deepBlue
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isSelected)
                                        const Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.check,
                                            size: 16,
                                            color: MyColor.deepBlue,
                                          ),
                                        ),
                                      Text(
                                        name,
                                        style: TextStyle(
                                          color: isSelected
                                              ? MyColor.deepBlue
                                              : Colors.black,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 15),

                          // TEXT INPUTS
                          _row(
                            _input('Area', cubit.areaCtrl, "m2"),
                            _input('Price', cubit.priceCtrl, "/per night"),
                          ),
                          _row(
                            _input('Beds', cubit.bedsCtrl, ""),
                            _input('Baths', cubit.bathsCtrl, ""),
                          ),
                          _input('Address Details', cubit.addressCtrl, ""),
                          const SizedBox(height: 30),

                          // SUBMIT BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.deepBlue,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: state is AddPropertySubmitting
                                  ? null
                                  : cubit.submitProperty,
                              child: state is AddPropertySubmitting
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Add ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// --- HELPERS ---

Widget _row(Widget a, Widget b) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Row(
      children: [
        Expanded(child: a),
        const SizedBox(width: 15),
        Expanded(child: b),
      ],
    ),
  );
}

Widget _input(String label, TextEditingController controller, String suffix) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}

// DROPDOWN helper
class _Dropdown extends StatelessWidget {
  final String label;
  final int? value;
  final List<Map<String, dynamic>> items;
  final ValueChanged<int?>? onChanged; //FIX HERE :Make it nullable

  const _Dropdown(this.label, this.value, this.items, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isExpanded: true,
          hint: Text(label),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e['id'] as int,
                  child: Text(
                    e['name'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
