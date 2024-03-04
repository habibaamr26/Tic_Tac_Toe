





import 'package:flutter/material.dart';




Widget customeIimageHomeBage({
  required String image,
  required double radius ,

})=>CircleAvatar(
radius: radius,
backgroundImage:  AssetImage(
    image),
);


Widget customeIimage({
  required String image,
  required double radius ,
  int color=0xFF6495ED,
})=>CircleAvatar(
  radius: radius,
  backgroundColor: Color(color),
  child: Image(
    image: AssetImage(image),
  ),
);


Widget customeButton({
  required void Function()? onPressed,
  required String text,
  required context,
  int color=0xFFA93226,
}) =>
    Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color(color),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
            style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );


