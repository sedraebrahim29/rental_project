import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/edit_property_cubit.dart';
import '../../cubit/edit_property_state.dart';
import '../../data/colors.dart';
import '../../models/property_model.dart';

class EditPropertyScreen extends StatelessWidget {
  final PropertyModel property;

  const EditPropertyScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPropertyCubit()..init(property.id!),
      child: BlocConsumer<EditPropertyCubit, EditPropertyState>(
        listener: (context, state) {
          if (state is EditPropertySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Property Updated Successfully!")),
            );
            Navigator.pop(context); // Close screen
          } else if (state is EditPropertyError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          // 1. Loading State
          if (state is EditPropertyLoading) {
            return const Scaffold(
              backgroundColor: MyColor.offWhite,
              body: Center(
                child: CircularProgressIndicator(color: MyColor.deepBlue),
              ),
            );
          }

          // 2. Loaded State (Show Form)
          if (state is EditPropertyLoaded || state is EditPropertyUpdating) {
            final cubit = context.read<EditPropertyCubit>();
            final loadedState = state is EditPropertyLoaded
                ? state
                : (context.read<EditPropertyCubit>().state
                      as EditPropertyLoaded);
            // ^ Handling state access carefully during updating

            return Scaffold(
              backgroundColor: MyColor.offWhite,
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  "Edit Property",
                  style: TextStyle(
                    color: MyColor.offWhite,
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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header Image Section
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
                        // If we have new images, show the first one, else show add icon
                        child: GestureDetector(
                          onTap: cubit.pickImage,
                          child: loadedState.newImages.isNotEmpty
                              ? Stack(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: FileImage(
                                            loadedState.newImages.last,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Dropdown
                          _buildDropdown(
                            loadedState.selectedCategoryId,
                            loadedState.allCategories,
                            (val) => cubit.changeCategory(val),
                          ),
                          const SizedBox(height: 15),

                          _buildEditField("Price", cubit.priceCtrl, "/per night"),
                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Expanded(
                                child: _buildEditField(
                                  "Beds",
                                  cubit.bedsCtrl,
                                  "",
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: _buildEditField(
                                  "Baths",
                                  cubit.bathsCtrl,
                                  "",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),

                          _buildEditField("Area", cubit.areaCtrl, "m2"),
                          const SizedBox(height: 15),

                          const Text(
                            "Amenities",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Dynamic Amenities Wrap
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: loadedState.allAmenities.map((item) {
                              final id = item['id'];
                              final name = item['name'];
                              final isSelected = loadedState.selectedAmenityIds
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
                                        const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: MyColor.deepBlue,
                                        ),
                                      if (isSelected) const SizedBox(width: 5),
                                      Text(
                                        name.toString(),
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
                          const SizedBox(height: 20),

                          _buildEditField(
                            "Address details",
                            cubit.addressCtrl,
                            "",
                          ),
                          const SizedBox(height: 30),

                          // Action Buttons Row
                          Row(
                            children: [
                              // Delete Button
                              Container(
                                decoration: BoxDecoration(
                                  color: MyColor.darkRed,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  onPressed: () =>
                                      _showDeleteDialog(context, cubit),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),

                              // Save Button
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: state is EditPropertyUpdating
                                      ? null
                                      : cubit.updateProperty,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColor.deepBlue,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: state is EditPropertyUpdating
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text(
                                          "Save",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(); // Fallback
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, EditPropertyCubit cubit) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Property"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              cubit.deleteProperty(); // Trigger delete
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: MyColor.darkRed),
            ),
          ),
        ],
      ),
    );
  }

  // UPDATED: Now accepts ID (int) and List<Map>
  Widget _buildDropdown(
    int? value,
    List<Map<String, dynamic>> items,
    Function(int?) onChanged,
  ) {
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
          hint: const Text("Select Category"),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e['id'] as int,
                  child: Text(e['name'].toString()),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildEditField(
    String label,
    TextEditingController controller,
    String suffix,
  ) {
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
}
