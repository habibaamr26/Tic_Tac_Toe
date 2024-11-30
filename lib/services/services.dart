





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
  int color=0xFFf39c12 ,
}) =>
    Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(color),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
            style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );




Widget textField({
  required String text,
  required TextEditingController controller,
  String? Function(String?)? validator,
  required bool readOnly,
}) =>
    TextFormField(
      validator: validator,
      controller:controller ,
      maxLength: 10,
      readOnly: readOnly,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );

