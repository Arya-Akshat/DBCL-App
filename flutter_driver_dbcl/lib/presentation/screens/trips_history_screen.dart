import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import '../../models/trip_record.dart';

class TripsHistoryScreen extends ConsumerWidget {
  const TripsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.panel,
        title: const Text("Trip History", style: TextStyle(color: AppColors.text, fontSize: 18)),
        elevation: 0,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final session = ref.watch(appControllerProvider).valueOrNull?.session;
          if (session == null) return const Center(child: Text("Please login to see history"));

          return FutureBuilder<List<TripRecord>>(
            future: ref.watch(dbclApiServiceProvider).fetchTrips(session.token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No trips completed yet", style: TextStyle(color: AppColors.muted)),
                );
              }

              final trips = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return _TripCard(trip: trip);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final TripRecord trip;
  const _TripCard({required this.trip});

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trip.startTime, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text("${trip.score} Score", style: const TextStyle(color: AppColors.green, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _TripStat(label: "END TIME", value: trip.endTime),
              const SizedBox(width: 24),
              _TripStat(label: "EVENTS", value: trip.eventsCount.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class _TripStat extends StatelessWidget {
  final String label;
  final String value;
  const _TripStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 10, letterSpacing: 1)),
        Text(value, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
