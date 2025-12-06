import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets.dart/custom_search.dart';
import 'event_details_screen.dart';
import 'events_bloc/events_bloc.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  Map<String, dynamic> params = {
    'query': null,
  };
  final EventsBloc _eventBloc = EventsBloc();

  @override
  initState() {
    getAllEvents();
    super.initState();
  }

  void getAllEvents() {
    _eventBloc.add(GetAllEventsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventsBloc>.value(
      value: _eventBloc,
      child: BlocConsumer<EventsBloc, EventsState>(
        listener: (context, eventsState) {
          if (eventsState is EventsFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load Event, Try Again!'),
              ),
            );
          }
        },
        builder: (context, eventsState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: CustomSearch(
                  onSearch: (sp) {
                    params['query'] = sp;
                    getAllEvents();
                  },
                ),
              ),
              if (eventsState is EventsLoadingState)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (eventsState is EventsGetSuccessState)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: eventsState.events.length,
                    itemBuilder: (context, index) {
                      final store = eventsState.events[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailsScreen(event: store),
                              ),
                            ).then((value) {
                              getAllEvents();
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                                    child: Image.network(
                                      store['image_url']!,
                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  if (store['event_registrations']?.isNotEmpty == true)
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Chip(
                                        side: BorderSide.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        label: Text(
                                          'Registered',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  store['title']!,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
