import 'package:flutter/material.dart';
import 'package:pr1/presentation/widgets/text.dart';

class WordSwitch extends StatefulWidget {
  final String firstOption;
  final String secondOption;
  final ValueChanged<String> onChanged;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const WordSwitch({
    super.key,
    required this.firstOption,
    required this.secondOption,
    required this.onChanged,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black,
  });

  @override
  State<WordSwitch> createState() => _WordSwitchState();
}

class _WordSwitchState extends State<WordSwitch> {
  bool _isFirstSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // First option
          GestureDetector(
            onTap: () {
              setState(() {
                _isFirstSelected = true;
              });
              widget.onChanged(widget.firstOption);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _isFirstSelected
                    ? widget.selectedColor
                    : widget.unselectedColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
              ),
              child: MyText.text1(
                widget.firstOption,
                textColor: _isFirstSelected
                    ? widget.selectedTextColor
                    : widget.unselectedTextColor,
                fontSize: 16,
              ),
            ),
          ),

          // Divider
          Container(
            width: 1,
            height: 24,
            color: Colors.grey.shade300,
          ),

          // Second option
          GestureDetector(
            onTap: () {
              setState(() {
                _isFirstSelected = false;
              });
              widget.onChanged(widget.secondOption);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: !_isFirstSelected
                    ? widget.selectedColor
                    : widget.unselectedColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: MyText.text1(
                widget.secondOption,
                textColor: !_isFirstSelected
                    ? widget.selectedTextColor
                    : widget.unselectedTextColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
