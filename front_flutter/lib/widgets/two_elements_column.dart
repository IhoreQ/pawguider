import 'package:flutter/cupertino.dart';
import 'package:front_flutter/styles.dart';

class TwoElementsColumn extends StatelessWidget {
  const TwoElementsColumn({Key? key, required this.topText, required this.bottomText}) : super(key: key);

  final String topText;
  final String? bottomText;


  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth / 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(topText, style: AppTextStyle.heading2),
          Text(bottomText!, style: AppTextStyle.mediumLight.copyWith(fontSize: 14.0), overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}
