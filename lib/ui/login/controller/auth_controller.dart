import '../../../all_packages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var verificationId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthState();
  }

  void checkAuthState() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offAllNamed('/home');
      }
    });
  }

  void _showSnackbar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.redAccent : const Color(0xFF0052CC),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> sendOtp(String phone) async {
    isLoading(true);

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        await saveUser(phone);
        Get.offAllNamed('/home');
      },
      verificationFailed: (FirebaseAuthException e) {
        _showSnackbar(
          "Error",
          e.message ?? "Verification Failed",
          isError: true,
        );
        isLoading(false);
      },
      codeSent: (String verId, int? resendToken) {
        verificationId.value = verId;
        _showSnackbar("Success", "OTP Sent automatically to your phone");
        isLoading(false);
        Get.toNamed('/login', arguments: {'phone': phone});
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId.value = verId;
      },
    );
  }

  Future<void> verifyOtp(String otp, String phone) async {
    isLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      await saveUser(phone);
      Get.offAllNamed('/home');
    } catch (e) {
      _showSnackbar("Error", "Invalid OTP entered", isError: true);
    }
    isLoading(false);
  }

  Future<void> saveUser(String phone) async {
    await FirebaseFirestore.instance.collection("users").doc(phone).set({
      "phone": phone,
      "createdAt": DateTime.now(),
    });
  }
}
