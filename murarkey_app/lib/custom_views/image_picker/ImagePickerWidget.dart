import 'package:image_picker/image_picker.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/26/2021.
 */

class ImagePickerWidget {
  static final double _maxWidth = 500;
  static final double _maxHeight = 500;
  static final int _quality = 100;

  static Future loadFromGallery(BuildContext context) async {
    PickedFile _imageFile;
    try {
      _imageFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        // maxWidth: _maxWidth,
        // maxHeight: _maxHeight,
        imageQuality: _quality,
      );
      print("_imageFile: ${_imageFile.path}");
    } catch (e) {
      _imageFile = null;
      Commons.toastMessage(context, e.toString());
    }
    return _imageFile;
  }

  static Future loadFromCamera(BuildContext context) async {
    PickedFile _imageFile;
    try {
      _imageFile = await ImagePicker().getImage(
          source: ImageSource.camera,
          // maxWidth: _maxWidth,
          // maxHeight: _maxHeight,
          imageQuality: _quality,
          preferredCameraDevice: CameraDevice.rear);
      print("_imageFile: ${_imageFile.path}");
    } catch (e) {
      _imageFile = null;
      Commons.toastMessage(context, e.toString());
    }
    return _imageFile;
  }
}
