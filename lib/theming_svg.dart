import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThemingSvg extends StatelessWidget {
  const ThemingSvg(
      {required this.primary, this.asset = 'asset/name_image.svg', Key? key})
      : super(key: key);

  final Color primary;

  ///     if you are using a package
  ///     you can pass  'packages/name_packages/asset/name_image.svg'  instead of    'asset/name_image.svg'
  final String asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(asset),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SvgPicture.string(
            snapshot.data!.replaceAll(
                //you can replace it with the primary color in your sgv
                "#F6AA35",
                '#${primary.value.toRadixString(16).padLeft(6, '0').toUpperCase()}'),
          );
        } else {
          return SvgPicture.asset(asset);
        }
      },
    );
  }
}
