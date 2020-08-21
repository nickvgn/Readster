import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageHelper {
  static Future<List<Color>> getImagePalette(
      ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    var colors = paletteGenerator.colors.toList();
//    var color1 =
//        colors.firstWhere((element) => element.computeLuminance() < .4);
//    colors.remove(color1);
    var color1 = paletteGenerator.darkVibrantColor.color;
    var color2 = colors.firstWhere((element) =>
        element.computeLuminance() < .4 &&
        (element.value - color1.value).abs() > 4000000);

    List<Color> colorList = [];
    colorList.add(color1);
    color2.computeLuminance() > color1.computeLuminance()
        ? colorList.insert(0, color2)
        : colorList.insert(1, color2);

    return colorList;
  }

  static Future<Color> getImagePaletteDominantColor(
      ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);

    return paletteGenerator.dominantColor.color;
  }

  static Future<List<Color>> getImagePaletteWithOpacity(
      ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    var colors = paletteGenerator.colors.toList();
    var color1 =
        colors.firstWhere((element) => element.computeLuminance() < .35);
    colors.remove(color1);
    var color2 = colors.firstWhere((element) =>
        element.computeLuminance() < .4 &&
        (element.value - color1.value).abs() > 4000000);

    List<Color> colorList = [];
    colorList.add(color1.withOpacity(.8));
    color2.computeLuminance() > color1.computeLuminance()
        ? colorList.insert(0, color2.withOpacity(.8))
        : colorList.insert(1, color2.withOpacity(.8));

    return colorList;
  }
}
