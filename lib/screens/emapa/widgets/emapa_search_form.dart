import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:vintol/controllers/emapacopsa_controller.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/widgets/global_widgets/input_text.dart';
import 'package:vintol/widgets/rounded_button.dart';

class EmapaSearchForm extends GetView<EmapacopsaController> {
  EmapaSearchForm({super.key});

  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var submitOk = await controller.submit();
      if (submitOk.runtimeType != int) {
        print("Sin error");
      } else {
        print("error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Suministro"),
                        isDense: true,
                        prefixIcon: Icon(Icons.pin),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        controller.onSupplyChanged(value);
                      },
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 2.0,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: RoundedButton(
                      label: S.current.txSearch,
                      onPressed: () => _submit(context),
                    ),
                  )
                ],
              ),

              Obx(() => HtmlWidget("${controller.res}")),

              // const SizedBox(height: 20),
              // const SizedBox(height: 20),
              // RoundedButton(
              //   label: S.current.txSave,
              //   onPressed: () => _submit(context),
              //   padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 40),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scanBarcodeNormal() async {
    String res;
  }
}
