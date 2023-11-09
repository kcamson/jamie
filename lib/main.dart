import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:jamie/widgets/top_bar.dart';
import 'package:jamie/widgets/web_scrollbar.dart';
import 'package:jamie/widgets/youtube.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    final isWide = MediaQuery.of(context).size.width > 700;

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
                      isWide ? 'Up your game.' : 'Up your\ngame.',
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
                      'Nothing In Business Is More Vital Than Communication.',
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
                      '''How you communicate – with a potential client via email, on your company’s daily zoom meeting, in your pitch at the C-suite level boardroom, or at the annual industry conference in front of 2,000 people – can make or break you as an individual and your company at-large.'''
                      '''\n\nBut being dynamic when you speak – clear, concise and compelling – isn’t easy, especially if there’s a bright light (or six) shining in your eyes.'''
                      '''\n\nWith 23 years of TV experience as an anchor and reporter, I have the inside scoop to help. I have broadcast live in front of millions of people, covering everything from politics to the Super Bowl to live interviews.
'''
                      '''\nI know what it takes to perform under pressure, and I’ll give you the secrets – how to get over stage fright, what to do with your hands, when to take a breath, and countless more tips – to help you connect with your audience and finally reach your true potential. From media training to speech writing to executive presence, let me help elevate your game.
''',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width:
                        isWide ? 600 : MediaQuery.of(context).size.width - 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: const Youtube(),
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
                              'Executive Presence',
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
                                '''Whenever you communicate – not just speaking publicly but in emails
and social media posts - you represent your company.
\nEverything matters - from how you stand to how far away the
microphone is from your mouth to your hand gestures to your wardrobe.
\nLearn the keys to commanding a zoom and commanding a room, just
like the best do it on broadcast TV.\n\n''',
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
                              'Image Consulting',
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
                                '''How you appear matters – in public and in private meetings, too. 
\nAnd it’s not just clothes. 
\nSweating on-camera makes you look nervous; that’s bad for business. 
\nFrom your wardrobe and hair, to makeup (yes, guys, if you’re appearing on-camera, you should be wearing some. Tom Cruise & Denzel Washington do it, and so should you). 
\nLearn how to elevate your game – without changing YOU.\n\n''',
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
                              'Interview Prep',
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
                                '''You've finally landed the big interview.
\nBut how do you make a great first impression? How much talking should you do, and how much should you listen? How do you properly accentuate your accomplishments while deflecting the inevitable tough questions about any weaknesses on your resume?
\nIn a hybrid world, you have to know how to ace these opportunities both virtually and in-person.
\nYou have to tell YOUR story while listening to theirs. You have to assure them you can stand out - while fitting in with their team.
\nNo, it isn't easy.
\nBut I've done it, and I'll help you thrive in a high-stakes environment, giving you the best chance to reach your dream.\n
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
                              'Video Conferencing',
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
                                '''The world has changed, and I hear it over and over again in every industry - you need to excel on Zoom, Teams or whatever platform your company uses. 
\nSo why do so many executives get it so wrong? 
\nLooking in the wrong place, overdoing (or underdoing) the background, sitting too far (or too close) to the camera, forgetting that silence can be your best friend…
\nVideo conferencing is an art, and there are numerous ways to become a more dynamic presence online.
\nI’ll teach you how.\n\n''',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Master Messaging
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/messaging.jpeg',
                            width: 400,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Master Messaging',
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
                                '''The best and most important information so often gets lost in the weeds because people are not as clear and concise as they need to be. 
\nWhat you say doesn’t matter if your audience doesn’t internalize it, and that’s as true for 1-on-1 meetings as it is for a gigantic presentation. 
\nI’ll teach you how to cut to the chase while emphasizing the key points you need to get across – whether your target is a single, potential client or a convention center filled with thousands of them. Make your time – and theirs – count.\n
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
                              'Public Speaking',
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
                                '''If you’re a forward-facing person at your company, public speaking is simply part of the job.
\nIt can be overwhelming, and frankly, why wouldn’t it be? You’ve never been trained for it.
\nI have, and I’ll reveal all of the skills and devices you can use to overcome your nerves and connect with your audience.\n
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

                    // Speech Writing
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Image.asset('assets/images/reporting.jpeg',
                              width: 400, height: 300, fit: BoxFit.fitHeight),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Media Training',
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
                                '''I’ll pass along the skills you need to excel in front of the camera.

After your training, you will know how to excel when there’s a microphone or a camera thrust in your face.

You don’t have to fear journalists, and instead of shying from the camera, I’ll give you the inside scoop on how to shine in the limelight, whether you’re brought on as an expert analyst or your company has some explaining to do.
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
