import 'package:college_connect_user/features/login/loginscreen.dart';
import 'package:college_connect_user/features/subjects/subjects_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../common_widgets.dart/change_password.dart';
import '../../common_widgets.dart/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import 'profile_bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();
  Map _profile = {};

  @override
  void initState() {
    getProfile();
    checkLogin(context);
    super.initState();
  }

  void getProfile() {
    _profileBloc.add(GetAllProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileBloc,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getProfile();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is ProfileGetSuccessState) {
            _profile = state.profile;
            setState(() {});
          } else if (state is ProfileSuccessState) {
            getProfile();
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Scaffold(
            backgroundColor: Colors.grey[50],
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 60),
                  _buildProfileInfo(context),
                  const SizedBox(height: 20),
                  _buildActions(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: _profile['image_url'] != null ? NetworkImage(_profile['image_url']) : null,
              child: _profile['image_url'] == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    final courseName = _profile['courses'] != null ? _profile['courses']['name'] : 'N/A';
    final dob = _profile['dob'] != null ? _formatDate(_profile['dob']) : 'N/A';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            _profile['name'] ?? 'Student Name',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _profile['email'] ?? 'email@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoRow(Icons.badge_outlined, 'Reg No', _profile['reg_no'] ?? 'N/A'),
                _buildDivider(),
                _buildInfoRow(Icons.school_outlined, 'Course', courseName),
                _buildDivider(),
                _buildInfoRow(Icons.cake_outlined, 'Date of Birth', dob),
                _buildDivider(),
                _buildInfoRow(Icons.person_outline, 'Gender', _profile['gender'] ?? 'N/A'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isSmall = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isSmall ? 12 : 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[100], height: 1);
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildActionButton(
            context,
            'Subjects',
            Icons.book_outlined,
            () {
              if (_profile['course_id'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectsScreen(
                      courseId: _profile['course_id'],
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course not assigned')),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            context,
            'Change Password',
            Icons.lock_outline,
            () {
              showDialog(
                context: context,
                builder: (context) => const ChangePasswordDialog(),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            context,
            'Sign Out',
            Icons.logout,
            () {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: "SIGN OUT",
                  content: const Text(
                    "Are you sure you want to Sign Out? Clicking 'Sign Out' will end your current session.",
                  ),
                  primaryButton: "SIGN OUT",
                  onPrimaryPressed: () {
                    Supabase.instance.client.auth.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Loginscreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              );
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed, {
    bool isDestructive = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDestructive ? Colors.red[50] : Colors.white,
          foregroundColor: isDestructive ? Colors.red : Colors.black87,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isDestructive ? Colors.red.withOpacity(0.2) : Colors.grey[300]!,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
