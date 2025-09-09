import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import 'profile_edit_screen.dart';
import 'about_screen.dart';
import 'bug_report_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Card(
            color: const Color(0xFF12151B),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
              ),
              title: Text(
                authProvider.user?.email ?? 'User',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                'View and edit your profile',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileEditScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Settings Options
          _SettingsSection(
            title: 'Account',
            children: [
              _SettingsItem(
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.security,
                title: 'Privacy & Security',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.language,
                title: 'Language',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          _SettingsSection(
            title: 'Support',
            children: [
              _SettingsItem(
                icon: Icons.help,
                title: 'Help & Support',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.bug_report,
                title: 'Report a Bug',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BugReportScreen()),
                  );
                },
              ),
              _SettingsItem(
                icon: Icons.info,
                title: 'About',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Logout Button
          ElevatedButton(
            onPressed: () {
              authProvider.signOut();
              // Navigate to login screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[900],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          color: const Color(0xFF12151B),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}