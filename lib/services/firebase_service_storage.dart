import 'package:get/get.dart';
import 'package:study_bank/mobileLayout/controllers/firebase_ref/firebase_refer.dart';

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child("question_paper_images")
          .child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      // print(imgUrl);
      return imgUrl;
    } catch (e) {
      return null;
    }
  }
}
