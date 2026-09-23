import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../shared/shared_color.dart';
import '../shared/shared_font.dart';

class CustomAlert {
  // Loading Dialog
  static Future<void> showLoading(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: 120,
            height: 120,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Center(
                child: Wrap(
                  children: [
                    SpinKitThreeBounce(
                      color: AppColor.mainColor,
                      size: 25,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Loading ...",
                        textAlign: TextAlign.center,
                        style: AppFonts.normalText.copyWith(
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Success Dialog
  static Future<void> showSuccess(
    BuildContext context, {
    required String message,
    VoidCallback? onClose,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.mainColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: 200,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.done_rounded, size: 50, color: AppColor.mainColor),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      height: 1.5,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onClose != null) onClose();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Error / Fail Dialog
  static Future<void> showError(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: 200,
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error, size: 50, color: Colors.red),
                  const SizedBox(height: 10),
                  if (title.isNotEmpty) ...[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      height: 1.5,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onConfirm != null) onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Yes/No Confirmation Dialog
  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String message,
    String negativeText = 'Tidak',
    String positiveText = 'Ya',
    VoidCallback? onPositive,
    VoidCallback? onNegative,
  }) async {
    final result = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.mainColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: 200,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning, size: 50, color: AppColor.mainColor),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      height: 1.5,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            if (onNegative != null) onNegative();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                          ),
                          child: Text(negativeText),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            if (onPositive != null) onPositive();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(positiveText),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    
    return result;
  }

  // Simple Info Dialog (tanpa tombol, auto close)
  static Future<void> showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onClose,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(duration, () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
            if (onClose != null) onClose();
          }
        });
        
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          insetPadding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.mainColor),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            width: 200,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline, size: 50, color: AppColor.mainColor),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      height: 1.5,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Hide loading dialog
  static void hideLoading(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}