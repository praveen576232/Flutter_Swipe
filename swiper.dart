library swiper;

import 'package:flutter/material.dart';

import 'swipingButton/AnimatedText/animated_text.dart';
import 'swipingButton/controller/controller.dart';

typedef SwipingButtonController = Function(SwipeController);

class SwipingButton extends StatefulWidget {
  const SwipingButton(
      {Key? key,
      required this.thumbWidth,
      required this.size,
      this.onSwipeComplete,
      this.validateOnScroll,
      this.swipingButtonController,
      this.text = "",
      this.textStyle = const TextStyle(color: Colors.grey),
      this.turnOfAnimation = false,
      this.textAnimationDuration = const Duration(milliseconds: 1000),
      this.thumbBorderRadius = 50,
      this.thumbColor = Colors.white,
      this.swipedBgColor = Colors.green,
      this.borderRadius = 50,
      this.thumbChild = const Center(
        child: Icon(Icons.fast_forward),
      ),
  
      this.boxShadow = const [
        BoxShadow(
            color: Colors.grey,
            offset: Offset(-3, -3),
            blurRadius: 8,
            spreadRadius: 8),
        BoxShadow(
            color: Colors.grey,
            offset: Offset(4, 4),
            blurRadius: 8,
            spreadRadius: 8)
      ],
      this.thumbBoxShadow = const [
        BoxShadow(color: Colors.black, blurRadius: 1, spreadRadius: 0),
        BoxShadow(color: Colors.white, blurRadius: 10, spreadRadius: 5),
      ],
      this.textGradientColor = const [
        Colors.grey,
        Colors.white,
      ],
      this.bgColor =  Colors.white,
      this.thumbBorder = const Border.fromBorderSide(
        BorderSide(color: Colors.black12),
      )})
      : super(key: key);
  final VoidCallback? onSwipeComplete;
  final bool Function()? validateOnScroll;
  final SwipingButtonController? swipingButtonController;
  final Size size;
  final String text;
  final TextStyle textStyle;
  final bool turnOfAnimation;
  final Duration textAnimationDuration;
  final List<Color> textGradientColor;
  final double thumbBorderRadius;
  final Color thumbColor;
  final double borderRadius;

  final Color swipedBgColor;
  final List<BoxShadow> boxShadow;
  final List<BoxShadow> thumbBoxShadow;
  final Widget thumbChild;
  final double thumbWidth;
  final Border thumbBorder;
  final Color bgColor;
  @override
  _SwipingButtonState createState() => _SwipingButtonState();
}

class _SwipingButtonState extends State<SwipingButton> {
  double sweep = .02;
  late double size;
  bool _lock = false;
  bool _callInitialCallBackOnlyOneTime = false;
  bool _onSwipeCalled = false;
  final SwipeController _swipeController = SwipeController();
  @override
  void initState() {
    size = widget.size.width;
    if (widget.swipingButtonController != null) {
      widget.swipingButtonController!(_swipeController);
    }

    _swipeController.addListener(() {
      setState(() {
        _onSwipeCalled = false;
        sweep = 0.02;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _swipeController.removeListener(() {});
    _swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: widget.size.width,
        height: widget.size.height,
        //   padding:const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color:widget.bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              boxShadow: widget.boxShadow),
        ),
      ),
      Positioned(
          right: 30,
          top: 20,
          child: AnimatedText(
            text: widget.text,
            textAnimationDuration: widget.textAnimationDuration,
            textGradientColor: widget.textGradientColor,
            textStyle: widget.textStyle,
            turnOfAnimation: widget.turnOfAnimation,
          )),
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: ((size) * sweep) + widget.thumbWidth,
        height: widget.size.height,
        decoration: BoxDecoration(
            color: widget.swipedBgColor,
            borderRadius: BorderRadius.circular(widget.borderRadius)),
      ),
      AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        left: (size) * sweep,
        bottom: 2,
        child: GestureDetector(
          onPanUpdate: (d) {
            //  if (sweep >= 0.85 && !_onSwipeCalled) {
            //     print("ENTER1");
            //     if (!_lock) {
            //        print("ENTER2");
            //       if (widget.onSwipe != null) {
            //          print("ENTER3");
            //         _onSwipeCalled = true;

            //         widget.onSwipe!();

            //           setState(() {
            //           sweep =1.0;
            //       });
            //         _onSwipeCalled = false;

            //       } else {
            //       setState(() {
            //           sweep = 0.02;
            //       });
            //       }
            //     }
            //   }else{

            setState(() {
              // print(d.localPosition.dx / context.size!.width);
              sweep = (d.localPosition.dx) / (context.size!.width);
              // print(sweep.toString() +  "     " +  _lock.toString());
              if (sweep < 0) {
                sweep = 0.02;
              }
              if (sweep > 1) {
                sweep = 1.0;
              }

              if (sweep > 0.55 && !_callInitialCallBackOnlyOneTime) {
                bool _validate = true;
                if (widget.validateOnScroll != null) {
                  _validate = widget.validateOnScroll!();
                }
                if (!_validate) {
                  _lock = true;
                  sweep = 0.02;
                } else {
                  if (_lock) {
                    _lock = false;
                  }
                }
              }
            });
            // }
          },
          onPanEnd: (d) {
            _callInitialCallBackOnlyOneTime = false;
            setState(() {
              if (sweep < 0.7) {
                sweep = 0.02;
              } else {
                if (_lock) {
                  sweep = 0.02;
                } else {
                  sweep = 1.0;
                  if (!_onSwipeCalled) {
                    _onSwipeCalled = true;
                    if (widget.onSwipeComplete != null) {
                      widget.onSwipeComplete!();
                    }
                  }
                }
              }
            });
          },
          child: Center(
            child: Container(
              alignment: Alignment.center,
              width: widget.thumbWidth,
              height: widget.size.height-8,
              margin: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                color: widget.thumbColor,
                borderRadius: BorderRadius.circular(widget.thumbBorderRadius),

                border: widget.thumbBorder,
                //  shape: BoxShape.circle,
                boxShadow: widget.thumbBoxShadow,
              ),
              child: widget.thumbChild,
            ),
          ),
        ),
      ),
    ]);
  }
}
