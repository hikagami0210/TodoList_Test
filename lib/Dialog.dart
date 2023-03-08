import 'package:flutter/material.dart';
import 'getList.dart';

class SimpleDialogSample extends StatelessWidget {
  const SimpleDialogSample({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        SimpleDialogOption(
          child: const Text('削除'),
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (_) {
                  return AlertDialogSample(index: index,);
                });
          },
        ),
      ],
    );
  }
}

class AlertDialogSample extends StatelessWidget {
  const AlertDialogSample({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('削除してもいいですか？\nこの操作は元に戻せません'),
      actions: <Widget>[
        GestureDetector(
          child: const Text('いいえ'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: const Text('はい'),
          onTap: () {
            var getList = GetList();
            getList.deleteListItem(index);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}