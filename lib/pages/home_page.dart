import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isBottomSheetOpen = false;
  DraggableScrollableController dragController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();

    dragController.addListener(
      () {
        if (dragController.size > 0.12 && isBottomSheetOpen == false) {
          isBottomSheetOpen = true;
        }

        if (dragController.size == 0.12 && isBottomSheetOpen == true) {
          isBottomSheetOpen = false;
        }
      },
    );
  }

  onToggleBottomSheet() {
    if (isBottomSheetOpen) {
      dragController.animateTo(0.12,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
      isBottomSheetOpen = false;
    } else {
      dragController.animateTo(0.8,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
      isBottomSheetOpen = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DraggableScrollableSheet'),
      ),
      body: Stack(
        children: [
          Text("Filho de exemplo"),
          DraggableScrollableSheet(
            initialChildSize: 0.12,
            minChildSize: 0.12,
            maxChildSize: 0.8,
            controller: dragController,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Colors.blue,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: StickyHeader(
                    header: Container(
                      padding:
                          const EdgeInsets.only(right: 18, left: 18, top: 12),
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Resumo de algo aqui",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Descrição do resumo aq",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          OutlinedButton(
                            onPressed: onToggleBottomSheet,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.0, color: Colors.white),
                              shape: const StadiumBorder(),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  isBottomSheetOpen ? "Ver menos" : "Ver mais",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                Transform.rotate(
                                  angle: isBottomSheetOpen
                                      ? 90 * pi / 180
                                      : -90 * pi / 180,
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    content: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(children: [
                        Text("Filho de exemplo"),
                      ]),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
