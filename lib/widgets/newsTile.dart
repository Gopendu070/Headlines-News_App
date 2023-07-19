import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:news_dekho/screens/newsScreen.dart';

class newsTile extends StatelessWidget {
  String title;
  String description;
  String source;
  String url;
  String urlToImage;
  String publishedAt;

  String content;
  newsTile(
      {required this.title,
      required this.source,
      required this.description,
      required this.content,
      required this.urlToImage,
      required this.publishedAt,
      required this.url});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newsScreen(
                  title: title,
                  description: description.toString(),
                  content: content,
                  publishedAt: publishedAt.toString(),
                  imgUrl: urlToImage.toString(),
                  source: source,
                  url: url),
            ));
      },
      child: Card(
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 110,
                  decoration: BoxDecoration(
                      image: urlToImage.toString() != 'null'
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(
                                urlToImage,
                                scale: 0.6,
                              ),
                              fit: BoxFit.fill,
                            )
                          : const DecorationImage(
                              image: AssetImage(
                                  'lib/assets/images/noImg2-removebg.png')),
                      borderRadius: BorderRadius.circular(13)),
                ),
                SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        // Title
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 7),
                      Row(
                        children: [
                          Container(
                            width: 110,
                            child: Text(
                              // Source
                              source,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          //publish date
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              publishedAt.substring(0, 10),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600]),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
