// lib/widgets/error_widget.dart

import 'package:flutter/material.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;

  const ErrorDisplayWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(
            message, 
            style: Theme.of(context).textTheme.titleLarge, // Updated this line
          ),
        ],
      ),
    );
  }
}