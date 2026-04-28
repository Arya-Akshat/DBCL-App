import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_profile.dart';
import '../providers/app_providers.dart';
import '../widgets/dbcl_text_field.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _phoneController = TextEditingController();
  final _emergencyController = TextEditingController();
  String? _profilePhotoPath;
  bool _initialized = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emergencyController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image == null) {
      return;
    }
    setState(() => _profilePhotoPath = image.path);
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appControllerProvider).valueOrNull;
    final user = appState?.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_initialized) {
      _phoneController.text = user.phone;
      _emergencyController.text = user.emergencyContact;
      _profilePhotoPath = user.profilePhotoPath;
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickPhoto,
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: _profilePhotoPath == null ? null : FileImage(File(_profilePhotoPath!)),
                    child: _profilePhotoPath == null ? const Icon(Icons.person, size: 36) : null,
                  ),
                ),
                const SizedBox(height: 12),
                Text(user.name, style: Theme.of(context).textTheme.titleLarge),
                Text('UserID: ${user.userId}'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          DbclTextField(
            controller: _phoneController,
            label: 'Phone',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          DbclTextField(
            controller: _emergencyController,
            label: 'Emergency Contact',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            value: appState?.themeMode == ThemeMode.dark,
            onChanged: (_) => ref.read(appControllerProvider.notifier).toggleTheme(),
            title: const Text('Dark theme'),
          ),
          SwitchListTile(
            value: appState?.biometricEnabled ?? false,
            onChanged: (value) async {
              final messenger = ScaffoldMessenger.of(context);
              final ok = await ref.read(appControllerProvider.notifier).toggleBiometric(value);
              if (!ok && mounted) {
                messenger.showSnackBar(
                  const SnackBar(content: Text('Biometric login is available only after successful login on a supported device.')),
                );
              }
            },
            title: const Text('Enable biometric login'),
            subtitle: const Text('Email login remains available as fallback.'),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final updated = _buildUpdatedUser(user);
                await ref.read(appControllerProvider.notifier).updateProfile(updated);
                if (!mounted) {
                  return;
                }
                messenger.showSnackBar(
                  const SnackBar(content: Text('Profile updated.')),
                );
              },
              child: const Text('Save Profile'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => ref.read(appControllerProvider.notifier).logout(),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  UserProfile _buildUpdatedUser(UserProfile current) {
    return current.copyWith(
      phone: _phoneController.text.trim(),
      emergencyContact: _emergencyController.text.trim(),
      profilePhotoPath: _profilePhotoPath,
    );
  }
}
