import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final String text;
  final void Function() func;

  final bool isFullWidth;
  final bool isOutlined;

  const FullWidthButton({
    @required this.text,
    @required this.func,
    @required this.isFullWidth,
    @required this.isOutlined,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    List<Color> buttonColorTheme = [Colors.black, Colors.black];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        // color: Colors.deepPurple,
        borderRadius: BorderRadius.all(
          Radius.circular(6.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: buttonColorTheme,
          // <Color>[
          //   Colors.yellow,
          //   Colors.deepPurple,
          // ],
          stops: [0.2, 0.8],
        ),
      ),
      width: isFullWidth ? size.width * 0.80 : size.width * 0.55,
      height: 50,
      child: ElevatedButton(
        onPressed: func,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              isOutlined ? Colors.white : Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                  color: theme.primaryColor, width: isOutlined ? 1 : 0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width < 420
              ? isFullWidth
                  ? size.width * 0.80
                  : size.width * 0.55
              : isFullWidth
                  ? 420 * 0.80
                  : 420 * 0.55,
          height: 50,
          // height: size.height * 0.05 < 40 ? size.height * 0.05 : 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Container(
              //     width: size.width * 0.04,
              //     child: Image.asset(
              //       // 'assets/Icons/tickIcon.png',
              //       image,
              //       color: isOutlined ? theme.primaryColor : Colors.white,
              //       fit: BoxFit.contain,
              //     )),
              // SizedBox(width: 10),
              Container(
                height: 40,
                width: size.width < 420
                    ? isFullWidth
                        ? size.width * 0.75
                        : size.width * 0.45
                    : isFullWidth
                        ? 420 * 0.75
                        : 420 * 0.45,
                alignment: Alignment.center,
                child: AutoSizeText(
                  text,
                  style: theme.textTheme.headline6?.merge(TextStyle(
                      color: isOutlined ? theme.primaryColor : Colors.white,
                      fontWeight: FontWeight.normal)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
