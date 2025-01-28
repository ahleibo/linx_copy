import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class ImageUploadService {
  final supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();

  Future<List<String>> pickImages({
    required ImageSource source,
    required bool allowMultiple,
  }) async {
    try {
      List<XFile>? pickedFiles;
      if (allowMultiple) {
        pickedFiles = await _picker.pickMultiImage();
      } else {
        final XFile? file = await _picker.pickImage(source: source);
        pickedFiles = file != null ? [file] : [];
      }

      return pickedFiles.map((file) => file.path).toList();
    } catch (e) {
      print('Error picking images: $e');
      return [];
    }
  }

  Future<List<String>> uploadImages({
    required List<String> imagePaths,
    required String bucket,
    required String folder,
    required Function(double) onProgress,
  }) async {
    List<String> uploadedUrls = [];

    try {
      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];
        File file = File(imagePath);
        
        // Generate a unique filename using timestamp
        String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        String extension = path.extension(imagePath);
        String fileName = '$timestamp$extension';
        String fullPath = '$folder/$fileName';

        // Upload the file
        await supabase.storage.from(bucket).upload(
          fullPath,
          file,
          fileOptions: FileOptions(
            cacheControl: '3600',
            upsert: false,
          ),
        );

        // Get the public URL
        String publicUrl = supabase.storage.from(bucket).getPublicUrl(fullPath);
        uploadedUrls.add(publicUrl);

        // Update progress
        onProgress((i + 1) / imagePaths.length);
      }

      return uploadedUrls;
    } catch (e) {
      print('Error uploading images: $e');
      rethrow;
    }
  }
}

class ImageUploadWidget extends StatefulWidget {
  final Function(List<String>) onUploadComplete;
  final String bucket;
  final String folder;

  const ImageUploadWidget({
    Key? key,
    required this.onUploadComplete,
    required this.bucket,
    required this.folder,
  }) : super(key: key);

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImageUploadService _uploadService = ImageUploadService();
  double _uploadProgress = 0;
  bool _isUploading = false;

  Future<void> handleImageUpload(ImageSource source) async {
    try {
      setState(() {
        _isUploading = true;
        _uploadProgress = 0;
      });

      // Pick images
      List<String> pickedImages = await _uploadService.pickImages(
        source: source,
        allowMultiple: source == ImageSource.gallery,
      );

      if (pickedImages.isEmpty) {
        setState(() => _isUploading = false);
        return;
      }

      // Upload images
      List<String> uploadedUrls = await _uploadService.uploadImages(
        imagePaths: pickedImages,
        bucket: widget.bucket,
        folder: widget.folder,
        onProgress: (progress) {
          setState(() => _uploadProgress = progress);
        },
      );

      widget.onUploadComplete(uploadedUrls);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading images: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isUploading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(value: _uploadProgress),
            SizedBox(height: 16),
            Text('Uploading... ${(_uploadProgress * 100).toInt()}%'),
          ],
        ),
      );
    }

    return Container(); // This widget is mainly for logic handling
  }
}