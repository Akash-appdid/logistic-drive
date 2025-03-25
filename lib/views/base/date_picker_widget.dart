import 'package:flutter/material.dart';

import '../../services/theme.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.child,
    required this.today,
    required this.onChanged,
    this.getTime = false,
    this.years = 0,
    this.enabled,
    this.datePickerMode = DatePickerMode.day,
  });

  final Widget child;
  final bool today;
  final bool getTime;
  final bool? enabled;
  final int years;
  final DatePickerMode datePickerMode;
  final Function(DateTime? dateTime) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (enabled ?? true) {
          showDatePicker(
            context: context,
            initialDatePickerMode: datePickerMode,
            initialDate: DateTime.now().subtract(Duration(days: 356 * years)),
            firstDate: today ? DateTime.now() : DateTime(1940),
            lastDate: years == 0 ? DateTime.now().add(const Duration(days: 356 * 10)) : DateTime.now().subtract(Duration(days: 356 * years)),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  textTheme: TextTheme(
                    headlineMedium: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20.0,
                        ),
                  ),
                  colorScheme: ColorScheme.light(
                    primary: primaryColor, // header background color
                    onPrimary: Colors.white, // header text color
                    onSurface: primaryColor, // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          ).then((dateValue) {
            if (dateValue != null && getTime) {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      textTheme: TextTheme(
                        headlineMedium: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20.0, color: Colors.black87),
                      ),
                      colorScheme: ColorScheme.light(
                        secondary: primaryColor,

                        primary: primaryColor, // header background color
                        onPrimary: Colors.white, // header text color
                        onSurface: primaryColor, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: primaryColor,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              ).then((value) {
                // return null;
                if (value != null) {
                  onChanged(DateTime(dateValue.year, dateValue.month, dateValue.day, value.hour, value.minute));
                }
              });
            } else {
              onChanged(dateValue);
            }
          });
        }
      },
      child: child,
    );
  }
}
