extension StringX on String {
  String getInitials() =>
      trim().split(RegExp(' +')).map((s) => s[0]).take(2).join();
}
