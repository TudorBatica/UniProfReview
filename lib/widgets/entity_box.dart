import 'package:flutter/material.dart';

class EntityBox extends StatelessWidget {
  final BuildContext context;
  final ImageProvider image;
  final String name;
  final String title;

  const EntityBox({Key key, this.context, this.image, this.name, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 10.0,
                color: Colors.black87,
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 10.0,
                color: Colors.black87,
              ),
            ],
          ),
        )
      ]),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
              image: image,
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColorDark.withOpacity(0.2),
                  BlendMode.dstATop))),
    );
  }
}
