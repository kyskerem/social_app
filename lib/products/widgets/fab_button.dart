import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:social_app/products/enums/icon.dart';
import 'package:social_app/products/enums/route_enum.dart';

class ProjectFabButton extends FloatingActionButton {
  ProjectFabButton({required BuildContext context, super.key})
      : super(
          onPressed: () => RouteEnum.upload.push(context),
          child: SvgPicture.asset(
            IconEnum.add.toSvg,
          ),
        );
}
