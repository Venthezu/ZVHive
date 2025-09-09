import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/download_provider.dart';
import 'youtube_downloader.dart';
import 'tiktok_downloader.dart';
import 'instagram_downloader.dart';
import 'other_downloader.dart';

class DownloaderScreen extends StatefulWidget {
  const DownloaderScreen({super.key});

  @override
  State<DownloaderScreen> createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen> {
  int _selectedTab = 0;

  final List<Widget> _tabs = [
    const YouTubeDownloader(),
    const TikTokDownloader(),
    const InstagramDownloader(),
    const OtherDownloader(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Downloader', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Platform Tabs
          Container(
            color: const Color(0xFF12151B),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _PlatformTab(
                    icon: Icons.play_circle_fill,
                    label: 'YouTube',
                    isSelected: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                  _PlatformTab(
                    icon: Icons.music_note,
                    label: 'TikTok',
                    isSelected: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                  _PlatformTab(
                    icon: Icons.photo_camera,
                    label: 'Instagram',
                    isSelected: _selectedTab == 2,
                    onTap: () => setState(() => _selectedTab = 2),
                  ),
                  _PlatformTab(
                    icon: Icons.public,
                    label: 'Other',
                    isSelected: _selectedTab == 3,
                    onTap: () => setState(() => _selectedTab = 3),
                  ),
                ],
              ),
            ),
          ),
          
          // Selected Tab Content
          Expanded(
            child: _tabs[_selectedTab],
          ),
        ],
      ),
    );
  }
}

class _PlatformTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlatformTab({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF6D28D9) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF6D28D9) : Colors.grey, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF6D28D9) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}