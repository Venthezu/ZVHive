import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('About', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://example.com/app_icon.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              'ZVHive',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Version ${_packageInfo.version} (${_packageInfo.buildNumber})',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your ultimate comic and anime community app. Read, watch, and connect with other fans.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _AboutButton(
              icon: Icons.email,
              text: 'Contact Support',
              onTap: () => _launchUrl('mailto:support@zvhive.com'),
            ),
            _AboutButton(
              icon: Icons.privacy_tip,
              text: 'Privacy Policy',
              onTap: () => _launchUrl('https://zvhive.com/privacy'),
            ),
            _AboutButton(
              icon: Icons.description,
              text: 'Terms of Service',
              onTap: () => _launchUrl('https://zvhive.com/terms'),
            ),
            const Spacer(),
            const Text(
              '© 2024 ZVHive. All rights reserved.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _AboutButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF12151B),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}