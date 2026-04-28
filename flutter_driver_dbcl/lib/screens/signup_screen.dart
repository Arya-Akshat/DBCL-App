import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/app_providers.dart';
import '../widgets/dbcl_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _licenseImagePath;
  String? _profileImagePath;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool license) async {
    final image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image == null) {
      return;
    }
    setState(() {
      if (license) {
        _licenseImagePath = image.path;
      } else {
        _profileImagePath = image.path;
      }
    });
  }

  Future<void> _submit() async {
    if (_licenseImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Driving license image is required.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await ref.read(appControllerProvider.notifier).signup(
            name: _nameController.text.trim(),
            phone: _phoneController.text.trim(),
            address: _addressController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            licenseImagePath: _licenseImagePath,
            profilePhotoPath: _profileImagePath,
          );
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DbclTextField(controller: _nameController, label: 'Name'),
            const SizedBox(height: 16),
            DbclTextField(
              controller: _phoneController,
              label: 'Phone',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            DbclTextField(controller: _addressController, label: 'Address', maxLines: 2),
            const SizedBox(height: 16),
            DbclTextField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            DbclTextField(controller: _passwordController, label: 'Password', obscureText: true),
            const SizedBox(height: 20),
            _UploadTile(
              title: 'Driving License',
              subtitle: 'Required',
              filePath: _licenseImagePath,
              onTap: () => _pickImage(true),
            ),
            const SizedBox(height: 12),
            _UploadTile(
              title: 'Profile Photo',
              subtitle: 'Optional',
              filePath: _profileImagePath,
              onTap: () => _pickImage(false),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSubmitting ? null : _submit,
                child: Text(_isSubmitting ? 'Creating Account...' : 'Signup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UploadTile extends StatelessWidget {
  const _UploadTile({
    required this.title,
    required this.subtitle,
    required this.filePath,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String? filePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: filePath == null
            ? const CircleAvatar(child: Icon(Icons.upload_file))
            : CircleAvatar(
                backgroundImage: FileImage(File(filePath!)),
              ),
        title: Text(title),
        subtitle: Text(filePath ?? subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
