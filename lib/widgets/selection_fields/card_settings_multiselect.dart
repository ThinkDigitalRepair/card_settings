// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:card_settings/helpers/checkbox_dialog.dart';
import 'package:flutter/material.dart';
import '../../card_settings.dart';

/// This is a selection widget that allows an arbitrary list of options to be provided.
class CardSettingsMultiselect extends FormField<List<String>> {
  CardSettingsMultiselect({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    List<String> initialValues,
    Icon icon,
    Widget requiredIndicator,
    List<String> options,
    bool autoValidate: false,
    bool visible: true,
    FormFieldSetter<List<String>> onSaved,
    FormFieldValidator<List<String>> validator,
    this.onChanged,
  }) : super(
            key: key,
            initialValue: initialValues,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autoValidate,
            builder: (FormFieldState<List<String>> field) {
              final _CardSettingsMultiselectState state =
                  field as _CardSettingsMultiselectState;
              return GestureDetector(
                onTap: () {
                  state._showDialog(label, options);
                },
                child: CardSettingsField(
                  label: label,
                  labelAlign: labelAlign,
                  visible: visible,
                  icon: icon,
                  requiredIndicator: requiredIndicator,
                  errorText: field.errorText,
                  contentOnNewLine: true,
                  content: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 4.0,
                    runSpacing: 0.0,
                    children: field.value
                        .map(
                          (s) => Chip(label: Text(s)),
                        )
                        .toList(),
                  ),
                  pickerIcon: Icons.arrow_drop_down,
                ),
              );
            });

  final ValueChanged<List<String>> onChanged;

  @override
  _CardSettingsMultiselectState createState() =>
      _CardSettingsMultiselectState();
}

class _CardSettingsMultiselectState extends FormFieldState<List<String>> {
  @override
  CardSettingsMultiselect get widget => super.widget as CardSettingsMultiselect;

  void _showDialog(String label, List<String> options) {
    showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return CheckboxDialog(
          items: options,
          title: 'Select ' + label,
          initialValues: value,
        );
      },
    ).then((value) {
      if (value != null) {
        didChange(value);
        if (widget.onChanged != null) widget.onChanged(value);
      }
    });
  }
}
