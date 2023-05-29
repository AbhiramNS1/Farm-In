import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String message;
  final VoidCallback onOkPressed;

  SuccessDialog({required this.message, required this.onOkPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 30,
              child: Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onOkPressed,
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
