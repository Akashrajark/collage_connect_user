// import 'package:flutter/material.dart';

// class HomeSection extends StatefulWidget {
//   const HomeSection({super.key});

//   @override
//   State<HomeSection> createState() => _HomeSectionState();
// }

// class _HomeSectionState extends State<HomeSection> {
//   final List<String> eventImages = [
//     'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8cGFydHl8ZW58MHx8MHx8fDA%3D',
//     'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3BvcnRzfGVufDB8fDB8fHww',
//   ];

//   final List<Map<String, String>> canteenMenu = [
//     {
//       'name': 'Burger',
//       'price': '\$5',
//       'image':
//           'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=1998&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
//     },
//     {
//       'name': 'Pizza',
//       'price': '\$8',
//       'image':
//           'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D'
//     },
//     {
//       'name': 'Pasta',
//       'price': '\$7',
//       'image':
//           'https://plus.unsplash.com/premium_photo-1664472619078-9db415ebef44?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
//     },
//     {
//       'name': 'Sandwich',
//       'price': '\$4',
//       'image':
//           'https://images.unsplash.com/photo-1619860860774-1e2e17343432?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2FuZHdpdGNofGVufDB8fDB8fHww'
//     },
//     {
//       'name': 'Coffee',
//       'price': '\$3',
//       'image':
//           'https://images.unsplash.com/photo-1559496417-e7f25cb247f3?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGNvZmZlZXxlbnwwfHwwfHx8MA%3D%3D'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Upcoming Events',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 180,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: eventImages.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.only(right: 10),
//                   width: 250,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     image: DecorationImage(
//                       image: NetworkImage(eventImages[index]),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: Text(
//                         'Name of Event',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Canteen Menu',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: canteenMenu.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(
//                             canteenMenu[index]['image']!,
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 canteenMenu[index]['name']!,
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 canteenMenu[index]['price']!,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.add_shopping_cart,
//                               color: Colors.blueAccent),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
