import 'package:flutter/material.dart';
import 'package:professor_review/widgets/two_part_card.dart';

//* The widget placed at the top of every profile screen

class ProfileScreenHeader extends StatelessWidget {
  final Widget bottomInformation;
  final Image image;
  final Widget information;

  const ProfileScreenHeader(
      {Key key, this.bottomInformation, this.image, this.information})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(children: <Widget>[
          TwoPartCard(
              image: image,
              imageHeight: MediaQuery.of(context).size.height * 0.3,
              imageWidth: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              bottom: Column(
                children: <Widget>[
                  information,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05)
                ],
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.065)
        ]),
        Positioned(bottom: 12.5, left: 10.0, child: bottomInformation)
      ],
    );
  }
}
