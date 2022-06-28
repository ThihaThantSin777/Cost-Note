
import 'package:costnotebook/resources/dimension.dart';
import 'package:flutter/material.dart';

class PreviewWidget extends StatelessWidget {
  const PreviewWidget({
    Key? key,
    required this.previewText,
    required this.previewTitle
  }) : super(key: key);

  final String previewTitle;
  final String previewText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child:  Text(previewTitle,style: const TextStyle(
              fontSize:  kFontSize17x
          ),),
        ),
        Expanded(child: Text((previewText.isEmpty)?'-':previewText,overflow: TextOverflow.ellipsis,style: const TextStyle(
            fontSize: kFontSize17x
        ),))
      ],
    );
  }
}
