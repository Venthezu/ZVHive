import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BugReportScreen extends StatefulWidget {
  const BugReportScreen({super.key});

  @override
  State<BugReportScreen> createState() => _BugReportScreenState();
}

class _BugReportScreenState extends State<BugReportScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _screenshotPath;
  bool _isLoading = false;

  Future<void> _pickScreenshot() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _screenshotPath = image.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  Future<void> _submitBugReport() async {
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe the bug')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Submit bug report logic here
      await Future.delayed(const Duration(seconds: 2));
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bug report submitted successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Report a Bug', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Describe the issue',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'What happened? What were you doing when the bug occurred?',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1A1F2E),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              const Text(
                'Add screenshot (optional)',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              
              if (_screenshotPath != null)
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(_screenshotPath! as dynamic),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              ElevatedButton.icon(
                onPressed: _pickScreenshot,
                icon: const Icon(Icons.photo_library),
                label: const Text('Add Screenshot'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1F2E),
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _isLoading ? null : _submitBugReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D28D9),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}