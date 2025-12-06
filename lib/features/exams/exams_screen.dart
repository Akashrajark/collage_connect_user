import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'exam_details_screen.dart';
import 'exams_bloc/exams_bloc.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({super.key});

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  final ExamsBloc _examsBloc = ExamsBloc();
  Map<String, dynamic> params = {'query': null};

  @override
  void initState() {
    super.initState();
    _getExams();
  }

  void _getExams() {
    _examsBloc.add(GetAllExamsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _examsBloc,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ExamsBloc, ExamsState>(
                builder: (context, state) {
                  if (state is ExamsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExamsGetSuccessState) {
                    if (state.exams.isEmpty) {
                      return const Center(child: Text('No exams found'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.exams.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final exam = state.exams[index];
                        return _buildExamCard(context, exam);
                      },
                    );
                  } else if (state is ExamsFailureState) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(BuildContext context, Map<String, dynamic> exam) {
    final bool hasResult = exam['exam_results'] != null && (exam['exam_results'] as List).isNotEmpty;
    final String subjectName = exam['subjects']?['name'] ?? 'Unknown Subject';
    final String courseName = exam['courses']?['name'] ?? 'Unknown Course';
    final String examType = exam['type'] ?? 'Exam';
    final DateTime examDate = DateTime.parse(exam['date']);
    final String formattedDate = DateFormat('dd MMM yyyy').format(examDate);
    final String startTime = DateFormat('hh:mm a').format(DateTime.parse('2000-01-01 ${exam['start_time']}'));
    final String endTime = DateFormat('hh:mm a').format(DateTime.parse('2000-01-01 ${exam['end_time']}'));
    final String formattedTime = '$startTime - $endTime';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExamDetailsScreen(exam: exam),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subjectName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$courseName • $examType',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: hasResult ? Colors.green[50] : Colors.orange[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: hasResult ? Colors.green : Colors.orange,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      hasResult ? 'Result Out' : 'Scheduled',
                      style: TextStyle(
                        color: hasResult ? Colors.green[700] : Colors.orange[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    formattedDate,
                    style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    formattedTime,
                    style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
