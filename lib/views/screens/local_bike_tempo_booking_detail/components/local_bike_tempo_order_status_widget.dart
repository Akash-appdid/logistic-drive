// class LocalBikeTempoOrderStatusWidget extends StatelessWidget {
//   const LocalBikeTempoOrderStatusWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LocalBikeTempoController>(builder: (controller) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//         decoration: BoxDecoration(
//           color: formatSentence(
//                       controller.localBikeTempoBookingData?.deliveryStatus ??
//                           'NA') ==
//                   'delay'
//               ? Colors.red
//               : const Color(0xFF0F8000),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Row(
//                 children: [
//                   Text(
//                     '- - - - - - - - - - - - - - - - - - - - - - - - -',
//                     style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                           color: Colors.white,
//                         ),
//                   ),
//                   const SizedBox(width: 4),
//                   SvgPicture.asset(
//                     Assets.imagesDeliveryTruck,
//                     colorFilter:
//                         const ColorFilter.mode(Colors.white, BlendMode.srcIn),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               formatSentence(
//                   controller.localBikeTempoBookingData?.deliveryStatus ?? 'NA'),
//               style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
