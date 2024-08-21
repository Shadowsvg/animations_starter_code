import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Animation<Offset>> slideAnimationList;

  final itemCount = 5;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    // slideAnimation = Tween<Offset>(
    //   begin: const Offset(-1, 0),
    //   end: Offset.zero,
    // ).animate(controller);

    slideAnimationList = List.generate(
      itemCount,
      (index) =>
          Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 1))
              .animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(index * (1 / itemCount), 1),
        ),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SlideTransition(
            // textDirection: TextDirection.ltr,
            position: slideAnimationList[index],
            child: ListTile(
              title: Text('Hello World, Rivaan. ${index.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
