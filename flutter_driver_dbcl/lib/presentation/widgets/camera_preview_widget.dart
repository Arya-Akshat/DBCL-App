import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../providers/monitoring_provider.dart';

class DriverCameraPreview extends ConsumerWidget {
  const DriverCameraPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(monitoringNotifierProvider);
    // Note: In a cleaner architecture, we'd expose the controller in state.
    // For now, I'll assume the notifier handles the global controller.
    
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
      child: !state.isMonitoring || state.controller == null
          ? const Center(child: Text("Camera Feed Inactive", style: TextStyle(color: AppColors.muted)))
          : CameraPreview(state.controller!),
      ),
    );
  }
}
