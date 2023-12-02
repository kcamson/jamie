import 'package:flutter/material.dart';
import 'package:jamie/screens/testimonials_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class TopBar extends StatefulWidget {
  final double opacity;
  final ScrollController scrollController;
  final GlobalKey dataKey;

  const TopBar(this.opacity,
      {super.key, required this.scrollController, required this.dataKey});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Colors.black.withOpacity(widget.opacity),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/jamie-logo-white.png',
                height: 70,
              ),
              // Text(
              //   'JAMIE STUART',
              //   style: TextStyle(
              //     color: Colors.blueGrey[100],
              //     fontSize: 20,
              //     fontFamily: 'Montserrat',
              //     fontWeight: FontWeight.w400,
              //     letterSpacing: 3,
              //   ),
              // ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 8),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {
                        widget.scrollController.animateTo(
                          widget.scrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                              color: _isHovering[0]
                                  ? Colors.blue[200]
                                  : Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[0],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[1] = true
                              : _isHovering[1] = false;
                        });
                      },
                      onTap: () => Scrollable.ensureVisible(
                          widget.dataKey.currentContext!),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Services',
                            style: TextStyle(
                                color: _isHovering[1]
                                    ? Colors.blue[200]
                                    : Colors.white,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[1],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[2] = true
                              : _isHovering[2] = false;
                        });
                      },
                      onTap: () {
                        widget.scrollController.animateTo(
                          widget.scrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 2),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Contact',
                            style: TextStyle(
                                color: _isHovering[2]
                                    ? Colors.blue[200]
                                    : Colors.white,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[2],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[3] = true
                              : _isHovering[3] = false;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const Testimonials()));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Testimonials',
                            style: TextStyle(
                                color: _isHovering[3]
                                    ? Colors.blue[200]
                                    : Colors.white,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[3],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[4] = true
                              : _isHovering[4] = false;
                        });
                      },
                      onTap: () async => await launchUrl(Uri.parse(
                          'https://www.youtube.com/watch?v=ArcjeXFjoHw')),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pro Tips',
                            style: TextStyle(
                                color: _isHovering[4]
                                    ? Colors.blue[200]
                                    : Colors.white,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[4],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[5] = true
                              : _isHovering[5] = false;
                        });
                      },
                      onTap: () async => await launchUrl(Uri.parse(
                          'https://calendly.com/jamiestuartcommunications')),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Consultation',
                            style: TextStyle(
                                color: _isHovering[5]
                                    ? Colors.blue[200]
                                    : Colors.white,
                                fontSize: 20),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[5],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[3] = true : _isHovering[3] = false;
                    });
                  },
                  onTap: () async {
                    await launchUrl(Uri.parse('https://x.com/jamiestuarttv'));
                  },
                  child: Image.asset(
                    'assets/images/x.png',
                    height: 23,
                  )),
              SizedBox(
                width: screenSize.width / 50,
              ),
              InkWell(
                  onHover: (value) {
                    setState(() {
                      value ? _isHovering[3] = true : _isHovering[3] = false;
                    });
                  },
                  onTap: () async {
                    await launchUrl(
                        Uri.parse('https://instagram.com/n12jamiestuart'));
                  },
                  child: Image.asset(
                    'assets/images/ig.png',
                    height: 25,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
