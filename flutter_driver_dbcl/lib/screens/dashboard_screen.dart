import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/scoring_rules.dart';
import '../core/theme/app_colors.dart';
import '../presentation/providers/monitoring_provider.dart';
import '../providers/app_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appControllerProvider).valueOrNull;
    final user = appState?.currentUser;
    final monitoringState = ref.watch(monitoringNotifierProvider);
    final monitoringNotifier = ref.read(monitoringNotifierProvider.notifier);

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

    final score = monitoringState.score;
    final band = ScoringRules.getBand(score);

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.name ?? 'Driver Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                user?.userId ?? 'DBCL',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ========== CAMERA ACTIVE BANNER ==========
          if (monitoringState.isMonitoring)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF4560), Color(0xFFFF7A30)],
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    '🔴 Camera Active — Monitoring in progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

          // ========== MAIN CONTENT ==========
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // ========== SCORE CARD ==========
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Score Ring
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      value: score / ScoringRules.maxScore,
                                      strokeWidth: 6,
                                      backgroundColor: AppColors.border,
                                      valueColor: AlwaysStoppedAnimation<Color>(band.color),
                                    ),
                                  ),
                                  Text(
                                    '$score',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: band.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Driver Score', style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: band.color.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${band.emoji} ${band.label}',
                                      style: TextStyle(color: band.color, fontWeight: FontWeight.w600, fontSize: 13),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'out of ${ScoringRules.maxScore}',
                                    style: const TextStyle(color: AppColors.muted, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ========== MONITORING CONTROL ==========
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Monitoring', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(
                          monitoringState.alertMessage.isNotEmpty
                              ? monitoringState.alertMessage
                              : 'Tap below to start real-time safety monitoring.',
                          style: const TextStyle(color: AppColors.muted, fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: monitoringState.isEmulator
                                ? null
                                : () {
                                    if (monitoringState.isMonitoring) {
                                      monitoringNotifier.stopMonitoring();
                                    } else {
                                      monitoringNotifier.startMonitoring();
                                    }
                                  },
                            icon: Icon(monitoringState.isMonitoring ? Icons.stop : Icons.play_arrow),
                            label: Text(monitoringState.isMonitoring ? 'Stop Monitoring' : 'Start Monitoring'),
                            style: FilledButton.styleFrom(
                              backgroundColor: monitoringState.isMonitoring ? AppColors.red : AppColors.accent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ========== LIVE METRICS (only while monitoring) ==========
                if (monitoringState.isMonitoring) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Live AI Metrics', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _MetricTile(
                                  label: 'EAR Score',
                                  value: monitoringState.currentEar.toStringAsFixed(3),
                                  icon: Icons.visibility,
                                  color: monitoringState.currentEar < ScoringRules.earThreshold
                                      ? AppColors.red
                                      : AppColors.green,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _MetricTile(
                                  label: 'Face Visible',
                                  value: monitoringState.faceVisible ? 'YES' : 'NO',
                                  icon: Icons.face,
                                  color: monitoringState.faceVisible ? AppColors.green : AppColors.yellow,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _MetricTile(
                                  label: 'Drowsy',
                                  value: monitoringState.isDrowsy ? 'ALERT' : 'OK',
                                  icon: Icons.airline_seat_recline_normal,
                                  color: monitoringState.isDrowsy ? AppColors.red : AppColors.green,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _MetricTile(
                                  label: 'Distracted',
                                  value: monitoringState.isDistracted ? 'ALERT' : 'OK',
                                  icon: Icons.phone_in_talk,
                                  color: monitoringState.isDistracted ? AppColors.red : AppColors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // ========== RECENT EVENTS ==========
                if (monitoringState.liveEvents.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recent Events (${monitoringState.liveEvents.length})',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 12),
                          ...monitoringState.liveEvents.take(5).map((event) {
                            final type = event.when(
                              hardBrakeDetected: (_) => 'Hard Brake',
                              fatigueDetected: (_, __) => 'Fatigue',
                              drowsyDetected: (_, __) => 'Drowsiness',
                              faceVerificationFailed: (_) => 'Face Fail',
                              alcoholDetected: (_) => 'Alcohol',
                              distractionDetected: (_) => 'Distraction',
                              recoveryBonus: (reason, _) => 'Recovery: $reason',
                            );
                            final isWarning = type == 'Drowsiness' || type == 'Distraction';
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    isWarning ? Icons.warning_amber_rounded : Icons.info_outline,
                                    color: isWarning ? AppColors.red : AppColors.yellow,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(type, style: const TextStyle(color: AppColors.text)),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(color: AppColors.muted, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
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
