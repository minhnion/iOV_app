import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/image_picker.dart';

class ImageCameraField extends StatefulWidget {
  final String label;
  final List<String> imagePaths;
  final bool isEditable;
  final String fieldName;
  final Function(String, List<File>)? onFilesChanged;
  // final Function(List<String>)? onImagesChanged;
  final Function(List<String>)? onDeletedImagesChanged;
  const ImageCameraField({
    super.key,
    required this.label,
    this.imagePaths = const [],
    this.isEditable = false,
    this.onFilesChanged,
    // this.onImagesChanged,
    required this.fieldName, this.onDeletedImagesChanged,
  });

  @override
  State<ImageCameraField> createState() => _ImageCameraFieldState();
}

class _ImageCameraFieldState extends State<ImageCameraField> {
  late List<String> _currentImagePaths;
  List<File> _imageFiles = [];
  ImagePickerUtils imagePick = ImagePickerUtils();

  Future<void> _handleCameraCapture() async {
    final imagePath = await imagePick.openCamera(context: context);
    if (imagePath != null) {
      final file = File(imagePath);
      setState(() {
        _currentImagePaths.add(imagePath);
        _imageFiles.add(file);
      });

      // if (widget.onImagesChanged != null) {
      //   widget.onImagesChanged!(_currentImagePaths);
      // }

      if (widget.onFilesChanged != null) {
        widget.onFilesChanged!(widget.fieldName, _imageFiles);
      }
    }
  }

  Future<void> _handleGalleryPick() async {
    final imagePaths = await imagePick.openGalleryForMultipleImages(context: context);
    if (imagePaths.isNotEmpty) {
      final files = imagePaths.map((path) => File(path)).toList();
      setState(() {
        _currentImagePaths.addAll(imagePaths);
        _imageFiles.addAll(files);
      });

      // if (widget.onImagesChanged != null) {
      //   widget.onImagesChanged!(_currentImagePaths);
      // }

      if (widget.onFilesChanged != null) {
        widget.onFilesChanged!(widget.fieldName, _imageFiles);
      }
    }
  }

  void _deleteImage(int index) {
    final imagePath = _currentImagePaths[index];
    setState(() {
      _currentImagePaths.removeAt(index);
      if (index < _imageFiles.length) {
        _imageFiles.removeAt(index);
      }
    });

    if(imagePath.startsWith('http')) {
      if(widget.onDeletedImagesChanged != null) {
        widget.onDeletedImagesChanged!([imagePath]);
      }
    }
    // if (widget.onImagesChanged != null) {
    //   widget.onImagesChanged!(_currentImagePaths);
    // }
    if (widget.onFilesChanged != null) {
      widget.onFilesChanged!(widget.fieldName, _imageFiles);
    }
  }

  @override
  void initState() {
    super.initState();
    _currentImagePaths = List.from(widget.imagePaths);

    for (var path in widget.imagePaths) {
      if (!path.startsWith('http')) {
        _imageFiles.add(File(path));
      }
    }
  }

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
                  widget.label.tr(),
                  style: const TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: widget.isEditable ? _handleCameraCapture : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: widget.isEditable ? Colors.white : Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: widget.isEditable ? Colors.grey.shade700 : Colors.grey.shade400,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: widget.isEditable ? _handleGalleryPick : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: widget.isEditable ? Colors.white : Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.image,
                    color: widget.isEditable ? Colors.grey.shade700 : Colors.grey.shade400,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          if (_currentImagePaths.isNotEmpty)
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
                      SizedBox(width: labelWidth),
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _currentImagePaths.length,
                            itemBuilder: (context, index) {
                              final imagePath = _currentImagePaths[index];
                              final isNetworkImage = imagePath.startsWith('http');

                              return Padding(
                                padding: EdgeInsets.only(right: index < widget.imagePaths.length - 1 ? spacingWidth : 0.0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: singleButtonWidth,
                                      height: 120,
                                      child: isNetworkImage
                                          ? Image.network(
                                              imagePath,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Container(
                                                  color: Colors.grey[200],
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey[200],
                                                  child: const Center(
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  ),
                                                );
                                              },
                                            )
                                          : Image.file(
                                              File(imagePath),
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey[200],
                                                  child: const Center(
                                                    child: Icon(Icons.error,
                                                        color: Colors.red),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                    if (widget.isEditable)
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: GestureDetector(
                                          onTap:() => _deleteImage(index),
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