import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/services/payment_service.dart';
import 'package:mobile_app/services/storage_service.dart';

final fireAuthProvider = Provider<FirebaseAuth>(
  (ref) {
    return FirebaseAuth.instance;
  },
);

final authChangesProvider = StreamProvider<User?>(
  (ref) {
    return ref.watch(fireAuthProvider).authStateChanges();
  },
);

final firestoreProvider = Provider<FirestoreService?>(
  (ref) {
    final authentication = ref.watch(authChangesProvider);

    String? uid = authentication.asData?.value?.uid;
    if (uid != null) {
      return FirestoreService(userId: uid);
    }
    return null;
  },
);

final storageProvider = Provider<StorageService?>(
  (ref) {
    final auth = ref.watch(authChangesProvider);

    String? uid = auth.asData?.value?.uid;
    if (uid != null) {
      return StorageService(uid: uid);
    }
    return null;
  },
);

final paymentSheetProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});
