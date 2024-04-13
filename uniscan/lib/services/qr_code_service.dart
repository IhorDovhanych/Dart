import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniscan/models/qr_code.dart';

class QrCodeService {
  // get collection
  final CollectionReference qrCodes =
      FirebaseFirestore.instance.collection('qr_codes');

  //* CREATE
  Future<void> addQrCode(QrCode qrCode) {
    return qrCodes.add({
      'name': qrCode.name,
      'url': qrCode.url,
      'createdAt': qrCode.createdAt,
      'updatedAt': qrCode.updatedAt,
    });
  }
//* READ/GET
  Stream<QuerySnapshot> getQrCodesStream() {
    final qrCodesStream =
        qrCodes.orderBy('createdAt', descending: true).snapshots();
    return qrCodesStream;
  }
}
