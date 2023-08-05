import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Use a different layout for larger screens
            return DesktopLayout();
          } else {
            // Use a default layout for smaller screens
            return MobileLayout();
          }
        },
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  const MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DesktopLayout extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container();
  }
}
