import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/driving_event.dart';
import '../../providers/app_providers.dart';
import '../../models/event_record.dart';

class EventsHistoryScreen extends ConsumerWidget {
  const EventsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.panel,
        title: const Text("Safety Events", style: TextStyle(color: AppColors.text, fontSize: 18)),
        elevation: 0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final session = ref.watch(appControllerProvider).valueOrNull?.session;
          if (session == null) return const Center(child: Text("Please login to see history"));

          return FutureBuilder<List<EventRecord>>(
            future: ref.watch(dbclApiServiceProvider).fetchEvents(session.token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No events recorded yet", style: TextStyle(color: AppColors.muted)),
                );
              }

              final events = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return _EventCard(event: event);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventRecord event;
  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.red.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.warning_amber_rounded, color: AppColors.red, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.type.replaceAll('_', ' '),
                  style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(event.timestamp * 1000).toString(),
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Text("${event.points} pts", style: TextStyle(color: event.points < 0 ? AppColors.red : AppColors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
