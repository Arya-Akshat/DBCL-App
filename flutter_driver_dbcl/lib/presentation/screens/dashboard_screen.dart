import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/scoring_rules.dart';
import '../providers/monitoring_provider.dart';
import '../widgets/camera_preview_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(monitoringNotifierProvider);
    final notifier = ref.read(monitoringNotifierProvider.notifier);
    final band = ScoringRules.getBand(state.score);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.driverId,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const Text(
                        "Driver-DBCL",
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _BandBadge(band: band),
                ],
              ),
              const SizedBox(height: 20),

              // Score Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    const Text(
                      "DBCL SCORE",
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 10,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${state.score}",
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "/ 1000",
                      style: TextStyle(color: AppColors.muted, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Camera Preview
              const DriverCameraPreview(),
              const SizedBox(height: 20),

              // Controls
              if (state.alertMessage.contains("No camera found"))
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    state.alertMessage,
                    style: const TextStyle(color: AppColors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: state.alertMessage.contains("No camera found")
                      ? null
                      : () {
                          if (state.isMonitoring) {
                            notifier.stopMonitoring();
                          } else {
                            notifier.startMonitoring();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isMonitoring ? AppColors.red : AppColors.green,
                    shape: roundedCornerShape(10),
                  ),
                  child: Text(
                    state.isMonitoring ? "STOP MONITORING" : "START MONITORING",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              const Text(
                "RECENT EVENTS",
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 9,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 10),
              
              // Placeholder for events
              Center(
                child: Text(
                  state.isMonitoring ? "Monitoring Active..." : "Start monitoring to see events",
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BandBadge extends StatelessWidget {
  final ScoreBand band;
  const _BandBadge({required this.band});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: band.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: band.color.withValues(alpha: 0.5)),
      ),
      child: Text(
        band.label,
        style: TextStyle(
          color: band.color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Helper for RoundedCornerShape which is from Material
RoundedRectangleBorder roundedCornerShape(double r) =>
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(r));
