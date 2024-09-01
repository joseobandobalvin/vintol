import "package:flutter/material.dart";

class OFilters extends StatefulWidget {
  const OFilters({super.key});

  @override
  State<OFilters> createState() => _OFiltersState();
}

class _OFiltersState extends State<OFilters> {
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;

          // print(dropdownValue);
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
