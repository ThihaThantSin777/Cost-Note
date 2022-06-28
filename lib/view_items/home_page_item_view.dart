import 'package:costnotebook/data/vos/add_cost_vo/add_cost_vo.dart';
import 'package:costnotebook/resources/dimension.dart';
import 'package:costnotebook/resources/strings.dart';
import 'package:costnotebook/utils/extensions.dart';
import 'package:flutter/material.dart';

class CostBodyItemView extends StatelessWidget {
  const CostBodyItemView({
    Key? key,
    required this.addCostVoList
  }) : super(key: key);
  final List<AddCostVo>addCostVoList;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: addCostVoList
          .map((data) {
        return SizedBox(
          width: double.infinity,
          child: Card(
            elevation: kSpaceAndPadding5X,
            child: Padding(
              padding: const EdgeInsets.all(kSpaceAndPadding5X),
              child: Column(
                mainAxisSize:
                MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  ...[
                    const Text(kCostTitle,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: kFontSize17x
                    ),),
                    Text(data.costTitle??'',style: const TextStyle(
                        fontSize: kFontSize17x,
                        color: Colors.black54
                    ),),
                  ],
                  const SizedBox(
                    height:
                    kSpaceAndPadding10X,
                  ),
                  ...[
                    const Text(kCostAmount,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: kFontSize17x
                    )),
                    Text(data.costAmount??''.formatDigit(),style: const TextStyle(
                        fontSize: kFontSize17x,
                        color: Colors.black54
                    )),
                  ],
                  const SizedBox(
                    height:
                    kSpaceAndPadding10X,
                  ),
                  ...[
                    const Text(
                        kCostNoteWithoutOptional,style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: kFontSize17x
                    )),
                    Text((data.costNote?.isEmpty??true)?'-':data.costNote??'',style: const TextStyle(
                        fontSize: kFontSize17x,
                        color: Colors.black54
                    )),
                  ],
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}