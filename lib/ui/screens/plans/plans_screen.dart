import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void _contactDeveloper() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF12151B),
        title: const Text('Contact Developer', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Choose your preferred contact method:',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => _launchUrl('https://t.me/your_telegram'),
            child: const Text('Telegram', style: TextStyle(color: Color(0xFF6D28D9))),
          ),
          TextButton(
            onPressed: () => _launchUrl('https://wa.me/your_whatsapp'),
            child: const Text('WhatsApp', style: TextStyle(color: Color(0xFF6D28D9))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Subscription Plans', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Basic Plan
            _PlanCard(
              title: 'Basic',
              price: 'Free',
              features: const [
                'Access to basic comics',
                'Limited downloads',
                'Community access',
                'Basic support'
              ],
              onSelect: () {},
            ),
            const SizedBox(height: 16),

            // Premium Plan
            _PlanCard(
              title: 'Premium',
              price: '\$9.99/month',
              features: const [
                'All comics and anime',
                'Unlimited downloads',
                'Ad-free experience',
                'Priority support',
                'Early access to new content'
              ],
              isFeatured: true,
              onSelect: () => _contactDeveloper(),
            ),
            const SizedBox(height: 16),

            // VIP Plan
            _PlanCard(
              title: 'VIP',
              price: '\$19.99/month',
              features: const [
                'All Premium features',
                'Exclusive content',
                'Custom requests',
                '24/7 dedicated support',
                'Beta features access'
              ],
              onSelect: () => _contactDeveloper(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isFeatured;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    this.isFeatured = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isFeatured ? const Color(0xFF6D28D9) : const Color(0xFF12151B),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.check, color: Colors.green[300], size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSelect,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFeatured ? Colors.white : const Color(0xFF6D28D9),
                foregroundColor: isFeatured ? const Color(0xFF6D28D9) : Colors.white,
                minimumSize: const Size(double.infinity, 44),
              ),
              child: Text(isFeatured ? 'Get Premium' : 'Select Plan'),
            ),
          ],
        ),
      ),
    );
  }
}