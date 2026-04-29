import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/event_record.dart';
import '../providers/app_providers.dart';
import '../presentation/providers/monitoring_provider.dart';

final eventsProvider = FutureProvider<List<EventRecord>>((ref) async {
  final session = ref.watch(appControllerProvider).valueOrNull?.session;
  if (session == null) {
    return const [];
  }
  return ref.read(dbclApiServiceProvider).fetchEvents(session.token);
});

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Events'),
              Tab(text: 'Penalties'),
              Tab(text: 'Recovery'),
            ],
          ),
        ),
        body: eventsAsync.when(
          data: (events) {
            final monitoringState = ref.watch(monitoringNotifierProvider);
            final now = DateTime.now();
            final liveEvents = monitoringState.liveEvents.map((e) {
              final type = e.when(
                hardBrakeDetected: (_) => 'hard_brake',
                fatigueDetected: (_, __) => 'fatigue',
                drowsyDetected: (_, __) => 'drowsiness',
                faceVerificationFailed: (_) => 'face_fail',
                alcoholDetected: (_) => 'alcohol',
                distractionDetected: (_) => 'distraction',
                recoveryBonus: (reason, _) => 'recovery_$reason',
              );
              return EventRecord(
                id: 'live-${now.millisecondsSinceEpoch}',
                type: type,
                duration: 1.0,
                points: type == 'drowsiness' ? -50 : -20,
                timestamp: now,
                isRecovery: false,
              );
            }).toList();

            final allEvents = [...liveEvents, ...events];
            final penaltyEvents = allEvents.where((e) => e.isPenalty).toList();
            final recoveryEvents = allEvents.where((e) => e.isRecovery).toList();
            final last7DayImages = penaltyEvents
                .where((e) => e.imageUrl != null && now.difference(e.timestamp).inDays < 7)
                .toList();

            return TabBarView(
              children: [
                _EventsList(events: allEvents, emptyMessage: 'No events yet.'),
                _PenaltyView(events: penaltyEvents, images: last7DayImages),
                _EventsList(events: recoveryEvents, emptyMessage: 'No recovery activity yet.'),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Failed to load events: $error')),
        ),
      ),
    );
  }
}

class _PenaltyView extends StatelessWidget {
  const _PenaltyView({
    required this.events,
    required this.images,
  });

  final List<EventRecord> events;
  final List<EventRecord> images;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Penalty events', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        if (events.isEmpty)
          const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No penalty events found.')))
        else
          ...events.map((event) => _EventTile(event: event)),
        const SizedBox(height: 20),
        Text('Last 7 days images', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        if (images.isEmpty)
          const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No server images for the last 7 days.')))
        else
          ...images.map(
            (event) => Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (event.imageUrl != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        event.imageUrl!,
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const SizedBox(
                          height: 160,
                          child: Center(child: Icon(Icons.broken_image_outlined)),
                        ),
                      ),
                    ),
                  ListTile(
                    leading: const Icon(Icons.image_outlined),
                    title: Text(event.type),
                    subtitle: Text(DateFormat.yMMMd().add_jm().format(event.timestamp)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _EventsList extends StatelessWidget {
  const _EventsList({
    required this.events,
    required this.emptyMessage,
  });

  final List<EventRecord> events;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) => _EventTile(event: events[index]),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final EventRecord event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(event.isRecovery ? Icons.trending_up : Icons.warning_amber_rounded),
        ),
        title: Text(event.type.replaceAll('_', ' ').toUpperCase()),
        subtitle: Text(DateFormat.yMMMd().add_jm().format(event.timestamp)),
        trailing: Text(
          '${event.points > 0 ? '+' : ''}${event.points}',
          style: TextStyle(color: event.points > 0 ? Colors.green : Colors.red),
        ),
      ),
    );
  }
}
