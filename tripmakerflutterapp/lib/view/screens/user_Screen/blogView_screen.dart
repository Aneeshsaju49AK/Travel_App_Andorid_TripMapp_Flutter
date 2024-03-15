import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class BlogViewPage extends StatefulWidget {
  final BlogModel place;
  const BlogViewPage({required this.place, Key? key}) : super(key: key);

  @override
  State<BlogViewPage> createState() => _BlogViewPageState();
}

class _BlogViewPageState extends State<BlogViewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPlace = widget.place;
  }

  bool showFullDescription = false;
  late BlogModel _currentPlace;
  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
              bottom: 50,
            ),
            child: SizedBox(
              width: width / 1,
              height: height / 1.2,
              child: Stack(
                children: [
                  SizedBox(
                    height: height / 2,
                    width: width / 1,
                    child: Stack(
                      children: [
                        SliderImageViewWidget(
                          imagePathList: _currentPlace.images!,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 12,
                            left: 20,
                          ),
                          child: BackButtonWidget(
                            sizeOfImage: 43,
                            isCHecked: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 342,
                    ),
                    child: Container(
                      height: height / 1.5,
                      width: width / 1,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 234, 234),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: width / 1,
                            height: height / 12,
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    top: 22,
                                  ),
                                  child: SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: width / 2,
                                            height: height / 17,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                  child: Text(
                                                "${_currentPlace.name}",
                                                style: GoogleFonts.abel(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              )),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width / 1.1,
                            height: height / 14,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "My View",
                                  style: GoogleFonts.abel(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: width / 2.7,
                                ),
                                Image.asset(
                                  "asset/imges/navigation_img/eye.png",
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Watch \nvlogs",
                                  style: GoogleFonts.abel(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showFullDescription = !showFullDescription;
                              });
                            },
                            child: SizedBox(
                              width: width / 1.2,
                              height: height / 4.7,
                              child: SingleChildScrollView(
                                child: Text(
                                  _currentPlace.content!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
