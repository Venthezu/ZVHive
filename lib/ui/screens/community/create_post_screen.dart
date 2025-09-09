import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final List<String> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImages.add(image.path);
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _createPost() {
    if (_contentController.text.trim().isEmpty && _selectedImages.isEmpty) {
      return;
    }

    // Create post logic here
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Create Post', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _createPost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Content Input
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
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
            
            // Selected Images
            if (_selectedImages.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(_selectedImages[index] as dynamic),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            
            // Add Image Button
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text('Add Photo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D28D9),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}