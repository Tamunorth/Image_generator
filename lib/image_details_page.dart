import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({Key? key, required this.imagelink}) : super(key: key);

  final String imagelink;

  saveImage(String imageLink) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(imageLink ??
          "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      // var path = await ImageDownloader.findPath(imageId);
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);

    } on PlatformException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await saveImage(imagelink);

          Future.delayed(Duration.zero, () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Downloaded')));
          });
        },
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imagelink,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
            top: 60,
            left: 25,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                // height: 30,
                // width: 30,
                padding: const EdgeInsets.only(
                    left: 12, top: 5, bottom: 5, right: 5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
