import 'package:expenso/screens/each_category/education.dart';
import 'package:expenso/screens/each_category/ent.dart';
import 'package:expenso/screens/each_category/health.dart';
import 'package:expenso/screens/each_category/others.dart';
import 'package:expenso/screens/each_category/transportation.dart';
import 'package:expenso/screens/each_category/utilities_screen.dart';
import 'package:expenso/utils/Category_colors.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  void navigateToUtility() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => UtilityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/Component 1.png',
          width: 150,
          height: 150,
        ),
        elevation: 0,
        backgroundColor: AppColors.purpleG,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 24),
              height: size.height / 4,
              width: size.width,
              decoration: const BoxDecoration(color: AppColors.purpleG),
              child: const SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
              height: size.height - (size.height / 4),
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: const Color.fromARGB(255, 208, 207, 207),
                          ),
                          child: const Text(
                            'Choose Your Category',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        // Container(
                        //   padding: EdgeInsets.all(0),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(13),
                        //       color: const Color.fromARGB(255, 208, 207, 207)),
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.add,
                        //       size: 20,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: navigateToUtility,
                                child: const CategoryCard(
                                  title: 'Utilities',
                                  background: AppColors.pink,
                                  image: 'assets/images/image2.png',
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Education(),
                                  ),
                                ),
                                child: const ShortBottomCatCard(
                                    background: AppColors.orange,
                                    title: 'Education',
                                    image: 'assets/images/education.png'),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Entertainment(),
                                  ),
                                ),
                                child: const ShortTopCatCard(
                                    background: AppColors.red,
                                    title: 'Entertainment',
                                    image: 'assets/images/ent.png'),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TransportationScreen(),
                                  ),
                                ),
                                child: const ShortTopCatCard(
                                    background: AppColors.green,
                                    title: 'Transportation',
                                    image: 'assets/images/transport.png'),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Health(),
                                  ),
                                ),
                                child: const CategoryCard(
                                    background: AppColors.purple,
                                    image: 'assets/images/h1.png',
                                    title: 'Health'),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Others(),
                                  ),
                                ),
                                child: const ShortBottomCatCard(
                                    background: AppColors.green,
                                    title: 'others',
                                    image: 'assets/images/other.png'),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Color background;
  final String title;

  final String image;

  const CategoryCard(
      {super.key,
      required this.background,
      required this.image,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 192,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Image.asset(
              image,
              scale: 0.5,
            ),
          )
        ],
      ),
    );
  }
}

class ShortTopCatCard extends StatelessWidget {
  final Color background;
  final String title;
  final String image;
  const ShortTopCatCard(
      {Key? key,
      required this.background,
      required this.title,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 163,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 16),
        Text(title,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        Expanded(child: Image.asset(image)),
      ]),
    );
  }
}

class ShortBottomCatCard extends StatelessWidget {
  final Color background;
  final String title;
  final String image;
  const ShortBottomCatCard(
      {Key? key,
      required this.background,
      required this.title,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 163,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
        Expanded(child: Image.asset(image)),
        const SizedBox(height: 12),
      ]),
    );
  }
}
