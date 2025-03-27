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
          bool isFirst = index == 0;
          bool isLast = index == status.length - 1;
          double circleSize = isFirst || isLast ? 40 : 30;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status[index].status ? const Color(0xFF00C060) : const Color(0xFFEB0404),
                    ),
                    child: Icon(
                      status[index].status ? Icons.check : Icons.location_on,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  if (!isLast)
                    SizedBox(
                      height: 30,
                      width: 40,
                      child: DottedBorder(
                        strokeWidth: 2,
                        dashPattern: const [5, 5],
                        color: Colors.black.withOpacity(0.7),
                        customPath: (size) {
                          return Path()
                            ..moveTo(size.width / 2, 8)
                            ..lineTo(size.width / 2, 50);
                        },
                        child: const SizedBox.shrink(),
                      ),
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
