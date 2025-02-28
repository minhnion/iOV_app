import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ImageCameraField extends StatelessWidget {
  final String label;

  const ImageCameraField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                label.tr(),
                style: const TextStyle(color: Colors.black87, fontSize: 16),
              )),
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child:
                  Icon(Icons.camera_alt, color: Colors.grey.shade700, size: 24),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                child: Icon(
                  Icons.image,
                  color: Colors.grey.shade700,
                  size: 24,
                )),
          )
        ],
      ),
    );
  }
}
