import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_dekho/widgets/transparentTag.dart';
import 'package:url_launcher/url_launcher.dart';

class newsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String content;
  final String publishedAt;
  final String source;
  final String imgUrl;
  final String url;

  newsScreen(
      {required this.title,
      required this.description,
      required this.content,
      required this.publishedAt,
      required this.imgUrl,
      required this.source,
      required this.url});

  @override
  State<newsScreen> createState() => _newsScreenState();
}

class _newsScreenState extends State<newsScreen> {
  // void _launchingURL(Uri url) async {
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    var hig = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(187, 53, 51, 51),
            width: wid,
            height: hig,
            child: Column(
              children: [
                Container(
                    width: wid,
                    height: hig / 3 + 27,
                    decoration: BoxDecoration(
                      image: widget.imgUrl.toString() != 'null'
                          ? DecorationImage(
                              image:
                                  (CachedNetworkImageProvider(widget.imgUrl)),
                              fit: BoxFit.fill)
                          : const DecorationImage(
                              image: AssetImage(
                                'lib/assets/images/noImg2-removebg.png',
                              ),
                              fit: BoxFit.contain),
                    )),
              ],
            ),
          ),
          Positioned(
            bottom: hig - 275,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                  child: transparentTag(data: widget.source),
                ),
                Container(
                  color: Color.fromARGB(54, 65, 64, 64),
                  width: wid,

                  //Title
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Navigation arrow
          Positioned(
              top: 18,
              left: 9,
              child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back))),
          Positioned(
            top: (hig / 3) + 15,
            child: Container(
              width: wid,
              height: ((hig * 2) / 3),
              child: ListView(
                children: [
                  const SizedBox(height: 15),
                  // Publish Date
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      'Published on: ${widget.publishedAt.substring(0, 10)}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    //Description
                    child: Text(
                      widget.description.toString() != 'null'
                          ? widget.description
                          : 'The full article is available on the website. Please check out the link below.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 17, color: Colors.white),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  //URL launcher to Web
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'To read the full article, click here :',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(11.0),
                              child: Text(
                                'Read full article...',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16),
                              ),
                            ),
                          ),
                          onTap: () async {
                            //launches the url in external app/browser
                            await launchUrl(Uri.parse(widget.url),
                                mode: LaunchMode.externalApplication);
                          },
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 27),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 77, 86, 92),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 81, 89, 93),
                    Color.fromARGB(251, 31, 30, 30)
                  ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
            ),
          )
        ],
      ),
    );
  }
}
