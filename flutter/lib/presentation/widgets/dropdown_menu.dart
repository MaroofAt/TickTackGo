import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/presentation/widgets/icons.dart';
import 'package:pr1/presentation/widgets/text.dart';

class MyDropdownMenu {
  static DropdownButton<String> dropdownMenu(
    BuildContext context,
    List<String> values,
    String defaultValue, {
    void Function(String? value)? onChanged,
  }) {
    return DropdownButton<String>(
      value: defaultValue,
      dropdownColor: Theme.of(context).secondaryHeaderColor,
      icon: MyIcons.icon(Icons.arrow_downward,color: black),
      elevation: 16,
      style: const TextStyle(color: black),
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
      isExpanded: true,
      onChanged: onChanged,
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: MyText.text1(value,textColor: black),
        );
      }).toList(),
    );
  }
}
