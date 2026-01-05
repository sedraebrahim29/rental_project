import 'package:flutter/material.dart';

class DetailsImage extends StatefulWidget {

  final List<String> images;

  const DetailsImage({required this.images});


  @override
  State<DetailsImage> createState() => _DetailsImageState();
}

class _DetailsImageState extends State<DetailsImage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Column(
          children: [
            Container(
              height: 280,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              child: PageView.builder(
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return widget.images[index].startsWith('http')
                      ? Image.network(
                    widget.images[index],
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    widget.images[index],
                    fit: BoxFit.cover,
                  );

                },
              ),
            ),

            const SizedBox(height: 20),

            // DOTS INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width:  8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.white
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
