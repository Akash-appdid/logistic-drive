import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logistic_driver/views/base/custom_image.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Booking',
      'rating': 2.0,
      'date': '09: 20 AM',
      'description': 'You have received a new booking',
      'image':
          'https://s3-alpha-sig.figma.com/img/2ef6/4353/456ee2f99196f8f6d9ca57df775557ce?Expires=1743984000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=OSFjQDcDaEcN8DG6bQiqNWZlZS~PraQmg0gQ5rCQQeCL0PXg3YpfC7ufbB6DBeahX9JpFkxUqXxdwSJKhuKt2zQ3jKLnwsOYDRpG2OsXXY~jneQ0NyJUauvZ~ndzRynjVCH57MJI~XUzhZxqX6eOyNFrBKbhk~RJSKHpX60AOYVIZpL6t2Ijkb1g5uZc-WXmbUVfpSWzkIGLZEh98AlqzUcd7hncZ4A4PTS34pGfjpCzSxuzyD8WxoumWKxZ18guFSa4wfhvi8RFh35G9IoHgM4ynckVDKu6UBOX0tFwVWgKJXKe1ClZy8wf7mt39YKuP~F6mT-X2NC2eqOT-j-KCw__',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomImage(
                              path: notification['image'],
                              radius: 6,
                              height: 40,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification['title']!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notification['description'].toString(),
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: -4,
                        right: -4,
                        child: Text(
                          notification['date'],
                          style: const TextStyle(fontSize: 12),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
