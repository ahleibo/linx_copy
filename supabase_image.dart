import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseImage extends StatelessWidget {
  final String imageName;
  final double? width;
  final double? height;
  final double? radius;
  
  final supabase = Supabase.instance.client;

  SupabaseImage({
    required this.imageName,
    this.width,
    this.height,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = supabase.storage
        .from('image_objects')
        .getPublicUrl('profile_posts/$imageName');  // Just pass the path within the bucket

    if (radius != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl),
      );
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error);
      },
    );
  }
}