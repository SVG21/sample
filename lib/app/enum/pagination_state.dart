import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollNotifier extends StateNotifier<bool> {
  final scrollProvider = StateNotifierProvider((ref) => ScrollNotifier());

  ScrollNotifier() : super(false);

  void updateVisibility(bool isVisible) {
    state = isVisible;
  }

}
