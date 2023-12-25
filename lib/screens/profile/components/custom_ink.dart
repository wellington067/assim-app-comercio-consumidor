import 'package:ecommerceassim/shared/constants/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceassim/components/utils/horizontal_spacer_box.dart';
import 'package:ecommerceassim/components/utils/vertical_spacer_box.dart';
import 'package:ecommerceassim/shared/constants/style_constants.dart';

class CustomInkWell extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;

  const CustomInkWell({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.width = 480,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: kOnSurfaceColor,
              boxShadow: [
                BoxShadow(
                  color: kTextButtonColor.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Wrap(
                children: [
                  const VerticalSpacerBox(size: SpacerSize.large),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HorizontalSpacerBox(size: SpacerSize.large),
                      Icon(
                        icon,
                        size: 32,
                        color: kDetailColor,
                      ),
                      const HorizontalSpacerBox(size: SpacerSize.medium),
                      Text(
                        text,
                        style: const TextStyle(
                            fontSize: 21, color: kTextButtonColor),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
