

import '../../constants/strings.dart';

class ImageUtils{
   static String? getNormalImage(String? imageUrl) {
    if (imageUrl == null) return null;
    final uri = Uri.parse(imageUrl);
    if (uri.isAbsolute) {
      return imageUrl;
    }
    return '${AppStrings.imageBaseUrl}$imageUrl';
  }

}