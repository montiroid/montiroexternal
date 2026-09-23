import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../shared/shared_color.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SpinKitThreeBounce(
        color: AppColor.mainColor,
        size: 25,
      ),
    );
  }
}

class CustomLoadiingWhite extends StatelessWidget {
  const CustomLoadiingWhite({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 25,
      ),
    );
  }
}

class LoadImageWithURL extends StatelessWidget {
  const LoadImageWithURL({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url == "") {
      return Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.help_outline, size: 40),
            SizedBox(
              height: 5,
            ),
            Text('No Image'),
          ],
        ),
      );
    } else {
      return CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: url,
          // errorWidget: (context, url, error) => LoadImageWithURL(url: url),
          placeholder: (context, url) => Container(
                width: double.infinity,
              ),
          filterQuality: FilterQuality.high);
    }
  }
}
