import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.color,
  });
  final Color? color;
  final bool isLoading;
  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: isLoading ? null : onPressed,
      color: color ?? AppColors.purplePrimary,
      disabledColor: AppColors.purplePrimary.withValues(alpha: .5),
      child: AnimatedCrossFade(
        firstChild: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        secondChild: const CupertinoActivityIndicator(color: AppColors.black),
        crossFadeState: isLoading
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
