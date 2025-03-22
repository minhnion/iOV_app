// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// class ImageCameraField extends StatelessWidget {
//   final String label;
//   final List<String> imagePaths;
//   final bool isEditable;
//
//   const ImageCameraField({
//     super.key,
//     required this.label,
//     this.imagePaths = const [],
//     this.isEditable = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                   flex: 1,
//                   child: Text(
//                     label.tr(),
//                     style: const TextStyle(color: Colors.black87, fontSize: 16),
//                   )
//               ),
//               Expanded(
//                 flex: 1,
//                 child: OutlinedButton(
//                   onPressed: isEditable ? () {} : null,
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)
//                     ),
//                     backgroundColor: isEditable ? Colors.white : Colors.grey.shade200,
//                   ),
//                   child: Icon(Icons.camera_alt,
//                       color: isEditable ? Colors.grey.shade700 : Colors.grey.shade400,
//                       size: 24
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 flex: 1,
//                 child: OutlinedButton(
//                     onPressed: isEditable ? () {} : null,
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8)
//                       ),
//                       backgroundColor: isEditable ? Colors.white : Colors.grey.shade200,
//                     ),
//                     child: Icon(
//                       Icons.image,
//                       color: isEditable ? Colors.grey.shade700 : Colors.grey.shade400,
//                       size: 24,
//                     )
//                 ),
//               )
//             ],
//           ),
//           if (imagePaths.isNotEmpty)
//             Container(
//               margin: const EdgeInsets.only(top: 10),
//               height: 120,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: imagePaths.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: Stack(
//                       children: [
//                         Image.network(
//                           imagePaths[index],
//                           height: 120,
//                           width: 120,
//                           fit: BoxFit.cover,
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               height: 120,
//                               width: 120,
//                               color: Colors.grey[200],
//                               child: Center(
//                                 child: CircularProgressIndicator(
//                                   value: loadingProgress.expectedTotalBytes != null
//                                       ? loadingProgress.cumulativeBytesLoaded /
//                                       loadingProgress.expectedTotalBytes!
//                                       : null,
//                                 ),
//                               ),
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 120,
//                               width: 120,
//                               color: Colors.grey[200],
//                               child: const Center(
//                                 child: Icon(Icons.error, color: Colors.red),
//                               ),
//                             );
//                           },
//                         ),
//                         if (isEditable)
//                           Positioned(
//                             right: 5,
//                             top: 5,
//                             child: GestureDetector(
//                               onTap: () {
//                                 // Handle image deletion if needed
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.7),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(Icons.close, size: 16),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ImageCameraField extends StatelessWidget {
  final String label;
  final List<String> imagePaths;
  final bool isEditable;

  const ImageCameraField({
    super.key,
    required this.label,
    this.imagePaths = const [],
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  label.tr(),
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: isEditable ? () {} : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: isEditable ? Colors.white : Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: isEditable ? Colors.grey.shade700 : Colors.grey.shade400,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: isEditable ? () {} : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: isEditable ? Colors.white : Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.image,
                    color: isEditable ? Colors.grey.shade700 : Colors.grey.shade400,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          if (imagePaths.isNotEmpty)
            LayoutBuilder(
              builder: (context, constraints) {
                // Calculate button width by using the total width minus label width minus spacing
                final totalWidth = constraints.maxWidth;
                final labelWidth = totalWidth / 3; // Since label has flex: 1 out of total flex: 3
                const double spacingWidth = 10.0; // Explicitly define as double
                final buttonsAreaWidth = totalWidth - labelWidth;
                final double singleButtonWidth = (buttonsAreaWidth - spacingWidth) / 2; // Make sure it's double

                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // This empty container takes the same space as the label
                      SizedBox(width: labelWidth),
                      // Container for the scrollable image list
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imagePaths.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: index < imagePaths.length - 1 ? spacingWidth : 0.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: singleButtonWidth,
                                      height: 120,
                                      child: Image.network(
                                        imagePaths[index],
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Container(
                                            color: Colors.grey[200],
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                    : null,
                                              ),
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[200],
                                            child: const Center(
                                              child: Icon(Icons.error, color: Colors.red),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    if (isEditable)
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            // Handle image deletion if needed
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.7),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.close, size: 16),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}