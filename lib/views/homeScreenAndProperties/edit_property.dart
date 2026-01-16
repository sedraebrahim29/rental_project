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
  late TextEditingController areaController;
  late TextEditingController priceController;
  late TextEditingController addressController;
  late TextEditingController bedsController;
  late TextEditingController bathsController;

  String? selectedCategory;
  late List<String> selectedAmenities;
  late List<File> newLocalImages;
  final ImagePicker _picker = ImagePicker();

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
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => newLocalImages.add(File(pickedFile.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.deepBlue,
        centerTitle: true,
        title: Text(
          t.edit_property,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<PropertyCubit, PropertyState>(
        listener: (context, state) {
          if (state is PropertyUpdated) Navigator.pop(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyColor.deepBlue,
                  borderRadius: const BorderRadius.only(
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
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.add_a_photo, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdown(context, selectedCategory,
                        ['House', 'Apartment', 'Villa', 'Studio'],
                            (val) => setState(() => selectedCategory = val)),
                    const SizedBox(height: 15),

                    _buildEditField(context, t.price, priceController, t.per_mon),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(child: _buildEditField(context, t.beds, bedsController, "")),
                        const SizedBox(width: 15),
                        Expanded(child: _buildEditField(context, t.baths, bathsController, "")),
                      ],
                    ),
                    const SizedBox(height: 15),

                    _buildEditField(context, t.area, areaController, "m2"),
                    const SizedBox(height: 15),

                    Text(
                      t.amenities,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

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
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? MyColor.skyBlue : theme.cardColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? MyColor.deepBlue : theme.dividerColor,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isSelected)
                                  const Icon(Icons.check, size: 16, color: MyColor.deepBlue),
                                if (isSelected) const SizedBox(width: 5),
                                Text(
                                  amenity,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isSelected
                                        ? MyColor.deepBlue
                                        : theme.colorScheme.onSurface,
                                    fontWeight:
                                    isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    _buildEditField(context, t.address_details, addressController, ""),
                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColor.darkRed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () => _showDeleteDialog(context, t),
                            icon: const Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 15),
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
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
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
      city: widget.property.city,
      governorate: widget.property.governorate,
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

    Map<String, String> body = {
      "price": priceController.text,
      "area": areaController.text,
      "bedrooms": bedsController.text,
      "bathrooms": bathsController.text,
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

  void _showDeleteDialog(BuildContext context, AppLocalizations t) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.delete_property, style: theme.textTheme.titleMedium),
        content: Text(t.are_you_sure, style: theme.textTheme.bodyMedium),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(t.cancel)),
          TextButton(
            onPressed: () {
              context.read<PropertyCubit>().deleteProperty(widget.property.id!);
              Navigator.pop(ctx);
            },
            child: Text(t.delete, style: const TextStyle(color: MyColor.darkRed)),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
      BuildContext context,
      String? value,
      List<String> items,
      Function(String?) onChanged,
      ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: theme.textTheme.bodyMedium),
          ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildEditField(
      BuildContext context,
      String label,
      TextEditingController controller,
      String suffix,
      ) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: theme.textTheme.bodyMedium,
          suffixText: suffix,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
