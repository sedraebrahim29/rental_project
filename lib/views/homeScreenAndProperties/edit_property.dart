
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/property_cubit.dart';
import '../../cubit/property_state.dart';
import '../../data/colors.dart';
import '../../models/property_model.dart';

class EditPropertyScreen extends StatelessWidget {
  final PropertyModel property;

  const EditPropertyScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = PropertyCubit();

        // --- 1. PRE-FILL CONTROLLERS ---
        cubit.areaCtrl.text = property.area ?? '';
        cubit.priceCtrl.text = property.price ?? '';
        cubit.bedsCtrl.text = property.beds ?? '';
        cubit.bathsCtrl.text = property.baths ?? '';
        cubit.addressCtrl.text = property.address ?? '';

        // --- 2. LOAD INITIAL DATA (Govs, Cities, Amenities) ---
        // We call the repo directly here since the method might be missing in your Cubit snippet
        // ideally, move this logic into a 'cubit.loadInitialData()' method.
        _loadInitialData(cubit, property);

        return cubit;
      },
      child: _EditPropertyView(property: property),
    );
  }

  /// Helper to load API data and match existing Property strings (e.g. "Cairo") to IDs (e.g. 1)
  void _loadInitialData(PropertyCubit cubit, PropertyModel property) async {
    try {
      // Fetch Lists
      final results = await Future.wait([
        cubit.repo.getGovernorates(),
        cubit.repo.getCategories(),
        cubit.repo.getAmenities(),
      ]);

      cubit.governorates = results[0];
      cubit.categories = results[1];
      cubit.amenitiesList = results[2];

      // Match Governorate ID
      final govMap = cubit.governorates.firstWhere(
            (g) => g['name'] == property.governorate,
        orElse: () => {},
      );
      if (govMap.isNotEmpty) {
        cubit.selectedGovId = govMap['id'];

        // Fetch Cities for this Gov
        cubit.cities = await cubit.repo.getCities(cubit.selectedGovId!);

        // Match City ID
        final cityMap = cubit.cities.firstWhere(
              (c) => c['name'] == property.city,
          orElse: () => {},
        );
        if (cityMap.isNotEmpty) {
          cubit.selectedCityId = cityMap['id'];
        }
      }

      // Match Category ID
      final catMap = cubit.categories.firstWhere(
            (c) => c['name'] == property.category,
        orElse: () => {},
      );
      if (catMap.isNotEmpty) {
        cubit.selectedCatId = catMap['id'];
      }

      // Match Amenities IDs
      if (property.amenities != null) {
        for (var amenityName in property.amenities!) {
          final amMap = cubit.amenitiesList.firstWhere(
                (a) => a['name'] == amenityName,
            orElse: () => {},
          );
          if (amMap.isNotEmpty) {
            cubit.selectedAmenitiesIds.add(amMap['id']);
          }
        }
      }

      // Force UI Refresh
      // Using a dummy emit because we modified variables directly
      if (!cubit.isClosed) {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        cubit.emit(PropertyImagesUpdated([]));
      }
    } catch (e) {
      debugPrint("Error loading initial edit data: $e");
    }
  }
}

class _EditPropertyView extends StatelessWidget {
  final PropertyModel property;

