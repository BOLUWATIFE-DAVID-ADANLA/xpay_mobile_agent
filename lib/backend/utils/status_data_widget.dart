import 'package:qrpay/utils/basic_screen_imports.dart';

class StatusDataWidget extends StatelessWidget {
  const StatusDataWidget({Key? key, required this.text, required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSize),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Get.isDarkMode
                    ? CustomColor.whiteColor.withValues(alpha:0.4)
                    : CustomColor.blackColor.withValues(alpha:0.4),
                size: Dimensions.iconSizeLarge * 1.5,
              ),
              verticalSpace(Dimensions.paddingSize * 0.3),
              TitleHeading1Widget(
                text: text,
                textAlign: TextAlign.center,
                fontSize: Dimensions.headingTextSize3,
                opacity: 0.4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
