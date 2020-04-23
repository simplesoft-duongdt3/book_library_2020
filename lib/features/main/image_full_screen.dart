
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  final String tag;
  final String imageUrl;

  ImageFullScreen({Key key, this.tag, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.94),
        body: Hero(
          tag: tag,
          transitionOnUserGestures: true,
          child: Stack(
            children: <Widget>[
              Center(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    iconSize: 32,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
