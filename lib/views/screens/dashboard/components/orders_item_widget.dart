// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/instance_manager.dart';
// import 'package:prynzo_vendor_app/controllers/order_controller.dart';
// import 'package:prynzo_vendor_app/data/models/pusher_model/pusher_model.dart';
// import 'package:prynzo_vendor_app/services/extensions.dart';
// import 'package:prynzo_vendor_app/services/extra_methods.dart';
// import 'package:prynzo_vendor_app/views/base/custom_progress_indicator.dart';

// import '../../../../generated/assets.dart';
// import '../../../../services/extra_methods.dart';

// class OrdersItemWidget extends StatefulWidget {
//   final int orderRequestId;
//   final OrderRequestModel orderRequest;
//   final double width;
//   const OrdersItemWidget(
//       {super.key,
//       required this.orderRequest,
//       required this.orderRequestId,
//       required this.width});

//   @override
//   State<OrdersItemWidget> createState() => _OrdersItemWidgetState();
// }

// class _OrdersItemWidgetState extends State<OrdersItemWidget> {
//   bool orderAcceptLoading = false;
//   bool orderRejectLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(
//           color: const Color(0xFFD9D9D9),
//         ),
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     (widget.orderRequest.order?.orderId).getOrNa,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           fontSize: 11,
//                         ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         '${widget.orderRequest.order?.totalQuantity ?? 0} Items',
//                         style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                               fontWeight: FontWeight.w400,
//                             ),
//                       ),
//                       // if (widget.orderRequest.order?.deliveryType
//                       //         ?.toLowerCase() ==
//                       //     'urgent') ...[
//                       //   const Icon(Icons.bolt, color: Colors.orange, size: 18),
//                       //   const SizedBox(width: 2),
//                       // ],
//                       // Text(
//                       //   (widget.orderRequest.order?.deliveryType)
//                       //       .getOrNa
//                       //       .capitalizeFirstOfEach,
//                       //   style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                       //         fontWeight: FontWeight.w400,
//                       //       ),
//                       // )
//                     ],
//                   )
//                 ],
//               ),
//               const Spacer(),
//               InkWell(
//                 onTap: () async {
//                   setState(() {
//                     orderAcceptLoading = true;
//                   });
//                   await Get.find<OrderController>()
//                       .orderAccept(orderRequestId: widget.orderRequestId)
//                       .then((value) {
//                     Fluttertoast.showToast(msg: value.message);
//                   });
//                   setState(() {
//                     orderAcceptLoading = false;
//                   });
//                 },
//                 child: Ink(
//                   height: 40,
//                   width: 85,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF00A030),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Builder(builder: (context) {
//                     if (orderAcceptLoading) {
//                       return const FittedBox(
//                           child: CustomProgressIndicator(isMini: true));
//                     }

//                     return Text(
//                       'Accept',
//                       style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                             color: Colors.white,
//                           ),
//                       textAlign: TextAlign.center,
//                     );
//                   }),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               InkWell(
//                 onTap: () async {
//                   setState(() {
//                     orderRejectLoading = true;
//                   });
//                   await Get.find<OrderController>()
//                       .orderReject(orderRequestId: widget.orderRequestId)
//                       .then((value) {
//                     Fluttertoast.showToast(msg: value.message);
//                   });
//                   setState(() {
//                     orderRejectLoading = false;
//                   });
//                 },
//                 child: Ink(
//                   height: 40,
//                   width: 85,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF04343),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: Builder(builder: (context) {
//                     if (orderRejectLoading) {
//                       return const FittedBox(
//                           child: CustomProgressIndicator(isMini: true));
//                     }
//                     return Text(
//                       'Reject',
//                       style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                             color: Colors.white,
//                           ),
//                       textAlign: TextAlign.center,
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 5),
//           const Divider(color: Color(0xFFD9D9D9)),
//           const SizedBox(height: 5),
//           IconAndTitleValueWidget(
//             title: 'Services:',
//             icons: Assets.svgsHandshak,
//             value: (widget.orderRequest.order?.orderItems ?? [])
//                 .map((e) => (e.serviceData?.title).getOrNa)
//                 .join(', '),
//           ),
//           const SizedBox(height: 8),
//           IconAndTitleValueWidget(
//             title: 'Customer Name:',
//             icons: Assets.svgsContactIcon,
//             value:
//                 (widget.orderRequest.user?.name).getOrNa.capitalizeFirstOfEach,
//           ),
//           const SizedBox(height: 8),
//           const Divider(color: Color((0xFFD9D9D9))),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Delivery address: ',
//                 style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               // Text(
//               //   ExtraMethods.makeAddressString(
//               //       address: widget.orderRequest.order?.userAddressData),
//               //   style: Theme.of(context).textTheme.labelMedium!.copyWith(
//               //         color: const Color(0xFF09596F),
//               //         fontSize: 16,
//               //         fontWeight: FontWeight.w500,
//               //       ),
//               //   maxLines: 2,
//               //   overflow: TextOverflow.ellipsis,
//               // ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class IconAndTitleValueWidget extends StatelessWidget {
//   const IconAndTitleValueWidget({
//     super.key,
//     required this.title,
//     required this.icons,
//     required this.value,
//   });
//   final String title;
//   final String icons;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SvgPicture.asset(
//           width: 18,
//           height: 18,
//           icons,
//           fit: BoxFit.cover,
//         ),
//         const SizedBox(width: 5),
//         Text(
//           title,
//           style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//         ),
//         const SizedBox(width: 5),
//         Expanded(
//           child: Text(
//             value,
//             style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: const Color(0xFF09596F),
//                 ),
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     );
//   }
// }
