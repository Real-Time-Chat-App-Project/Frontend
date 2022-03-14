abstract class INavigationService {
  Future<void> navigateToPage({required String path, required Object data});
}
