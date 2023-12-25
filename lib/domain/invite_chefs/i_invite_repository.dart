// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/invite_chefs/invite.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class IInviteRepository {
  Future<Either<ApiError, String>> inviteCompanyChef(
      {required String companyId, required Invite invite});
}
