import 'package:flutter/material.dart';
import 'package:tractian/interactor/models/asset.dart';

class EnergyAndOrAlertWidget extends StatelessWidget {
  const EnergyAndOrAlertWidget({super.key, required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Row(
        children: [
          if (asset.isEnergy)
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                size: 16,
                color: Color(0xff53c31b),
                Icons.bolt,
              ),
            ),
          if (asset.hasAlert)
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                size: 12,
                color: Color(0xffee3833),
                Icons.fiber_manual_record,
              ),
            ),
        ],
      ),
    );
  }
}
