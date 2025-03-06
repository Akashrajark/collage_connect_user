// import 'package:college_connect_user/features/canteen/canteen.dart';
// import 'package:college_connect_user/features/events/events.dart';
// import 'package:college_connect_user/features/home_main/home_section.dart';
// import 'package:college_connect_user/profile_page.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:line_icons/line_icons.dart';

// import '../../theme/app_theme.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     HomeSection(),
//     CanteenSection(),
//     EventSection(),
//     ProfilePage()
//   ];

//   @override
//   void initState() {
//     // Future.delayed(
//     //     const Duration(
//     //       milliseconds: 200,
//     //     ), () {
//     //   User? currentUser = Supabase.instance.client.auth.currentUser;
//     //   if (currentUser == null ||
//     //       currentUser.appMetadata['role'] != 'architect') {
//     //     Navigator.of(context).pushReplacement(
//     //       MaterialPageRoute(
//     //         builder: (context) => SignInScreen(),
//     //       ),
//     //     );
//     //   }
//     // });
//     super.initState();
//   }

//   String titleChange(int index) {
//     switch (index) {
//       case 0:
//         return 'College Connect';
//       case 1:
//         return 'Canteen';
//       case 2:
//         return 'Events';
//       case 3:
//         return 'Profile';
//       default:
//         return 'College Connect';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: _selectedIndex != 3 ? false : true,
//       extendBody: _selectedIndex != 3 ? false : true,
//       appBar: _selectedIndex != 3
//           ? AppBar(
//               title: Text(
//                 titleChange(_selectedIndex),
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleLarge!
//                     .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//               backgroundColor: Colors.transparent,
//             )
//           : null,
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           _pages[_selectedIndex],
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 30,
//                 ),
//                 child: Material(
//                   color: Colors.black.withAlpha(150),
//                   borderRadius: BorderRadius.circular(64),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 10),
//                     child: GNav(
//                       rippleColor: Colors.grey[800]!,
//                       hoverColor: Colors.grey[700]!,
//                       haptic: true,
//                       tabBorderRadius: 25,
//                       tabActiveBorder:
//                           Border.all(color: onprimaryColor, width: 1),
//                       tabBorder: Border.all(color: Colors.grey, width: 1),
//                       tabShadow: [
//                         BoxShadow(
//                             color: Colors.grey.withAlpha(5), blurRadius: 8)
//                       ],
//                       curve: Curves.easeOutExpo,
//                       duration: const Duration(milliseconds: 200),
//                       gap: 8,
//                       color: Colors.grey,
//                       activeColor: Colors.white,
//                       iconSize: 24,
//                       tabBackgroundColor: Colors.black.withAlpha(0),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 12),
//                       selectedIndex: _selectedIndex,
//                       onTabChange: (index) {
//                         setState(() {
//                           _selectedIndex = index;
//                         });
//                       },
//                       tabs: const [
//                         GButton(
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.all(5),
//                           icon: LineIcons.home,
//                           text: 'Home',
//                         ),
//                         GButton(
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.all(5),
//                           icon: Icons.fastfood,
//                           text: 'Canteeen',
//                         ),
//                         GButton(
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.all(5),
//                           icon: LineIcons.calendar,
//                           text: 'Events',
//                         ),
//                         GButton(
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.all(5),
//                           icon: LineIcons.user,
//                           text: 'Profile',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
