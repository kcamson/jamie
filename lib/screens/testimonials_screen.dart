import 'package:flutter/material.dart';

class Testimonials extends StatelessWidget {
  const Testimonials({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testimonials'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/bruce-beck.jpeg',
                        width: 400,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: Text(
                          'Bruce Beck',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'Lead Sports Anchor, NBC 4 New York',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: SizedBox(
                          width: 400,
                          child: Text(
                            '''Jamie Stuart is a pro’s pro. For 23 years, 22 of them at News 12 Long Island, he has proven to be a terrific reporter and gifted storyteller. Well respected and genuinely liked by all, Jamie is now spreading his wings and sharing his love of journalism and broadcasting with others. I have no doubt he will be an excellent teacher - and the kind of mentor who can catapult others to success in this challenging and fascinating industry.\n\n''',
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
                        'assets/images/pat-dolan.jpeg',
                        width: 400,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: Text(
                          'Pat Dolan',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'Owner, Newsday',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: SizedBox(
                          width: 400,
                          child: Text(
                            '''Jamie Stuart is a pro’s pro. For 23 years, 22 of them at News 12 Long Island, he has proven to be a terrific reporter and gifted storyteller. Well respected and genuinely liked by all, Jamie is now spreading his wings and sharing his love of journalism and broadcasting with others. I have no doubt he will be an excellent teacher - and the kind of mentor who can catapult others to success in this challenging and fascinating industry.\n\n''',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/elisa-distefano.jpeg',
                        width: 400,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: Text(
                          'Elisa DiStefano',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'Newsday TV Anchor/Reporter',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: SizedBox(
                          width: 400,
                          child: Text(
                            '''Jamie is one of the best storytellers in the business. He is not only authentic and engaging on camera, but he brings out the best in the person he is interviewing. Always interesting, interactive and spontaneous, his creativity captures and commands an audience’s attention. With experience and years of hard work honing his craft (along with natural ability), Jamie has the tools to teach you the most valuable lessons so you can show your best self.\n\n''',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
