import 'package:flutter/material.dart';

class TwoPartCard extends StatelessWidget {
  // a container made from 2 parts:
  // the top part is an image
  // the bottom part is usually some text, but it
  // can be any widget

  final Widget bottom;
  final Image image;
  final double imageHeight;
  final double imageWidth;
  final double width;

  const TwoPartCard(
      {Key key,
      this.bottom,
      @required this.image,
      @required this.imageHeight,
      this.imageWidth,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(20.0)),
      width: this.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
                height: imageHeight,
                width: imageWidth,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [BoxShadow()]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), child: image)),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: bottom ?? SizedBox(),
          )
        ],
      ),
    );
  }
}
