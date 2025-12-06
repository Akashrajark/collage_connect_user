import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../values/strings.dart';

part 'exams_event.dart';
part 'exams_state.dart';

class ExamsBloc extends Bloc<ExamsEvent, ExamsState> {
  ExamsBloc() : super(ExamsInitialState()) {
    on<ExamsEvent>((event, emit) async {
      try {
        emit(ExamsLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;

        SupabaseQueryBuilder table = Supabase.instance.client.from('exams');
        if (event is GetAllExamsEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query = table
              .select('*,courses(name),subjects(*),exam_results(*)')
              .eq('collage_user_id', supabaseClient.auth.currentUser!.appMetadata['collage_user_id'])
              .eq('exam_results.student_user_id', supabaseClient.auth.currentUser!.id);

          if (event.params['query'] != null) {
            query = query.ilike('type', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> exams = await query.order('id', ascending: true);

          emit(ExamsGetSuccessState(exams: exams));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ExamsFailureState());
      }
    });
  }
}
