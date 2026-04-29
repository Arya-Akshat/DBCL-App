import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../models/score_summary.dart';
import '../presentation/providers/monitoring_provider.dart';
import '../providers/app_providers.dart';
import '../widgets/status_card.dart';

final scoreSummaryProvider = FutureProvider<ScoreSummary>((ref) async {
  final session = ref.watch(appControllerProvider).valueOrNull?.session;
  if (session == null) {
    return const ScoreSummary(score: 82, ranking: 'Professional');
  }
  return ref.read(dbclApiServiceProvider).fetchScore(session.token);
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appControllerProvider).valueOrNull;
    final user = appState?.currentUser;
    final monitoringState = ref.watch(monitoringNotifierProvider);
    final monitoringNotifier = ref.read(monitoringNotifierProvider.notifier);
    final scoreAsync = ref.watch(scoreSummaryProvider);

    // Show SnackBar when alertMessage changes
    ref.listen(monitoringNotifierProvider, (previous, next) {
      if (next.alertMessage.isNotEmpty && next.alertMessage != previous?.alertMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.alertMessage),
            backgroundColor: next.alertMessage.contains("failed") || next.alertMessage.contains("required") 
              ? AppColors.red 
              : AppColors.accent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    // Show Session Summary Dialog
    ref.listen(monitoringNotifierProvider, (previous, next) {
      if (next.sessionSummary != null && previous?.sessionSummary == null) {
        final summary = next.sessionSummary!;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.card,
            title: const Text("Trip Summary", style: TextStyle(color: AppColors.text)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SummaryRow(label: "Duration", value: "${summary['duration']}s"),
                _SummaryRow(label: "Safety Events", value: "${summary['events']}"),
                _SummaryRow(label: "Final Score", value: "${summary['score']}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CLOSE", style: TextStyle(color: AppColors.accent)),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.name ?? 'Driver Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                user?.userId ?? 'DBCL',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          scoreAsync.when(
            data: (score) => Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Driver Score', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 12),
                    Text('${score.score}', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _RankingChip(label: score.ranking),
                  ],
                ),
              ),
            ),
            loading: () => const Card(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())),
            error: (error, stackTrace) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          StatusCard(
            title: 'Start Monitoring',
            subtitle: monitoringState.alertMessage.isNotEmpty
                ? monitoringState.alertMessage
                : 'Camera, location, and sensors are requested only when monitoring starts.',
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: monitoringState.isEmulator
                    ? null
                    : () {
                        if (monitoringState.isMonitoring) {
                          monitoringNotifier.stopMonitoring();
                        } else {
                          monitoringNotifier.startMonitoring();
                        }
                      },
                style: FilledButton.styleFrom(
                  backgroundColor: monitoringState.isMonitoring ? AppColors.red : AppColors.accent,
                  foregroundColor: Colors.black,
                ),
                child: Text(monitoringState.isMonitoring ? 'Stop Monitoring' : 'Start Monitoring'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(child: _QuickLink(icon: Icons.event_note, label: 'Events')),
              SizedBox(width: 12),
              Expanded(child: _QuickLink(icon: Icons.route, label: 'Trips')),
              SizedBox(width: 12),
              Expanded(child: _QuickLink(icon: Icons.person, label: 'Profile')),
            ],
          ),
        ],
      ),
    );
  }
}

class _RankingChip extends StatelessWidget {
  const _RankingChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('Ranking: $label'),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted)),
          Text(value, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
