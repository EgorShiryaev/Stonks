import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stonks/domain/entity/price_notification.dart';

class AddNotificationModal extends StatefulWidget {
  final void Function(PriceNotification newPrice) saveNotificationPrice;
  const AddNotificationModal({Key? key, required this.saveNotificationPrice})
      : super(key: key);

  @override
  State<AddNotificationModal> createState() => _AddNotificationModalState();
}

class _AddNotificationModalState extends State<AddNotificationModal> {
  final priceController = TextEditingController();
  String? errorText;
  bool? large = true;

  void onChangeLarge(bool? newValue) {
    setState(() {
      large = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Новое уведомление'),
      content: SingleChildScrollView(
        child: ListBody(children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Цена',
              errorText: errorText,
            ),
            controller: priceController,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black12,
          ),
          const SizedBox(height: 10),
          ListTile(
            title: const Text(
              'Выше',
              style: TextStyle(fontSize: 18),
            ),
            leading: Radio<bool>(
              value: true,
              groupValue: large,
              onChanged: onChangeLarge,
            ),
          ),
          ListTile(
            title: const Text(
              'Ниже',
              style: TextStyle(fontSize: 18),
            ),
            leading: Radio<bool>(
              value: false,
              groupValue: large,
              onChanged: onChangeLarge,
            ),
          )
        ]),
      ),
      actions: [
        TextButton(
          child: Text(
            'Отменить',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          onPressed: Navigator.of(context).pop,
        ),
        TextButton(
          child: Text(
            'Добавить',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          onPressed: onPressSave,
        ),
      ],
    );
  }

  void onPressSave() {
    final correctTextPrice = priceController.text.replaceAll(',', '.');
    final priceInDouble = double.tryParse(correctTextPrice);
    if (priceInDouble != null) {
      final priceInInt = int.parse((priceInDouble * 100).toStringAsFixed(0));

      widget.saveNotificationPrice(
          PriceNotification(price: priceInInt, needLarge: large!));
      Navigator.of(context).pop();
    } else {
      setState(() {
        errorText = 'Некоректное значение';
      });
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }
}
