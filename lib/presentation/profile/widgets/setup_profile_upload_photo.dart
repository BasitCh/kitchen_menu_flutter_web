import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menumaster_manager/application/profile/cubits/profile_file_cubit.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:widgets_book/widgets_book.dart';

class SetupProfileUploadPhoto extends StatelessWidget {
  const SetupProfileUploadPhoto({
    Key? key,
    this.isCompanyProfile = false,
    this.user,
    this.comapany,
  }) : super(
          key: key,
        );

  final bool? isCompanyProfile;
  final AppUser? user;
  final Company? comapany;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileFileCubit, Uint8List?>(
      builder: (context, fileState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                context.read<ProfileFileCubit>().getImage(context);
              },
              child: fileState == null && (user == null) && (comapany == null)
                  ? Assets.icons.userDottedBorder.svg(
                      height: 140.h,
                      width: 140.h,
                      fit: BoxFit.cover,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: user != null && user?.imageUrl != null
                          ? Image.network(
                              user?.imageUrl ?? '',
                              height: 140.h,
                              width: 140.h,
                              fit: BoxFit.cover,
                            )
                          : comapany != null && comapany?.companyLogo != null
                              ? Image.network(
                                  comapany?.companyLogo ?? '',
                                  height: 140.h,
                                  width: 140.h,
                                  fit: BoxFit.cover,
                                )
                              : fileState != null
                                  ? Image.memory(
                                      fileState,
                                      height: 140.h,
                                      width: 140.h,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox.shrink(),
                    ),
            ),
            5.horizontalSpace,
            Flexible(
              child: StandardText.subtitle2(
                context,
                isCompanyProfile!
                    ? 'Upload Company Logo'
                    : AppLocalizations.of(context)!
                        .setup_profile_upload_profile_photo,
                letterSpacing: -0.4,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