  const _EditPropertyView({required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PropertyCubit, PropertyState>(
      listener: (context, state) {
        if ( state is PropertySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Property Updated Successfully!")),
          );
          Navigator.pop(context); // Close screen
        } else if (state is PropertyError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/AddProperty.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Dark Overlay
            Container(color: Colors.black.withOpacity(0.5)),

            SafeArea(
              child: BlocBuilder<PropertyCubit, PropertyState>(
                builder: (context, state) {
                  final cubit = context.read<PropertyCubit>();

                  // Show loader if data hasn't arrived yet
                  if (cubit.governorates.isEmpty && state is PropertyLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  }

                  return Column(
                    children: [
                      // --- HEADER ---
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Text(
                              'Edit Property',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            // DELETE BUTTON ICON
                            Container(
                              decoration: BoxDecoration(
                                color: MyColor.darkRed.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () => _showDeleteDialog(context, property.id!),
                                icon: const Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- IMAGES SECTION ---
                      // Shows both Existing (Remote) and New (Local)
                      SizedBox(
                        height: 90,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              // 1. Existing Remote Images
                              if (property.imageUrls != null)
                                ...property.imageUrls!.map((url) => _ImageItem(
                                  image: NetworkImage(url),
                                  onRemove: () {
                                    // Handle remote removal logic if needed
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Cannot remove existing images yet"))
                                    );
                                  },
                                )),

                              // 2. New Local Images
                              ...cubit.images.map((file) => _ImageItem(
                                image: FileImage(file),
                                onRemove: () => cubit.removeImage(file),
                              )),

                              // 3. Add Button
                              if ((property.imageUrls?.length ?? 0) + cubit.images.length < 6)
                                GestureDetector(
                                  onTap: cubit.pickImage,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white54),
                                    ),
                                    child: const Icon(Icons.add_a_photo, color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // --- FORM CONTAINER ---
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // DROPDOWNS
                                _row(
                                  _Dropdown(
                                    'Governorate',
                                    cubit.selectedGovId,
                                    cubit.governorates,
                                        (val) async {
                                      cubit.selectedGovId = val;
                                      cubit.selectedCityId = null;
                                      cubit.cities = [];
                                      // Trigger refresh
                                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                      cubit.emit(PropertyImagesUpdated([]));

                                      // Load cities manually since method might be missing in snippet
                                      if(val != null) {
                                        try {
                                          cubit.cities = await cubit.repo.getCities(val);
                                          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                          cubit.emit(PropertyImagesUpdated([]));
                                        } catch (_) {}
                                      }
                                    },
                                  ),
                                  _Dropdown(
                                      'City',
                                      cubit.selectedCityId,
                                      cubit.cities,
                                          (val) {
                                        cubit.selectedCityId = val;
                                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                        cubit.emit(PropertyImagesUpdated([]));
                                      }
                                  ),
                                ),
                                _Dropdown(
                                    'Category',
                                    cubit.selectedCatId,
                                    cubit.categories,
                                        (val) {
                                      cubit.selectedCatId = val;
                                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                      cubit.emit(PropertyImagesUpdated([]));
                                    }
                                ),
                                const SizedBox(height: 15),

                                // AMENITIES CHIPS
                                const Text(
                                  "Amenities",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColor.deepBlue,
                                  ),
                                ),
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
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
                                  _Input('Area', cubit.areaCtrl, suffix: 'm²'),
                                  _Input('Price', cubit.priceCtrl, suffix: '\$'),
                                ),
                                _row(
                                  _Input('Beds', cubit.bedsCtrl),
                                  _Input('Baths', cubit.bathsCtrl),
                                ),
                                _Input('Address Details', cubit.addressCtrl),
                                const SizedBox(height: 30),

                                // SAVE BUTTON
                                SizedBox(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColor.deepBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: state is PropertyLoading
                                        ? null
                                        : () => _onSave(context, cubit),
                                    child: state is PropertyLoading
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text(
                                      'Save Changes',
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
    );
  }

  void _onSave(BuildContext context, PropertyCubit cubit) {
    // 1. Prepare Body (API expects these keys)
    Map<String, dynamic> body = {
      "price": cubit.priceCtrl.text,
      "area": cubit.areaCtrl.text,
      "bedrooms": cubit.bedsCtrl.text,
      "bathrooms": cubit.bathsCtrl.text,
      "address": cubit.addressCtrl.text,
      "governorate_id": cubit.selectedGovId,
      "city_id": cubit.selectedCityId,
      "category_id": cubit.selectedCatId,
      "amenities": cubit.selectedAmenitiesIds,
    };

    // 2. Call Edit
    cubit.editProperty(
      property.id!,
      property, // We pass original model, assumes cubit updates logic
      body,
      cubit.images, // Pass ONLY new local images
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Property"),
        content: const Text("Are you sure? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<PropertyCubit>().deleteProperty(id);
            },
            child: const Text("Delete", style: TextStyle(color: MyColor.darkRed)),
          ),
        ],
      ),
    );
  }
}

// --- HELPER WIDGETS ---

class _ImageItem extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onRemove;

  const _ImageItem({required this.image, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 5,
          top: -5,
          child: GestureDetector(
            onTap: onRemove,
            child: const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: Icon(Icons.close, size: 16, color: Colors.red),
            ),
          ),
        ),
      ],
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
  final String? suffix;

  const _Input(this.label, this.controller, {this.suffix});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: label.contains('Address') ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
        filled: true,
        fillColor: MyColor.offWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final int? value;
  final List<Map<String, dynamic>> items;
  final ValueChanged<int?> onChanged;

  const _Dropdown(this.label, this.value, this.items, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      isExpanded: true,
      value: value,
      items: items.map((e) => DropdownMenuItem(
        value: e['id'] as int,
        child: Text(e['name'].toString(), maxLines: 1, overflow: TextOverflow.ellipsis),
      )).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: MyColor.offWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}