import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.panel,
                child: Icon(Icons.person_rounded, color: AppColors.accent, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Driver Profile",
              style: TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "ID: GENERATED AFTER SIGNUP",
              style: TextStyle(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 40),
            
            _ProfileItem(icon: Icons.face_retouching_natural, title: "Face Verification", status: "VERIFIED", statusColor: AppColors.green),
            _ProfileItem(icon: Icons.security, title: "Biometric Login", status: "ENABLED", statusColor: AppColors.green),
            _ProfileItem(icon: Icons.notifications_none_rounded, title: "Alert Volume", status: "80%", statusColor: AppColors.accent),
            _ProfileItem(icon: Icons.info_outline_rounded, title: "App Version", status: "1.0.0", statusColor: AppColors.muted),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("LOGOUT", style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String status;
  final Color statusColor;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.muted, size: 24),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}
