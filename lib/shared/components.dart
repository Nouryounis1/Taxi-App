import 'package:flutter/material.dart';
import 'package:taxi_app/style/colors.dart';

class TaxiOutlineButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color color;

  TaxiOutlineButton(
      {required this.title, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      color: color,
      textColor: Colors.white,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18.0, fontFamily: 'Brand-Bold'),
      ),
    );
  }
}

class ProgressDialog extends StatelessWidget {
  final String status;

  const ProgressDialog({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(BrandColors.colorAccent),
              ),
              const SizedBox(
                width: 25.0,
              ),
              Text(
                status,
                style: const TextStyle(fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BrandDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Color(0xFFe2e2e2),
      thickness: 1.0,
    );
  }
}
