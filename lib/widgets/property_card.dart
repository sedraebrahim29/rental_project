import 'package:flutter/material.dart';
import '../data/colors.dart';
import '../models/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onEdit;
  final VoidCallback onTap;
  // New callback for the booking button
  final VoidCallback? onBooking;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onTap,
    this.onEdit,
    this.onBooking
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MyColor.offWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColor.deepBlue, width: 1.2),
        ),
        child: Row(
          children: [
            //قسم الصور
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _buildImage(),
            ),
            const SizedBox(width: 12),

            // قسم البيانات
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Edit & Booking  الاسم وزر ال
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Booking Button (Replaces Owner Name)
                      if (onBooking != null)
                        GestureDetector(
                          onTap: onBooking,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: MyColor.deepBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Booking',
                              style: TextStyle(
                                  color: MyColor.offWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                      else
                      // Show Owner Name (Home Screen view)
                        Expanded(
                          child: Text(
                            property.ownerName ,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColor.deepBlue,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (onEdit != null)
                        GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: MyColor.deepBlue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'edit',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // نوع الشقة والمساحة
                  _buildInfoItem(Icons.home, property.category),
                  const SizedBox(height: 2),
                  _buildInfoItem(Icons.square_foot_sharp, "${property.area} m²"),

                  const SizedBox(height: 6),

                  // السعر
                  Text(
                    '\$${property.price} / per night',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyColor.deepBlue,
                    ),
                  ),

                  // الموقع
                  Text(
                    "${property.city} - ${property.governorate}",
                    style: const TextStyle(color: MyColor.blueGray, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // التقييم
                  Row(
                    children: [
                      const Icon(Icons.star, color: MyColor.warmGold, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        property.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColor.deepBlue,
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

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: MyColor.blueGray),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: MyColor.deepBlue, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildImage() {
    // 1. Check for Local Images (Prioritize new uploads immediately)
    if (property.localImages != null && property.localImages!.isNotEmpty) {
      return Image.file(
        property.localImages!.first,
        width: 110, height: 130, fit: BoxFit.cover,
      );
    }
    // 2. Check for Remote API Images
    else if (property.imageUrls.isNotEmpty) {
      return Image.network(
        property.imageUrls.first,
        width: 110, height: 130, fit: BoxFit.cover,
        // Added error builder to catch broken links (404)
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 110, height: 130,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 110, height: 130,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
      );
    }
    // 3. Fallback if no images at all
    return Container(
      width: 110, height: 130,
      color: MyColor.blueGray.withOpacity(0.3),
      child: const Icon(Icons.image_not_supported, color: Colors.white, size: 30),
    );
  }
}