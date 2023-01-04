import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalle_image_generator/image_details_page.dart';
import 'package:dalle_image_generator/pallets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> messages = [
    // ChatItem(message: 'Paly pals', image: 'image', userId: 'userId'),
  ];

  ValueNotifier<bool> loading = ValueNotifier(false);

  final TextEditingController textEditingController = TextEditingController();
  static const String baseUrl = "http://localhost:3000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Image generator',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: loading,
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: messages.length,
                      reverse: true,
                      padding: const EdgeInsets.all(24),
                      itemBuilder: (context, index) {
                        final singleItem = messages.reversed.toList()[index];

                        bool isLocalUser =
                            singleItem.toString().contains('https:');
                        return Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: isLocalUser ? 50 : 0,
                            right: !isLocalUser ? 50 : 0,
                          ),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: !isLocalUser
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                              bottomRight: isLocalUser
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                            ),
                            color: isLocalUser
                                ? Pallets.chatGreen
                                : Pallets.chatBlue,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // singleItem.image != null ? SizedBox() : const SizedBox(),

                              isLocalUser
                                  ? Text(messages[index])
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ImageDetailsPage(
                                                        imagelink:
                                                            messages[index])));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: messages[index],
                                        // placeholder: (context, url) =>
                                        //     Text('Generating Image...'),
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),

                              const SizedBox(
                                height: 12,
                              ),

                              // ...images[index]
                              //     .map(
                              //       (e) => Image.network(
                              //         '',
                              //         fit: BoxFit.cover,
                              //         width: 300,
                              //         height: 300,
                              //       ),
                              //     )
                              //     .toList(),
                            ],
                          ),
                        );
                      });
                }),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 50),
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (value) async {
                          // images.clear();
                          await getImage();
                        },
                        controller: textEditingController,
                        cursorColor: Pallets.primary,
                        cursorWidth: 1.5,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),

                          hintText: 'Enter keywords',
                          // constraints: BoxConstraints(maxHeight: 40, minHeight: 40),

                          hintStyle: TextStyle(
                            color: Pallets.grey50,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Pallets.grey75,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),

                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Pallets.red,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),

                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Pallets.grey75,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Pallets.grey75,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await getImage();
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Pallets.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: loading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                CupertinoIcons.paperplane,
                                size: 24,
                                color: Pallets.white,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getImage() async {
    loading.value = true;
    final initialText = textEditingController.text.trim();

    setState(() {});

    textEditingController.clear();
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "prompt": initialText,
          },
        ),
      );

      final imageLinks = jsonDecode(response.body)['bot'];

      print(imageLinks);
      messages.insert(0, initialText);

      messages.insert(0, imageLinks[0]['url']);
      // setState(() {});
    } catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;

      setState(() {});
    }
  }
}
