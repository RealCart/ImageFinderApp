import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_finder_app/core/constants/app_assets.dart';

class SearchAppBarWidget extends StatelessWidget {
  const SearchAppBarWidget({
    super.key,
    required this.onChanged,
  });

  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      onTapOutside: (_) => focusNode.unfocus(),
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Color(0xff000000),
        fontSize: 24,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(25.0, 20.0, 0.0, 22.0),
          fillColor: const Color(0xffFFFFFF),
          labelText: "Поиск",
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle: const TextStyle(
            color: Color(0xff000000),
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
          suffix: Container(
            margin: EdgeInsets.only(right: 12.5, left: 12.5),
            child: SvgPicture.asset(
              AppAssets.svg.search,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
