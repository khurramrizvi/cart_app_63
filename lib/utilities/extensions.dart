extension ConvertNumToRupees on num? {
  String get inRupees {
    if (this == null) {
      return 'N/A';
    }
    return '₹${this!.toStringAsFixed(2)}';
  }
}
