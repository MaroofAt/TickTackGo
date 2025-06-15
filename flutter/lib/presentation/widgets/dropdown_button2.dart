import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MyDropDownButton2 extends StatefulWidget {
  String? selectedValue;
  List<String> items;
  Function(String? value)? onChanged;

  MyDropDownButton2(this.items, this.selectedValue,
      {this.onChanged, super.key});

  @override
  State<MyDropDownButton2> createState() => _MyDropDownButton2State();
}

class _MyDropDownButton2State extends State<MyDropDownButton2> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: MyText.text1(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: MyText.text1(
                    item,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        onChanged: widget.onChanged ??
            (String? value) {
              setState(() {
                widget.selectedValue = value;
              });
            },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            color: Theme.of(context).primaryColor,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: MyIcons.icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Theme.of(context).secondaryHeaderColor,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).primaryColor,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all<double>(6),
            thumbVisibility: WidgetStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
