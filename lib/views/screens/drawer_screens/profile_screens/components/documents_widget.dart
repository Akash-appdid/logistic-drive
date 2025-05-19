import 'package:flutter/material.dart';

import '../../../../base/common_button.dart';
import 'title_and_value.dart';

class DocumentsWidget extends StatelessWidget {
  const DocumentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: TitleAndValue(
                  title: 'Aadhaar card no:',
                  val: '',
                ),
              ),
              CustomButton(
                height: 30,
                elevation: 0,
                onTap: () {},
                child: Text(
                  'View',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Divider(color: Colors.grey.shade200),
          Row(
            children: [
              const Expanded(
                child: Column(
                  children: [
                    TitleAndValue(
                      title: 'Pan card no:',
                      val: '',
                    ),
                  ],
                ),
              ),
              CustomButton(
                height: 30,
                elevation: 0,
                onTap: () {},
                child: Text(
                  'View',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Divider(color: Colors.grey.shade200),
          Row(
            children: [
              const Expanded(
                child: Column(
                  children: [
                    TitleAndValue(
                      title: 'Driving licence no : ',
                      val: '',
                    ),
                  ],
                ),
              ),
              CustomButton(
                height: 30,
                elevation: 0,
                onTap: () {},
                child: Text(
                  'View',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
