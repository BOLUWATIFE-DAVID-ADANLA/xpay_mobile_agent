import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/language/language_controller.dart';
import 'package:qrpay/utils/size.dart';

import '../../backend/model/wallet/wallets_model.dart';
import '../../controller/categories/send_money/send_money_controller.dart';
import '../../language/english.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';
import '../text_labels/title_heading4_widget.dart';
import 'decimal_input_formater.dart';

class SendMoneyInputWithDropdown extends StatefulWidget {
  final String hint, icon, label;
  final int maxLines;
  final bool isValidator;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  final Rxn<MainUserWallet> selectWallet;

  const SendMoneyInputWithDropdown({
    Key? key,
    required this.controller,
    required this.hint,
    this.icon = "",
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    required this.selectWallet,
  }) : super(key: key);

  @override
  State<SendMoneyInputWithDropdown> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<SendMoneyInputWithDropdown> {
  FocusNode? focusNode;
  final currencyController = Get.put(SendMoneyController());

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

  final languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading4Widget(
          text: widget.label,
          fontWeight: FontWeight.w600,
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
        Row(
          children: [
            Expanded(
              flex: 9,
              child: TextFormField(
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
                onChanged: (v) {
                  if (widget.label == Strings.senderAmount) {
                    if (v.isNotEmpty && v.length > 1 && v.startsWith('0')) {
                      widget.controller.text =
                          v.replaceFirst(RegExp(r'^0+'), '');
                      widget.controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: widget.controller.text.length),
                      );
                    }

                    currencyController.updateExchangeRate();
                    currencyController.getReceiverAmount();

                    if (currencyController
                        .senderAmountController.text.isEmpty) {
                      currencyController.senderAmountController.text = "";
                    } else {
                      currencyController
                              .remainingController.senderAmount.value =
                          currencyController.senderAmountController.text;
                      currencyController.remainingController
                          .getRemainingBalanceProcess();
                    }
                  } else {
                    currencyController.updateExchangeRate();
                    currencyController.getSenderAmount();
                  }
                  currencyController.getFee(
                    rate: double.parse(currencyController
                        .selectSenderWallet.value!.currency.rate),
                  );
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    focusNode!.unfocus();
                  });
                },
                cursorColor: CustomColor.primaryLightColor,
                focusNode: focusNode,
                textAlign: TextAlign.left,
                style: Get.isDarkMode
                    ? CustomStyle.darkHeading3TextStyle
                    : CustomStyle.lightHeading3TextStyle,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                maxLines: widget.maxLines,
                decoration: InputDecoration(
                  hintText: languageController.getTranslation(widget.hint),
                  hintStyle: GoogleFonts.inter(
                    fontSize: Dimensions.headingTextSize3,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor
                            .withValues(alpha: 0.2)
                        : CustomColor.primaryTextColor.withValues(alpha: 0.2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.5),
                    borderSide: BorderSide(
                      color:
                          CustomColor.primaryLightColor.withValues(alpha: 0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.5),
                    borderSide: const BorderSide(
                        width: 2, color: CustomColor.primaryLightColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.5),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.5),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widthSize * 1.7,
                    vertical: Dimensions.heightSize,
                  ),
                  suffixIcon: Container(
                    height: Dimensions.inputBoxHeight,
                    padding: EdgeInsets.only(left: Dimensions.widthSize * 0.5),
                    alignment: Alignment.centerRight,
                    width: isTablet()
                        ? Dimensions.widthSize * 6
                        : Dimensions.widthSize * 7.5,
                    decoration: BoxDecoration(
                        color: CustomColor.primaryLightColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius * 0.5),
                          bottomRight: Radius.circular(Dimensions.radius * 0.5),
                        )),
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: DropdownButton<MainUserWallet>(
                          hint: Text(
                            widget.selectWallet.value!.currency.code,
                            style: GoogleFonts.inter(
                              color: CustomColor.whiteColor,
                              fontSize: Dimensions.headingTextSize4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          menuMaxHeight:
                              MediaQuery.sizeOf(context).height * 0.6,
                          iconEnabledColor: CustomColor.whiteColor,
                          iconSize: Dimensions.heightSize * 1.5,
                          dropdownColor: CustomColor.primaryLightColor,
                          underline: Container(),
                          items: currencyController.walletsList
                              .map<DropdownMenuItem<MainUserWallet>>(
                            (value) {
                              return DropdownMenuItem<MainUserWallet>(
                                value: value,
                                child: Text(
                                  value.currency.code,
                                  style: GoogleFonts.inter(
                                    color: CustomColor.whiteColor,
                                    fontSize: Dimensions.headingTextSize4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (MainUserWallet? value) {
                            widget.selectWallet.value = value!;

                            currencyController.updateExchangeRate();

                            if (widget.label == Strings.senderAmount) {
                              currencyController.selectedWalletIndex.value =
                                  currencyController.walletsList
                                      .indexWhere((wallet) => wallet == value);
                              currencyController.remainingController
                                  .senderCurrency.value = value.currency.code;
                              currencyController.remainingController
                                  .getRemainingBalanceProcess();
                              currencyController.getReceiverAmount();
                            } else {
                              currencyController.getReceiverAmount();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
