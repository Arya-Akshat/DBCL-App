import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/trip_record.dart';
import '../providers/app_providers.dart';

final tripsProvider = FutureProvider<List<TripRecord>>((ref) async {
  final session = ref.watch(appControllerProvider).valueOrNull?.session;
  if (session == null) {
    return const [];
  }
  return ref.read(dbclApiServiceProvider).fetchTrips(session.token);
});

class TripsScreen extends ConsumerWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(tripsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Trips')),
      body: tripsAsync.when(
        data: (trips) {
          if (trips.isEmpty) {
            return const Center(child: Text('No trips completed yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(DateFormat.yMMMd().add_jm().format(trip.startTime)),
                  subtitle: Text(
                    'End: ${DateFormat.jm().format(trip.endTime)} • Events: ${trip.eventsCount}',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Score ${trip.score}'),
                      Text('${trip.duration.inMinutes} min'),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load trips: $error')),
      ),
    );
  }
}
