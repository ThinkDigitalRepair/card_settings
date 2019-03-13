// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../../card_settings.dart';

/// This is a field that allows a boolean to be set via a switch widget.
class CardSettingsSwitch extends FormField<bool> {
  CardSettingsSwitch({
    Key key,
    String label = '',
    double labelWidth = 120.0,
    TextAlign labelAlign,
    TextAlign contentAlign,
    Icon icon,
    Widget requiredIndicator,
    String trueLabel: 'Yes',
    String falseLabel: 'No',
    bool initialValue: false,
    bool autoValidate: false,
    bool visible: true,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    ValueChanged<bool> onChanged,
    bool hideUnderline = true,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autoValidate,
            builder: (FormFieldState<bool> field) {
              final _CardSettingsSwitchState state =
                  field as _CardSettingsSwitchState;
              return CardSettingsField(
                type: CardSettingsType.settingsSwitch,
                label: label,
                labelWidth: labelWidth,
                labelAlign: labelAlign,
                visible: visible,
                icon: icon,
                requiredIndicator: requiredIndicator,
                errorText: field.errorText,
                content: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      state.value ? trueLabel : falseLabel,
//                      style: Theme.of(field.context).textTheme.subhead.copyWith(),
                      textAlign: contentAlign ??
                          CardSettings.of(field.context).contentAlign,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      height: 20.0,
                      child: Switch(
                        value: state.value,
                        onChanged: (value) {
                          state.didChange(value);
                          if (onChanged != null) onChanged(value);
                        },
                      ),
                    ),
                  ),
                ]),
              );
            });

  @override
  _CardSettingsSwitchState createState() => _CardSettingsSwitchState();
}

class _CardSettingsSwitchState extends FormFieldState<bool> {}
