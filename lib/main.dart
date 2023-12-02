import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:jamie/screens/testimonials_screen.dart';
import 'package:jamie/widgets/top_bar.dart';
import 'package:jamie/widgets/web_scrollbar.dart';
import 'package:jamie/widgets/youtube.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jamie Stuart',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Jamie Stuart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  final dataKey = GlobalKey();

  bool showYT0 = false;
  bool showYT = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    final isWide = MediaQuery.of(context).size.width > 1430;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: isWide
          ? PreferredSize(
              // for larger & medium screen sizes
              preferredSize: Size(screenSize.width, 1000),
              child: TopBar(_opacity,
                  scrollController: _scrollController, dataKey: dataKey),
            )
          : AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              // TRY THIS: Try changing the color here to a specific color (to
              // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
              // change color while the other colors stay the same.
              backgroundColor: Colors.black.withOpacity(_opacity),
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Image.asset(
                'assets/images/jamie-logo-white.png',
                height: 70,
              ),
            ),
      drawer: isWide
          ? null
          : Drawer(
              child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                  ),
                  child: Image.asset(
                    'assets/images/jamie-logo-white.png',
                    height: 70,
                  ),
                ),
                ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn,
                      );
                    }),
                ListTile(
                    leading: const Icon(Icons.apps),
                    title: const Text('Services'),
                    onTap: () {
                      Navigator.pop(context);
                      Scrollable.ensureVisible(dataKey.currentContext!);
                    }),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Contact'),
                  onTap: () {
                    Navigator.pop(context);
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.branding_watermark),
                  title: const Text('Testimonials'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const Testimonials()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tips_and_updates),
                  title: const Text('Pro Tips'),
                  onTap: () async => await launchUrl(
                      Uri.parse('https://www.youtube.com/watch?v=ArcjeXFjoHw')),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Consultation'),
                  onTap: () async => await launchUrl(
                      Uri.parse('https://calendly.com/jamiestuartcommunications')),
                ),
              ],
            )),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  height: screenSize.height * 0.45,
                  width: screenSize.width,
                  child: Image.asset(
                    'assets/images/headshot.png',
                    // 'https://firebasestorage.googleapis.com/v0/b/whatsthemoov-app.appspot.com/o/do-not-delete%2Fvideo_preview.png?alt=media&token=54976899-a3dc-460e-9c1f-1825bbee8bac&_gl=1*1h2vnsn*_ga*OTI2NzE2OTguMTY4MDE5ODE0MA..*_ga_CW55HF8NVT*MTY5OTA5NjE3Ny40MTMuMS4xNjk5MDk2NzkxLjM5LjAuMA..',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: isWide ? 300 : 50),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isWide ? 'GAME CHANGER' : 'GAME\nCHANGER',
                      style: TextStyle(
                        color: Colors.blueGrey[100],
                        fontSize: 26,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: isWide ? 100 : 20,
                  children: [
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 400),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/emmy.png',
                            height: 80,
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            '7x Emmy Winner',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 500),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/newsday.png',
                              height: 90,
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Newsday Sports',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 600),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Image.asset(
                            'assets/images/news12.png',
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'News 12',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isWide ? 100 : 50),
                    child: const Text(
                      'Communication is the Key to Success',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isWide ? 100 : 50),
                    child: const Text(
                      '''Steve Jobs once said, “The most powerful person in the world is the storyteller.”

So how do you communicate effectively? How can you be compelling – not boring?  Dynamic – not dull.  How do you do that in front of 50 or 500 people?  What if you’re in front of a TV camera or microphone?

With 23 years of TV experience as an anchor and reporter for News 12 Long Island and Newsday, I have the inside scoop to help. I have broadcast live in front of millions of people, covering everything from politics to the Super Bowl to live interviews.

I know what it takes to perform under pressure, and I’ll give you the secrets that have helped me communicate with power and clarity.

I can help you connect with your audience and finally reach your true potential. 

From public speaking, to on-air interviews, to remote conferences,  our partnership can be a game-changer. 
''',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width:
                        isWide ? 600 : MediaQuery.of(context).size.width - 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: showYT0
                          ? const Youtube(id: 'dTlvfTlMhV8')
                          : VisibilityDetector(
                              key: const Key('m-widget-key'),
                              onVisibilityChanged: (visibilityInfo) {
                                setState(() {
                                  showYT0 = true;
                                });
                              },
                              child: const Youtube(id: 'dTlvfTlMhV8'),
                            ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.only(left: isWide ? 100 : 50),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Services',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: isWide ? 100 : 50),
                    child: const Divider(),
                  ),
                  const SizedBox(height: 50),
                  Wrap(key: dataKey, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/presence.jpeg',
                            width: 400,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'PERFECT YOUR PRESENCE',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: SizedBox(
                              width: 400,
                              child: Text(
                                '''
No matter if you you’re representing yourself or your company, you “presence” is key.

Everything matters.  How you dress…how you smile…do you smile? 
Do you look like you have everything prepared or are you just “winging it?”   

It’s the little things that add up.  
Learn the keys to communicating like the best of the best do.\n\n''',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/islanders.jpeg',
                            width: 400,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'IMAGE IS EVERYTHING',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: SizedBox(
                              width: 400,
                              child: Text(
                                '''
You never get a second chance to make a first impression.  How you appear matters. 

Some people sweat…a lot.  I can help fix that. If you’re selling yourself to a client or selling to advertisers, it’s imperative they feel comfortable with you. 

I’ll give you styling tips while still making YOU feel comfortable.
\n\n''',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Interview Prep
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/jamie3.jpg',
                            width: 400,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'ON-AIR INTERVIEWS',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: SizedBox(
                              width: 400,
                              child: Text(
                                '''
Whether it’s on TV, online, or on radio, this is YOUR chance to get your point across.

But how do you do it without rambling? How do you speak confidently without talking so fast you lose your train of thought?  

I’ll work with you on various interview situations and help you avoid common media traps.

I can help you perfect your skills and avoid common media traps.  
''',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Video Conferencing
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Image.asset('assets/images/zoom.png',
                              width: 400, height: 300, fit: BoxFit.fitWidth),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'ZOOM/TEAMS TRAINING',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: SizedBox(
                              width: 400,
                              child: Text(
                                '''
If I had a dime for the amount of times I’ve been on a zoom call and wondered “what the heck is the host doing"… well, let’s just say it’s a lot.

In this current hybrid world, you need to excel on Zoom, Teams or whatever platform your company uses. 

That means having the right background, the right camera ratio, any potential notes at the ready, etc.

Video conferencing is an art. I’ll teach you.
\n\n''',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

//                     // Master Messaging
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 50),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/messaging.jpeg',
//                             width: 400,
//                             height: 300,
//                             fit: BoxFit.cover,
//                           ),
//                           const SizedBox(height: 10),
//                           const Padding(
//                             padding: EdgeInsets.all(15),
//                             child: Text(
//                               'Master Messaging',
//                               style: TextStyle(
//                                 color: Colors.blueGrey,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 25,
//                               ),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.all(15),
//                             child: SizedBox(
//                               width: 400,
//                               child: Text(
//                                 '''The best and most important information so often gets lost in the weeds because people are not as clear and concise as they need to be.
// \nWhat you say doesn’t matter if your audience doesn’t internalize it, and that’s as true for 1-on-1 meetings as it is for a gigantic presentation.
// \nI’ll teach you how to cut to the chase while emphasizing the key points you need to get across – whether your target is a single, potential client or a convention center filled with thousands of them. Make your time – and theirs – count.\n
// ''',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),

                    // Public Speaking
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/public.jpeg',
                            width: 400,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'PUBLIC SPEAKING',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: SizedBox(
                              width: 400,
                              child: Text(
                                '''
This is a big one!  The best speakers and presenters craft messages and communicate in a way that meets the audience where they are, serves their goals and needs, and feels authentic.

As someone whose job is to “speak publicly,” I get how this can be nerve wracking…and I’ve been trained for it! 

I will help you communicate with charisma, clarity, and confidence! 

There are ways to hone your skills and use tools you’ve never thought of to become more concise.

Make your time – and theirs – count.

I’ll help you get there. 

''',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 50),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       SizedBox(
                    //         width: 400,
                    //         height: 300,
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(0),
                    //           child: showYT
                    //               ? const Youtube(id: 'ArcjeXFjoHw')
                    //               : VisibilityDetector(
                    //                   key: const Key('my-widget-key'),
                    //                   onVisibilityChanged: (visibilityInfo) {
                    //                     setState(() {
                    //                       showYT = true;
                    //                     });
                    //                   },
                    //                   child: const Youtube(id: 'ArcjeXFjoHw'),
                    //                 ),
                    //         ),
                    //       ),
                    //       const Padding(
                    //         padding: EdgeInsets.all(15),
                    //         child: Text(
                    //           'PRO TIPS',
                    //           style: TextStyle(
                    //             color: Colors.blueGrey,
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 25,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

//                     // Speech Writing
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 50),
//                       child: Column(
//                         children: [
//                           Image.asset('assets/images/reporting.jpeg',
//                               width: 400, height: 300, fit: BoxFit.fitHeight),
//                           const SizedBox(height: 10),
//                           const Padding(
//                             padding: EdgeInsets.all(15),
//                             child: Text(
//                               'Media Training',
//                               style: TextStyle(
//                                 color: Colors.blueGrey,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 25,
//                               ),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.all(15),
//                             child: SizedBox(
//                               width: 400,
//                               child: Text(
//                                 '''I’ll pass along the skills you need to excel in front of the camera.

// After your training, you will know how to excel when there’s a microphone or a camera thrust in your face.

// You don’t have to fear journalists, and instead of shying from the camera, I’ll give you the inside scoop on how to shine in the limelight, whether you’re brought on as an expert analyst or your company has some explaining to do.
// ''',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
                  ]),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 25)),
                      onPressed: () => launchUrl(
                          Uri.parse('mailto:jamieleestuart@gmail.com')),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 10),
                              Text('jamieleestuart@gmail.com'),
                            ],
                          ),
                        ),
                      )),

                  const SizedBox(height: 100),
                  // Container(
                  //   child: Column(
                  //     children: [
                  //       FeaturedHeading(
                  //         screenSize: screenSize,
                  //       ),
                  //       FeaturedTiles(screenSize: screenSize)
                  //     ],
                  //   ),
                  // ),
                ],
              )
            ],
          ),
          // DestinationHeading(screenSize: screenSize),
          // DestinationCarousel(),
          // SizedBox(height: screenSize.height / 10),
          // BottomBar(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          launchUrl(Uri.parse('mailto:jamieleestuart@gmail.com'));
        },
        tooltip: 'Email me',
        child: const Icon(Icons.message),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
