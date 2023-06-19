import 'package:flutter/material.dart';
import 'package:kudinkaa/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}
class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _controller.repeat();
    super.initState();
  }

  final controller = PageController();
  bool isLastPage = false;
  bool isFirstPage = false;
  @override
  void dispose() {
    controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required String urlImage,
    required String subtitle,
  }) =>
      Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isFirstPage ? GestureDetector(
                  onTap: (){
                    controller.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut,
                    );
                  },
                  child: isLastPage ? Container() : Container(
                      height: 39,
                      width: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        ],
                      )
                  )
              ) : Container(),
                GestureDetector(
                    onTap: (){
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut,
                      );
                    },
                    child: isLastPage ? Container() : Container(
                        height: 39,
                        width: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.green,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
          SizedBox(width: 20,),
          const SizedBox(height:150),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Container(
                    height: 150,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      urlImage,
                      color: Colors.green.shade500,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              textAlign: TextAlign.center,
              subtitle,
              style: TextStyle(
                fontFamily: 'Acme',
                color: Colors.grey.shade900,
                fontSize: 15,
              ),
            ),
          )
        ],
      );

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return SettingsScreen();
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
              isFirstPage = index == 1;
            });
          },
          children: [
            buildPage(
              urlImage: 'assets/1.png',
              subtitle:
              '"Thrift together,Acheive more"',
            ),
            buildPage(
              urlImage: 'assets/2.png',
              subtitle: '"Fund your KudiKan wallet from any Bank"',
            ),
            buildPage(
              urlImage: 'assets/3.png',
              subtitle: '"Enjoying Seamless transactions from anywhere"',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
        margin: const EdgeInsets.all(50),
        width: double.infinity,
        height: h * 0.04,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(90, 15),
                  backgroundColor: Colors.green.shade500),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('ShowHome', true);
                _onIntroEnd(context);
              },
              child: const Text('Continue')),
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: h * 0.07,
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     TextButton(
        //         onPressed: () {
        //           controller.jumpToPage(2);
        //         },
        //         child: const Text(
        //           'Skip',
        //           style: TextStyle(color: Colors.black),
        //         )),
        //     Center(
        //         child: SmoothPageIndicator(
        //           controller: controller,
        //           count: 2,
        //           effect: WormEffect(
        //               dotHeight: 8,
        //               spacing: 12,
        //               dotColor: Colors.grey,
        //               activeDotColor: Colors.green.shade500),
        //           onDotClicked: (index) => controller.animateToPage(index,
        //               duration: const Duration(microseconds: 500),
        //               curve: Curves.bounceInOut),
        //         )),
        //     TextButton(
        //         onPressed: () {
        //           controller.nextPage(
        //             duration: const Duration(milliseconds: 500),
        //             curve: Curves.elasticOut,
        //           );
        //         },
        //         child: const Text('Next',
        //             style: TextStyle(color: Colors.black)))
        //   ],
        // ),
      ),
    );
  }
}
