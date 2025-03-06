// import 'package:flutter/material.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'User Profile',
//             style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           _buildTextField(label: 'Name', hintText: 'First Name'),
//           const SizedBox(height: 10),
//           _buildTextField(hintText: 'Last Name'),
//           const SizedBox(height: 20),
//           _buildTextField(label: 'Email ID', hintText: 'Email Address'),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child:
//                     _buildTextField(label: 'Phone No', hintText: '***** *****'),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: _buildTextField(
//                     label: 'Date of Birth', hintText: 'dd/mm/yy'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _buildTextField(label: 'Residential Address', hintText: 'Address'),
//           const SizedBox(height: 20),
//           _buildTextField(label: 'Pincode', hintText: '*** ***'),
//           const SizedBox(height: 20),
//           _buildTextField(label: 'Department', hintText: 'Select'),
//           const SizedBox(height: 30),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                 backgroundColor: const Color(0xFF2A275F),
//               ),
//               child: const Text(
//                 'Save',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({String? label, required String hintText}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (label != null) ...[
//           Text(
//             label,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//           const SizedBox(height: 5),
//         ],
//         TextField(
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             hintText: hintText,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           ),
//         ),
//       ],
//     );
//   }
// }
