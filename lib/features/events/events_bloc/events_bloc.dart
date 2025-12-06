import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../values/strings.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitialState()) {
    on<EventsEvent>((event, emit) async {
      try {
        emit(EventsLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;

        SupabaseQueryBuilder table = Supabase.instance.client.from('events');
        SupabaseQueryBuilder registrationsTable = Supabase.instance.client.from('event_registrations');

        if (event is GetAllEventsEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query = table
              .select('*,event_registrations(*)')
              .eq('collage_user_id', supabaseClient.auth.currentUser!.appMetadata['collage_user_id']);

          if (event.params['query'] != null) {
            query = query.ilike('title', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> events = await query.order('event_date', ascending: true);

          emit(EventsGetSuccessState(events: events));
        } else if (event is RegisterForEventEvent) {
          await registrationsTable.insert({
            'event_id': event.eventId,
            'student_user_id': supabaseClient.auth.currentUser!.id,
            'note': event.note,
          });
          emit(EventsSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(EventsFailureState());
      }
    });
  }
}
