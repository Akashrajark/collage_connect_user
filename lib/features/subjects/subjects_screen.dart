import 'package:college_connect_user/features/subjects/subjects_bloc/subjects_bloc.dart';
import 'package:college_connect_user/features/subjects/subject_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common_widgets.dart/custom_alert_dialog.dart';

class SubjectsScreen extends StatefulWidget {
  final int courseId;
  const SubjectsScreen({super.key, required this.courseId});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final SubjectsBloc _subjectsBloc = SubjectsBloc();

  @override
  void initState() {
    super.initState();
    getSubjects();
  }

  void getSubjects() {
    _subjectsBloc.add(GetAllSubjectsEvent(params: {'course_id': widget.courseId}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _subjectsBloc,
      child: BlocConsumer<SubjectsBloc, SubjectsState>(
        listener: (context, state) {
          if (state is SubjectsFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getSubjects();
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[50],
            body: state is SubjectsLoadingState
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar.large(
                        title: const Text('Subjects'),
                        centerTitle: false,
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        expandedHeight: 120,
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      if (state is SubjectsGetSuccessState)
                        state.subjects.isEmpty
                            ? SliverFillRemaining(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.book_outlined, size: 80, color: Colors.grey[300]),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No subjects found',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SliverPadding(
                                padding: const EdgeInsets.all(20),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final subject = state.subjects[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => SubjectDetailScreen(
                                                    subject: subject,
                                                  ),
                                                ),
                                              );
                                            },
                                            borderRadius: BorderRadius.circular(20),
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.03),
                                                    blurRadius: 15,
                                                    offset: const Offset(0, 5),
                                                  ),
                                                ],
                                                border: Border.all(color: Colors.grey.shade100),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(12),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    child: Icon(
                                                      Icons.menu_book_rounded,
                                                      color: Theme.of(context).primaryColor,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Text(
                                                      subject['name'],
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios_rounded,
                                                    size: 16,
                                                    color: Colors.grey[400],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: state.subjects.length,
                                  ),
                                ),
                              ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
