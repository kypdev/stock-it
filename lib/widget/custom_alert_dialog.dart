import 'package:awesome_dialog/awesome_dialog.dart';

// typedef AlertAction<T> = void Function(T index);

class CustomAlertDialog {
  warningAlertDialog({
    context,
    dialogType,
    desc,
  }) {
    return AwesomeDialog(
        context: context,
        dialogType: dialogType,
        animType: AnimType.BOTTOMSLIDE,
        tittle: 'Warning!!',
        desc: desc,
        btnOkOnPress: () {})
      ..show();
  }
}
