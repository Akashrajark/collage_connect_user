import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> exam;

  const ExamDetailsScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final bool hasResult = exam['exam_results'] != null && (exam['exam_results'] as List).isNotEmpty;
    final Map<String, dynamic>? result = hasResult ? (exam['exam_results'] as List).first : null;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Exam Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 20),
            _buildInfoCard(context),
            const SizedBox(height: 20),
            _buildSyllabusCard(context),
            const SizedBox(height: 20),
            if (hasResult) _buildResultCard(context, result!),
            if (!hasResult) _buildNoResultCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exam['subjects']?['name'] ?? 'Subject',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${exam['courses']?['name'] ?? 'Course'} • ${exam['type'] ?? 'Exam'}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final DateTime examDate = DateTime.parse(exam['date']);
    final String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(examDate);
    final String startTime = DateFormat('hh:mm a').format(DateTime.parse('2000-01-01 ${exam['start_time']}'));
    final String endTime = DateFormat('hh:mm a').format(DateTime.parse('2000-01-01 ${exam['end_time']}'));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.calendar_today, 'Date', formattedDate),
          const Divider(height: 32),
          _buildInfoRow(Icons.access_time, 'Time', '$startTime - $endTime'),
          const Divider(height: 32),
          _buildInfoRow(Icons.description_outlined, 'Description', exam['description'] ?? 'No description available'),
          const Divider(height: 32),
          _buildInfoRow(Icons.grade, 'Total Marks', '${exam['total_mark']}'),
        ],
      ),
    );
  }

  Widget _buildSyllabusCard(BuildContext context) {
    final String syllabus = exam['subjects']?['syllabus'] ?? 'Syllabus not available';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.book_outlined, color: Theme.of(context).primaryColor),
              const SizedBox(width: 10),
              const Text(
                'Syllabus',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            syllabus,
            style: TextStyle(
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, Map<String, dynamic> result) {
    final double marks = double.tryParse(result['mark'].toString()) ?? 0.0;
    final double totalMarks = double.tryParse(exam['total_mark'].toString()) ?? 100.0;
    final double percentage = (marks / totalMarks) * 100;
    final String note = result['note'] ?? '';

    // Calculate 10% of total marks
    final double tenPercent = totalMarks / 10;

    Color gradeColor;
    String grade;

    if (marks >= tenPercent * 9) {
      grade = 'A+';
      gradeColor = Colors.green;
    } else if (marks >= tenPercent * 8) {
      grade = 'A';
      gradeColor = Colors.green;
    } else if (marks >= tenPercent * 7) {
      grade = 'B';
      gradeColor = Colors.blue;
    } else if (marks >= tenPercent * 6) {
      grade = 'C';
      gradeColor = Colors.orange;
    } else if (marks >= tenPercent * 5) {
      grade = 'D';
      gradeColor = Colors.orange;
    } else {
      grade = 'F';
      gradeColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gradeColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: gradeColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Exam Result',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Marks',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${marks.toStringAsFixed(1)} / ${totalMarks.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey[300],
              ),
              Column(
                children: [
                  Text(
                    'Grade',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    grade,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: gradeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[100],
            color: gradeColor,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          if (note.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Note:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              note,
              style: TextStyle(
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoResultCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.hourglass_empty, size: 48, color: Colors.orange[300]),
          const SizedBox(height: 16),
          Text(
            'Result Pending',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The result for this exam has not been published yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange[800]?.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: Colors.grey[600]),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
