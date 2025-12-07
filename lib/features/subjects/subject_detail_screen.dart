import 'package:flutter/material.dart';

class SubjectDetailScreen extends StatelessWidget {
  final Map<String, dynamic> subject;

  const SubjectDetailScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            title: Text(
              subject['name'] ?? 'Subject Details',
              style: const TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            expandedHeight: 120,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (subject['description'] != null && subject['description'].isNotEmpty)
                  _buildSection(
                    context,
                    title: 'Description',
                    content: subject['description'],
                    icon: Icons.info_outline_rounded,
                  ),
                if (subject['syllabus'] != null && subject['syllabus'].isNotEmpty) ...[
                  const SizedBox(height: 20),
                  _buildSection(
                    context,
                    title: 'Syllabus',
                    content: subject['syllabus'],
                    icon: Icons.import_contacts_rounded,
                    isLongText: true,
                  ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    required IconData icon,
    bool isLongText = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
