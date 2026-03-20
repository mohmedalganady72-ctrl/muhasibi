// class _TableHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final List<String> culomen;

//   _TableHeaderDelegate(this.culomen);

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.white,
//       child: Table(
//         border: TableBorder.symmetric(
//           outside: BorderSide(color: Colors.grey.shade300),
//         ),
//         children: [
//           TableRow(
//             decoration: BoxDecoration(color: Colors.blue.shade100),
//             children: culomen
//                 .map((c) => Padding(
//                       padding: const EdgeInsets.all(12), // زودنا البادينغ شوي
//                       child: Text(
//                         c,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   /// نخلي minExtent و maxExtent متساوية
//   @override
//   double get maxExtent => kToolbarHeight; // أو أي قيمة تناسب البادينغ + النص
//   @override
//   double get minExtent => kToolbarHeight;

//   @override
//   bool shouldRebuild(covariant _TableHeaderDelegate oldDelegate) {
//     return oldDelegate.culomen != culomen;
//   }
// }