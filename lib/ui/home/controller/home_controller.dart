import '../../../all_packages.dart';

class HomeController extends GetxController {
  bool isLoading = true;
  bool isPaginating = false;
  List<GameModel> _allGames = [];
  List<GameModel> displayedGames = [];
  int _currentPage = 1;
  final int _pageSize = 20;
  final ApiService apiService = ApiService();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoading &&
        !isPaginating) {
      loadMoreGames();
    }
  }

  Future<void> fetchGames() async {
    try {
      isLoading = true;
      update();
      final response = await apiService.getGames();
      List data = response.data;
      _allGames = data.map((e) => GameModel.fromJson(e)).toList();

      _currentPage = 1;
      displayedGames = _allGames.take(_pageSize).toList();

      if (_allGames.isNotEmpty) {
        NotificationService.showGameNotification(_allGames.first);
      }
    } catch (e) {
      _showSnackbar("Error", "Failed to fetch games", isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }

  void loadMoreGames() {
    if (displayedGames.length >= _allGames.length) return;
    isPaginating = true;
    update();
    Future.delayed(const Duration(milliseconds: 600), () {
      _currentPage++;
      displayedGames = _allGames.take(_currentPage * _pageSize).toList();
      isPaginating = false;
      update();
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.register);
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
}
