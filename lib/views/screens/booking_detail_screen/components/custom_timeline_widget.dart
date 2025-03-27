import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CustomTImelineWidget extends StatelessWidget {
  const CustomTImelineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: status.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !status[index].status ? const Color(0xFFEB0404) : const Color(0xFF00C060),
                    ),
                    child: Icon(
                      !status[index].status ? Icons.location_on : Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  if (index != status.length - 1)
                    DottedBorder(
                      strokeWidth: 2,
                      dashPattern: const [5, 5],
                      color: Colors.black.withOpacity(0.7),
                      customPath: (size) {
                        return Path()
                          ..moveTo(size.width / 2, 4)
                          ..lineTo(size.width / 2, 50);
                      },
                      child: const SizedBox(height: 30, width: 2),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  status[index].address,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Status {
  String address;
  bool status;

  Status(this.address, this.status);
}

List<Status> status = [
  Status(
    'Gopi Tank Marg, Mahim West, Shivaji Park, Mumbai, Maharashtra 400016',
    true,
  ),
  Status(
    'Worli Shivaji Nagar, Worli Mumbai, Maharashtra 400030 . Pravin Dhuri . +91 61245 121321',
    true,
  ),
  Status(
    'Gopi Tank Marg, Mahim West, Shivaji Park, Mumbai, Maharashtra 400016',
    false,
  ),
  Status(
    'Gopi Tank Marg, Mahim West, Shivaji Park, Mumbai, Maharashtra 400016',
    false,
  ),
  Status(
    'Gopi Tank Marg, Mahim West, Shivaji Park, Mumbai, Maharashtra 400016',
    false,
  ),
];
