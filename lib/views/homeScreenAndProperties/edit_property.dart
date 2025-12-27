import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/property_cubit.dart';
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

  // Variables for Dropdowns and Images
  String? selectedCategory;
  late List<String> selectedAmenities;
  late List<File> currentImages;
  final ImagePicker _picker = ImagePicker();
  final List<String> availableAmenities = ['WiFi', 'Pool', 'Garden', 'Parking', 'Gym', 'Elevator', 'Balcony'];

  @override
  void initState() {
    super.initState();
    //  البيانات من الشقة القديمة
    areaController = TextEditingController(text: widget.property.area);
    priceController = TextEditingController(text: widget.property.price);
    addressController = TextEditingController(text: widget.property.address);
    bedsController = TextEditingController(text: widget.property.beds);
    bathsController = TextEditingController(text: widget.property.baths);

    selectedCategory = widget.property.category;
    selectedAmenities = List.from(widget.property.amenities);
    currentImages = List.from(widget.property.localImages ?? []);
  }

  //  اختيار صورة جديدة
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        currentImages.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.offWhite,
      appBar: AppBar(
        title: const Text(
          "Edit Property",
          style: TextStyle(color: MyColor.offWhite, fontWeight: FontWeight.bold),
        ),
        backgroundColor: MyColor.deepBlue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // قسم الصور
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: MyColor.deepBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: currentImages.length + 1,
                itemBuilder: (context, index) {
                  if (index == currentImages.length) {
                    return GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.add_a_photo_outlined,
                          color: MyColor.offWhite,
                          size: 30,
                        ),
                      ),
                    );
                  }
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          currentImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => currentImages.removeAt(index)),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundColor: MyColor.darkRed,
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  _buildDropdown(
                    "Category",
                    selectedCategory,
                    ['House', 'Apartment', 'Villa', 'Studio'],
                        (val) {
                      setState(() => selectedCategory = val);
                    },
                  ),
                  const SizedBox(height: 15),

                  _buildEditField("Price", priceController, "/per mon"),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _buildEditField("Beds", bedsController, ""),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildEditField("Baths", bathsController, ""),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  _buildEditField("Area", areaController, "m2"),
                  const SizedBox(height: 15),


                  // اختيار الميزات
                  const Align(alignment: Alignment.centerLeft, child: Text("Amenities", style: TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: availableAmenities.map((amenity) {
                      final isSelected = selectedAmenities.contains(amenity);
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
                          setState(() {
                            if (selected) {
                              selectedAmenities.add(amenity);
                            } else {
                              selectedAmenities.remove(amenity);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),

                  _buildEditField("Address details", addressController, ""),

                  const SizedBox(height: 40),

                  // صف الأزرار (حذف وحفظ)
                  Row(
                    children: [
                      // زر الحذف
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Delete Property"),
                                content: const Text("Are you sure you want to delete this property?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      //  دالة الحذف من الكيوبت
                                      context.read<PropertyCubit>().deleteProperty(widget.property.id ?? "");
                                      Navigator.pop(ctx); // إغلاق التنبيه
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Delete", style: TextStyle(color: MyColor.darkRed)),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.darkRed,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Icon(Icons.delete, color: MyColor.offWhite),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // زر الحفظ
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            final updatedProperty = PropertyModel(
                              id: widget.property.id,
                              ownerName: widget.property.ownerName,
                              rating: widget.property.rating,
                              city: widget.property.city,
                              governorate: widget.property.governorate,
                              category: selectedCategory ?? widget.property.category,
                              amenities: selectedAmenities ,
                              area: areaController.text,
                              price: priceController.text,
                              beds: bedsController.text,
                              baths: bathsController.text,
                              address: addressController.text,
                              localImages: currentImages,
                              imageUrls: widget.property.imageUrls,
                            );

                            context.read<PropertyCubit>().editProperty(
                              widget.property.id??"",
                              updatedProperty,
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColor.deepBlue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: MyColor.offWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color:  MyColor.offWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(label),
          isExpanded: true,
          items: items.map((String item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildEditField(String label, TextEditingController controller, String suffix) {
    return Container(
      decoration: BoxDecoration(
        color: MyColor.offWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffix,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }
}