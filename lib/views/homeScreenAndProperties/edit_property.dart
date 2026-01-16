import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent/l10n/app_localizations.dart';
import '../../cubit/property_cubit.dart';
import '../../cubit/property_state.dart';
import '../../data/colors.dart';
import '../../models/property_model.dart';

class EditPropertyScreen extends StatefulWidget {
  final PropertyModel property;

  const EditPropertyScreen({super.key, required this.property});

  @override
  State<EditPropertyScreen> createState() => _EditPropertyScreenState();
}

class _EditPropertyScreenState extends State<EditPropertyScreen> {
  // Controllers
  late TextEditingController areaController;
  late TextEditingController priceController;
  late TextEditingController addressController;
  late TextEditingController bedsController;
  late TextEditingController bathsController;

  String? selectedCategory;
  late List<String> selectedAmenities;
  late List<File> newLocalImages;
  final ImagePicker _picker = ImagePicker();

  // This matches your physical UI exactly
  final List<String> availableAmenities = [
    'WiFi',
    'Pool',
    'Garden',
    'Parking',
    'Gym',
    'Elevator',
    'Balcony',
  ];

  @override
  void initState() {
    super.initState();
    areaController = TextEditingController(text: widget.property.area);
    priceController = TextEditingController(text: widget.property.price);
    addressController = TextEditingController(text: widget.property.address);
    bedsController = TextEditingController(text: widget.property.beds);
    bathsController = TextEditingController(text: widget.property.baths);

    selectedCategory = widget.property.category;
    selectedAmenities = List.from(widget.property.amenities);
    newLocalImages = [];
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        newLocalImages.add(File(pickedFile.path));
      });
    }
  }
  late final t = AppLocalizations.of(context)!;//للترجمة
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColor.offWhite,
      appBar: AppBar(
        elevation: 0,
        title:  Text(
          t.edit_property,
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
      body: BlocListener<PropertyCubit, PropertyState>(
        listener: (context, state) {
          if (state is PropertyUpdated) {
            Navigator.pop(
              context,
            ); // Close on success, HomeScreen updates automatically
          }
        },
        child: SingleChildScrollView(
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
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
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
                      selectedCategory,
                      ['House', 'Apartment', 'Villa', 'Studio'],
                      (val) {
                        setState(() => selectedCategory = val);
                      },
                    ),
                    const SizedBox(height: 15),

                    _buildEditField(t.price, priceController, t.per_mon),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: _buildEditField(t.beds, bedsController, ""),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildEditField(t.baths, bathsController, ""),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    _buildEditField(t.area, areaController, "m2"),
                    const SizedBox(height: 15),

                    Text(
                      t.amenities,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Wrap matches your Chip UI
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: availableAmenities.map((amenity) {
                        final isSelected = selectedAmenities.contains(amenity);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected
                                  ? selectedAmenities.remove(amenity)
                                  : selectedAmenities.add(amenity);
                            });
                          },
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
                                  amenity,
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

                    _buildEditField(t.address_details, addressController, ""),
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
                            onPressed: () => _showDeleteDialog(context),
                            icon: const Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Save Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColor.deepBlue,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              t.save,
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
      ),
    );
  }

  void _onSave() {
    final updatedProperty = PropertyModel(
      id: widget.property.id,
      ownerName: widget.property.ownerName,
      // Required field fixed
      city: widget.property.city,
      // Required field fixed
      governorate: widget.property.governorate,
      // Required field fixed
      category: selectedCategory ?? widget.property.category,
      amenities: selectedAmenities,
      area: areaController.text,
      price: priceController.text,
      beds: bedsController.text,
      baths: bathsController.text,
      address: addressController.text,
      rating: widget.property.rating,
      imageUrls: widget.property.imageUrls,
      localImages: newLocalImages,
    );

    // Prepare API Body for the PUT request
    Map<String, String> body = {
      "price": priceController.text,
      "area": areaController.text,
      "bedrooms": bedsController.text, // API expects 'bedrooms'
      "bathrooms": bathsController.text, // API expects 'bathrooms'
      "address": addressController.text,
      "category": selectedCategory ?? widget.property.category,
    };

    context.read<PropertyCubit>().editProperty(
      widget.property.id!,
      updatedProperty,
      body,
      newLocalImages,
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:  Text(t.delete_property),
        content:  Text(t.are_you_sure),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<PropertyCubit>().deleteProperty(widget.property.id!);
              Navigator.pop(ctx);
            },
            child: Text(
              t.delete,
              style: TextStyle(color: MyColor.darkRed),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
