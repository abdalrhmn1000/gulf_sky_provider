import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileWidget extends StatelessWidget {
  final String? profileUrl;
  final double size;

  const UserProfileWidget({Key? key, this.profileUrl, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: profileUrl != null
          ? profileUrl!.toLowerCase().contains('.svg')
              ? SvgPicture.network(profileUrl!)
              : CachedNetworkImage(
                  imageUrl:profileUrl!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                )
          : Icon(
              Icons.account_circle,
              size: size,

            ),
    );
  }
}
