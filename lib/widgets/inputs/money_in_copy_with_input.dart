// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/language/language_controller.dart';
import 'package:qrpay/utils/size.dart';
import 'package:qrpay/widgets/text_labels/title_heading4_widget.dart';

import '../../controller/categories/money_in/money_in_controller.dart';
import '../../language/english.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

class MoneyInCopyWithInput extends StatefulWidget {
  final String hint, icon, label;
  final int maxLines;
  final bool isValidator;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final Widget suffixIcon;
  final Color? suffixColor;
  final sendMoneyController = Get.put(MoneyInController());
  final languageController = Get.put(LanguageController());

  MoneyInCopyWithInput({
    Key? key,
    required this.controller,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.onTap,
    required this.suffixIcon,
    this.suffixColor,
  }) : super(key: key);

  @override
  State<MoneyInCopyWithInput> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<MoneyInCopyWithInput> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading4Widget(
          text: widget.label,
          fontWeight: FontWeight.w600,
        ),
        verticalSpace(7),
        TextFormField(
          validator: widget.isValidator == false
              ? null
              : (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
          textInputAction: TextInputAction.done,
          controller: widget.controller,
          onTap: () {
            setState(() {
              focusNode!.requestFocus();
            });
          },
          // onFieldSubmitted: (value) {
          //   if (widget
          //       .sendMoneyController.copyInputController.text.isNotEmpty) {
          //     widget.sendMoneyController.getCheckMoneyInUserExistDate();
          //   }
          //   setState(() {
          //     focusNode!.unfocus();
          //   });
          //   debugPrint("=========> user check working");
          // },
          // onTapOutside: (value) {
          //   if (widget
          //       .sendMoneyController.copyInputController.text.isNotEmpty) {
          //     widget.sendMoneyController.getCheckMoneyInUserExistDate();
          //   }
          //   setState(() {
          //     focusNode!.unfocus();
          //   });
          // },
          cursorColor: CustomColor.primaryLightColor,
          focusNode: focusNode,
          textAlign: TextAlign.left,
          style: Get.isDarkMode
              ? CustomStyle.darkHeading3TextStyle
              : CustomStyle.lightHeading3TextStyle,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.languageController.getTranslation(widget.hint),
            hintStyle: GoogleFonts.inter(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor.withValues(alpha: 0.2)
                  : CustomColor.primaryTextColor.withValues(alpha: 0.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide:
                  BorderSide(width: 2, color: Theme.of(context).primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 1.7,
              vertical: Dimensions.heightSize,
            ),
            suffixIcon: GestureDetector(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.suffixIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
