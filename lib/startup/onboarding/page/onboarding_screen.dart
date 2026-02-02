// import 'package:app/core/shared/imports.dart';
// import 'package:app/feature/account/presentation/views/login_screen.dart';
// import 'package:app/startup/onboarding/widget/onboarding_widget.dart';
// import 'package:app/widgets/button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   PageController pageController = PageController();
//   ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);
//   _onHome() {
//     context.toAndRemove(const LoginScreen(isFromTabScreen: false));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion(
//       value: const SystemUiOverlayStyle(statusBarColor: Color(0XFFcfd5dd)),
//       child: Scaffold(
//           body: Stack(
//         children: [
//           Assets.images.introTop.image(
//             width: context.width + 50,
//             height: 200.h,
//             fit: BoxFit.cover,
//           ),
//           _createPageView(pageController),
//           Positioned(bottom: -20.h, child: _createStatic())
//         ],
//       )),
//     );
//   }

//   Widget _createPageView(PageController controller) {
//     return PageView(
//       scrollDirection: Axis.horizontal,
//       controller: controller,
//       children: [
//         OnboardingWidget(
//           imageSize: context.width - 100,
//           title: Trans.introTitle1.trans(context: context),
//           mainText: Trans.introDesc1.trans(context: context),
//           imagePath: Assets.images.logo.path,
//         ),
//         OnboardingWidget(
//           imageSize: context.width - 100,
//           title: Trans.introTitle2.trans(context: context),
//           mainText: Trans.introDesc2.trans(context: context),
//           imagePath: Assets.images.logo.path,
//         ),
//         OnboardingWidget(
//           imageSize: context.width - 100,
//           title: Trans.introTitle3.trans(context: context),
//           mainText: Trans.introDesc3.trans(context: context),
//           imagePath: Assets.images.logo.path,
//         ),
//       ],
//       onPageChanged: (indexx) {
//         indexNotifier.value = indexx;
//       },
//     );
//   }

//   Widget _createStatic() {
//     return SizedBox(
//       width: context.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: SmoothPageIndicator(
//                 controller: pageController,
//                 count: 3,
//                 textDirection: Directionality.of(context),
//                 effect: ExpandingDotsEffect(
//                     activeDotColor: context.primaryColor,
//                     dotWidth: 8,
//                     dotHeight: 8,
//                     strokeWidth: 5),
//               )),
//           const SizedBox(height: kIndent * 2),
//           Container(
//             height: 60,
//             padding: const EdgeInsets.only(left: kIndent, right: kIndent),
//             child: ValueListenableBuilder(
//               valueListenable: indexNotifier,
//               builder: (context, index, child) {
//                 // if (index == 0) {
//                 //   return IgnorePointer(
//                 //     ignoring: true,
//                 //     child: Opacity(
//                 //       opacity: 0,
//                 //       child: GeneralButton(
//                 //         radius: 10,
//                 //         onTap: () {
//                 //           _onHome();
//                 //         },
//                 //         text: Trans.explore.trans(),
//                 //       ),
//                 //     ),
//                 //   );
//                 // }

//                 return SizedBox(
//                   width: context.width,
//                   key: const Key('onboarding_buttons'),
//                   height: 60,
//                   child: Stack(
//                     alignment: AlignmentDirectional.center,
//                     children: [
//                       AnimatedPositionedDirectional(
//                           key: const Key('onboarding_skip'),
//                           start: [1, 2].contains(index) ? 0 : -100,
//                           duration: const Duration(milliseconds: 200),
//                           child: InkWell(
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: 100,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 20),
//                               child: Text(
//                                 Trans.skip.trans(),
//                                 style: const TextStyle(
//                                     color: Color(0XFF95969D), fontSize: 16),
//                               ),
//                             ),
//                             onTap: () {
//                               _onHome();
//                             },
//                           )),
//                       AnimatedPositionedDirectional(
//                         end: [1, 2].contains(index) ? 0 : -100,
//                         key: const Key('onboarding_next'),
//                         duration: const Duration(milliseconds: 200),
//                         child: GeneralButton(
//                           radius: 10,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 12, horizontal: 20),
//                           onTap: () {
//                             pageController.nextPage(
//                                 duration: const Duration(milliseconds: 500),
//                                 curve: Curves.easeIn);
//                           },
//                           text: Trans.next.trans(),
//                         ),
//                       ),
//                       AnimatedPositionedDirectional(
//                         key: const Key('onboarding_explore'),
//                         top: index == 2 ? 0 : 100,
//                         duration: const Duration(milliseconds: 200),
//                         child: GeneralButton(
//                           width: context.width - 35,
//                           radius: 10,
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 14, horizontal: 20),
//                           onTap: () {
//                             _onHome();
//                           },
//                           text: Trans.explore.trans(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }
