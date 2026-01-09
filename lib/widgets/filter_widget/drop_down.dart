import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class DropDown extends StatelessWidget {
  final List<String> items;
  final Function(int index) onSelected;

  const DropDown({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: null, //  بدون قيمة مبدئية
      icon: const Icon(Icons.keyboard_arrow_down),
      items: List.generate(items.length, (index) {
        return DropdownMenuItem<int>(
          value: index,
          child: Text(items[index]),
        );
      }),
      onChanged: (value) {
        if (value != null) onSelected(value);
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: MyColor.deepBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: MyColor.deepBlue, width: 2),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:rent/data/colors.dart';
//
// class DropDown extends StatelessWidget {
//   const DropDown({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 65),
//         child: Container(
//           height: 45,
//
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(color: MyColor.deepBlue),
//           ),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(''),
//               Center(child: Icon(Icons.keyboard_arrow_down)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


























