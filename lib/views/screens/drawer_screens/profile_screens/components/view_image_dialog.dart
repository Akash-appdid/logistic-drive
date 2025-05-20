import 'package:flutter/material.dart';

import '../../../../../services/route_helper.dart';
import '../../../../base/custom_image.dart';
import '../../../auth_screens/signup_screen/components/components/certificate_image.dart';

class ViewImageDialog extends StatelessWidget {
  const ViewImageDialog({
    super.key,
    required this.image,
    this.imageTwo,
    required this.title,
  });
  final String image;
  final String title;
  final String? imageTwo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(getCustomRoute(
                    child: ShowImage(
                  image: image,
                )));
              },
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFF2F2F2), width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CustomImage(
                    path: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (imageTwo != null)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(getCustomRoute(
                      child: ShowImage(
                    image: imageTwo,
                  )));
                },
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: const Color(0xFFF2F2F2), width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CustomImage(
                      path: imageTwo ?? '',
                      fit: BoxFit.cover,
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
