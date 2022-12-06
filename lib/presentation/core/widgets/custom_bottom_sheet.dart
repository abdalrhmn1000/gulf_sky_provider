import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final List<Widget> options;
  final double bottomSheetHeight;
  final Widget? message;

  const CustomBottomSheet({
    Key? key,
    required this.options,
    this.bottomSheetHeight = 175.0, // for 2 option right now
    this.message,
  }) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.bottomSheetHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
            child: Container(
              width: 75,
              height: 5,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
            ),
          ),
          const SizedBox(height: 6.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  widget.message != null
                      ? Column(
                          children: [
                            widget.message!,
                            const Divider(),
                          ],
                        )
                      : Container(),
                  widget.message != null
                      ? const SizedBox(
                          height: 6.0,
                        )
                      : Container(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.options.length, (index) {
                      return widget.options[index];
                    }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
