import 'dart:ui';

import 'package:banking_app_ui/config/config.dart';
import 'package:banking_app_ui/model/credit_card.dart';
import 'package:banking_app_ui/model/transaction.dart';
import 'package:banking_app_ui/presentation/screens/statics_screen.dart';
import 'package:banking_app_ui/presentation/widgets/chart.dart';
import 'package:banking_app_ui/presentation/widgets/rainbow_circle_widget.dart';
import 'package:banking_app_ui/presentation/widgets/transaction_item_widget.dart';
import 'package:banking_app_ui/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:motion/motion.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool _expand = true;
  int _currentTabIndex = 0;
  double _cardDY = MIN_CARD_TOP_DISTANCE;
  static double MAX_CARD_TOP_DISTANCE = 0;
  static double MIN_CARD_TOP_DISTANCE = 96;

  int _selectedCardIndex = 0;

  late AnimationController animationController;
  late Animation<double> animation;

  final cards = [
    CreditCard(
        cardNumber: "6104 3355 5688 9231",
        cardBalance: 1525,
        date: "7/14",
        color1: const Color(0xffFA5D55),
        color2: const Color(0xffF5B367),
        color3: const Color(0xffF68966)),
    CreditCard(
        cardNumber: "6104 3375 4125 3697",
        cardBalance: 250,
        date: "8/01",
        color1: const Color(0xff7955fa),
        color2: const Color(0xff6c67f5),
        color3: const Color(0xff6688f6)),
    CreditCard(
        cardNumber: "6104 3381 4654 3364",
        cardBalance: 3940,
        date: "10/29",
        color1: const Color(0xff55fa58),
        color2: const Color(0xff75f567),
        color3: const Color(0xffa7f666)),
  ];

  final transactions = [
    Transaction("Pasibus", "Food", 29.92, Icons.bus_alert_sharp),
    Transaction("Cinema City", "Entertainment", 20.00,
        Icons.video_camera_back_outlined),
  ];

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutSine,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          if (_cardDY == MAX_CARD_TOP_DISTANCE) {
            setState(() {
              _cardDY = MIN_CARD_TOP_DISTANCE;
              animationController.reverse();
            });
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
            child: Scaffold(
                bottomNavigationBar: Container(
                  height: 64,
                  color: darkSurfaceColor,
                  child: Stack(
                    children: [
                      BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: _currentTabIndex,
                          showSelectedLabels: false,
                          elevation: 0,
                          backgroundColor: darkSurfaceColor,
                          selectedItemColor: primaryColor,
                          unselectedItemColor: Colors.grey,
                          onTap: (index) {
                            setState(() {
                              _currentTabIndex = index;
                            });
                          },
                          items: [
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.home_filled,
                                color: (_currentTabIndex == 0)
                                    ? primaryColor.withOpacity(0.7)
                                    : Colors.grey,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.photo_size_select_small_rounded,
                                color: (_currentTabIndex == 1)
                                    ? primaryColor.withOpacity(0.7)
                                    : Colors.grey,
                              ),
                              label: '',
                            ),
                            const BottomNavigationBarItem(
                              icon: Icon(
                                Icons.wallet,
                                color: Colors.transparent,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.wallet,
                                color: (_currentTabIndex == 3)
                                    ? primaryColor.withOpacity(0.7)
                                    : Colors.grey,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(
                                Icons.menu,
                                color: (_currentTabIndex == 4)
                                    ? primaryColor.withOpacity(0.7)
                                    : Colors.grey,
                              ),
                              label: '',
                            ),
                          ]),
                      Container(
                        transform: Matrix4.translationValues(
                            size.width / 2 - 28.0, -16.0, .0),
                        height: 64,
                        width: 64,
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: darkSurfaceColor),
                        child: CustomPaint(
                          painter: RainbowCircleWidget(
                            strokeWidth: 2,
                            radius: 72,
                            gradient: const LinearGradient(
                              colors: [
                                Colors.yellow,
                                Colors.red,
                                Colors.lightBlueAccent,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: const Icon(Icons.document_scanner),
                        ),
                      ),
                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: mediumDistance,
                            vertical: smallDistance),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: smallDistance,
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Your cards',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(largeRadius),
                                  child: Image.asset(
                                    "assets/images/profile_image.jpg",
                                    height: 48,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: xLargeDistance,
                            ),
                            AnimatedContainer(
                                width: size.width - 32,
                                duration: const Duration(milliseconds: 300),
                                height: _expand ? 184 : 96,
                                child: Container()),
                            const SizedBox(
                              height: xLargeDistance,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2, child: _buildChartWidget(size)),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: size.width / 2 - 56,
                                      margin: const EdgeInsets.only(
                                          right: smallDistance),
                                      decoration: const BoxDecoration(
                                          color: darkSurfaceColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(mediumRadius))),
                                      padding:
                                          const EdgeInsets.all(largeDistance),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 56,
                                            width: 56,
                                            child: CustomPaint(
                                              painter: RainbowCircleWidget(
                                                strokeWidth: 2,
                                                radius: 72,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.yellow,
                                                    Colors.red,
                                                    Colors.lightBlueAccent,
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                              child: const Icon(
                                                  Icons.account_tree),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: smallDistance,
                                          ),
                                          const Text(
                                            'Summary',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: largeDistance,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Transactions',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: mediumDistance,
                                      ),
                                      Text(
                                        '25.10',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                Icon(Icons.search),
                              ],
                            ),
                            const SizedBox(
                              height: mediumDistance,
                            ),
                            Expanded(
                              child: _buildTransactionList(size),
                            ),
                          ],
                        )),
                    CircularRevealAnimation(
                        centerOffset: Offset(size.width / 2, 150),
                        animation: animation,
                        child: Visibility(
                            visible: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                opacity:
                                    (_cardDY == MIN_CARD_TOP_DISTANCE) ? 0 : 1,
                                child: Container(
                                  height: size.height,
                                  width: size.width,
                                  color: cards[_selectedCardIndex].color1,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top: 100,
                                          left: 150,
                                          child: Motion(
                                              translation:
                                                  TranslationConfiguration
                                                      .fromElevation(30),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(144)),
                                              glare: GlareConfiguration
                                                  .fromElevation(0),
                                              shadow: ShadowConfiguration
                                                  .fromElevation(5),
                                              child: Container(
                                                  height: 144,
                                                  width: 144,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        cards[_selectedCardIndex]
                                                            .color1,
                                                        cards[_selectedCardIndex]
                                                            .color2,
                                                        cards[_selectedCardIndex]
                                                            .color3,
                                                      ],
                                                    ),
                                                  )))),
                                      Positioned(
                                          top: 100,
                                          left: -100,
                                          child: Motion(
                                              translation:
                                                  TranslationConfiguration
                                                      .fromElevation(-15),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(300)),
                                              glare: GlareConfiguration
                                                  .fromElevation(0),
                                              shadow: ShadowConfiguration
                                                  .fromElevation(100),
                                              child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        cards[_selectedCardIndex]
                                                            .color1,
                                                        cards[_selectedCardIndex]
                                                            .color2,
                                                        cards[_selectedCardIndex]
                                                            .color3,
                                                      ],
                                                    ),
                                                  )))),
                                      Positioned(
                                          bottom: -100,
                                          right: -100,
                                          child: Motion(
                                              translation:
                                                  TranslationConfiguration
                                                      .fromElevation(-15),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(300)),
                                              glare: GlareConfiguration
                                                  .fromElevation(0),
                                              shadow: ShadowConfiguration
                                                  .fromElevation(100),
                                              child: Container(
                                                  height: 350,
                                                  width: 350,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                      colors: [
                                                        cards[_selectedCardIndex]
                                                            .color1,
                                                        cards[_selectedCardIndex]
                                                            .color2,
                                                        cards[_selectedCardIndex]
                                                            .color3,
                                                      ],
                                                    ),
                                                  )))),
                                    ],
                                  ),
                                )))),
                    AnimatedPositioned(
                        top: _cardDY,
                        duration: const Duration(milliseconds: 300),
                        child: AnimatedContainer(
                            width: size.width,
                            duration: const Duration(milliseconds: 300),
                            height: (_cardDY == MIN_CARD_TOP_DISTANCE)
                                ? _expand
                                    ? 184
                                    : 96
                                : size.height,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                initialPage: 0,
                                height: 450,
                                viewportFraction: 1,
                                enlargeFactor: 0.4,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _selectedCardIndex = index;
                                  });
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                              items: cards.map((card) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onPanUpdate: (details) {
                                        if (details.delta.dy > 0) {
                                          setState(() {
                                            _cardDY = MAX_CARD_TOP_DISTANCE;
                                            animationController.forward();
                                          });
                                        } else if (details.delta.dy < 0 &&
                                            _cardDY == MAX_CARD_TOP_DISTANCE) {
                                          setState(() {
                                            _cardDY = MIN_CARD_TOP_DISTANCE;
                                            animationController.reverse();
                                          });
                                        }
                                      },
                                      child: AnimatedContainer(
                                        width: size.width - 32,
                                        height:
                                            (_cardDY == MIN_CARD_TOP_DISTANCE)
                                                ? _expand
                                                    ? 184
                                                    : 96
                                                : 450,
                                        padding: EdgeInsets.all(
                                            (_cardDY == MIN_CARD_TOP_DISTANCE)
                                                ? 0
                                                : mediumDistance),
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: (_cardDY ==
                                                MIN_CARD_TOP_DISTANCE)
                                            ? _buildCardLayout(card)
                                            : Motion(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        mediumRadius),
                                                glare: GlareConfiguration
                                                    .fromElevation(15),
                                                translation:
                                                    TranslationConfiguration
                                                        .fromElevation(100),
                                                shadow: ShadowConfiguration
                                                    .fromElevation(100),
                                                child: _buildCardLayout(card)),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ))),
                  ],
                ))));
  }

  Widget _buildCardLayout(CreditCard card) {
    return Stack(
      children: [
        (_cardDY == MIN_CARD_TOP_DISTANCE)
            ? Container(
                decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(mediumRadius)),
                gradient: LinearGradient(colors: [
                  card.color1,
                  card.color2,
                  card.color3,
                  // Color(0xffFA5D55),
                  // Color(0xffF68966),
                  // Color(0xffF5B367)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ))
            : Container(
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(mediumRadius)),
                    color: Colors.white.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24,
                        spreadRadius: 5,
                        offset: const Offset(0, 0),
                        color: Colors.white.withOpacity(0.25),
                      )
                    ]),
              ),
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(mediumRadius)),
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: (_cardDY == MIN_CARD_TOP_DISTANCE) ? .0 : 150,
                  sigmaY: (_cardDY == MIN_CARD_TOP_DISTANCE) ? .0 : 100,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(mediumRadius)),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: (_cardDY == MIN_CARD_TOP_DISTANCE) ? 0 : 0.8)),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          left: mediumDistance,
                          top: (_cardDY == MIN_CARD_TOP_DISTANCE)
                              ? (_expand)
                                  ? mediumDistance
                                  : -largeDistance
                              : mediumDistance,
                          child: const Icon(Icons.sim_card)),
                      AnimatedPositioned(
                        top: (_expand) ? mediumDistance : 32,
                        right: mediumDistance,
                        duration: const Duration(milliseconds: 200),
                        child: const Text(
                          'VISA',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ),
                      AnimatedPositioned(
                        bottom: (_cardDY == MIN_CARD_TOP_DISTANCE)
                            ? (_expand)
                                ? largeDistance
                                : -largeDistance
                            : largeDistance,
                        right: mediumDistance,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          card.date,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ),
                      AnimatedPositioned(
                          left: mediumDistance,
                          bottom: (_cardDY == MIN_CARD_TOP_DISTANCE)
                              ? (_expand)
                                  ? 88
                                  : 96
                              : 144,
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            card.cardNumber,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )),
                      Positioned(
                          left: mediumDistance,
                          bottom: largeDistance,
                          child: Text.rich(
                            TextSpan(
                              text: "\$ ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 32),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${card.cardBalance}',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                )))
      ],
    );
  }

  Widget _buildTransactionList(Size size) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final ScrollDirection direction = notification.direction;
        setState(() {
          if (direction == ScrollDirection.reverse && _expand) {
            _expand = false;
          } else if (direction == ScrollDirection.forward && !_expand) {
            final metrics = notification.metrics;
            if (metrics.atEdge) {
              bool isTop = metrics.pixels == 0;
              if (isTop) {
                _expand = true;
              }
            }
          }
        });
        return true;
      },
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (_, i) => Container(
          padding: const EdgeInsets.symmetric(horizontal: mediumDistance),
          decoration: BoxDecoration(
              color: darkSurfaceColor,
              borderRadius: (i == 0)
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(mediumRadius),
                      topRight: Radius.circular(mediumRadius))
                  : (i == transactions.length - 1)
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(mediumRadius),
                          bottomRight: Radius.circular(mediumRadius))
                      : const BorderRadius.all(
                          Radius.circular(0),
                        )),
          child: Column(
            children: [
              TransactionItemWidget(
                transaction: transactions[i],
              ),
              if (i != transactions.length - 1)
                Container(
                  height: 1,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(1)),
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Colors.grey.withOpacity(0.3),
                            Colors.grey.withOpacity(0.6),
                            Colors.grey.withOpacity(0.3),
                          ])),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartWidget(Size size) {
    return GestureDetector(
      onTap: () {
        push(context, const StaticsScreen());
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(mediumRadius)),
        child: Container(
          height: size.width / 2 - 56,
          decoration: const BoxDecoration(
              color: darkSurfaceColor,
              borderRadius: BorderRadius.all(Radius.circular(mediumRadius))),
          margin: const EdgeInsets.only(right: smallDistance),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding:
                    EdgeInsets.only(top: mediumDistance, left: mediumDistance),
                child: Text(
                  'This month',
                  style: TextStyle(color: Colors.grey),
                )),
            const SizedBox(
              height: 4,
            ),
            const Padding(
                padding: EdgeInsets.only(left: mediumDistance),
                child: Text(
                  '-1256,4 PLN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )),
            Hero(
              tag: 'chart 0',
              child: LineChartSample2(
                aspectRatio: 3,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
