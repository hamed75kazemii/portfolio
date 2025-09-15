import 'package:hamed_portfolio/utils/screen_utils.dart';

double calculateResponsive(double input) {
  const double baseWidth = 393;
  try {
    final double screenWidth = ScreenUtil.getScreenWidth();

    // Pour les écrans larges comme l'iPad (largeur >= 744px pour inclure l'iPad mini)
    if (screenWidth >= 744) {
      // Appliquer un facteur d'échelle réduit pour les grands écrans
      // Cela rendra la taille de police raisonnablement plus grande, mais pas excessivement
      return input * (1.5 + (screenWidth - 744) / baseWidth / 4);
    }

    // Pour les téléphones, garder la mise à l'échelle linéaire existante
    return input * screenWidth / baseWidth;
  } catch (e) {
    // If ScreenUtil is not initialized, return the input as is
    return input;
  }
}

double calculateResponsiveFromWidth(double input, double screenWidth) {
  const double baseWidth = 393;

  // Pour les écrans larges comme l'iPad (largeur >= 744px pour inclure l'iPad mini)
  if (screenWidth >= 744) {
    // Appliquer un facteur d'échelle réduit pour les grands écrans
    // Cela rendra la taille de police raisonnablement plus grande, mais pas excessivement
    return input * (1.5 + (screenWidth - 744) / baseWidth / 4);
  }

  // Pour les téléphones, garder la mise à l'échelle linéaire existante
  return input * screenWidth / baseWidth;
}

bool needToSetBig() {
  const double baseWidth = 393;
  try {
    return ScreenUtil.getScreenWidth() > baseWidth;
  } catch (e) {
    // If ScreenUtil is not initialized, assume it's a small screen
    return false;
  }
}
