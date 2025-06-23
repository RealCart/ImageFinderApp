class AppAssets {
  static const svg = Svg();
  static const image = Picture();
}

class Svg {
  const Svg();

  final String logo = "assets/svg/logo.svg";
  final String heart = "assets/svg/heart.svg";
  final String blackHeart = "assets/svg/black_heart.svg";
  final String likedHeart = "assets/svg/liked_heart.svg";
  final String download = "assets/svg/download.svg";
  final String search = "assets/svg/search.svg";
}

class Picture {
  const Picture();

  final String background = "assets/image/background.png";
  final String badResponseFailure = "assets/image/error-403.png";
  final String networkFailure = "assets/image/network_failure.png";
  final String timeOutFailure = "assets/image/time_out.png";
}
