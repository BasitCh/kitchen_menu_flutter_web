import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgets_book/widgets_book.dart';

void main() {
  group('AppTheme', () {
    group('themeData', () {
      group('color', () {
        test('primary is blue', () {
          expect(
            AppTheme.themeData.primaryColor,
            AppColors.blue,
          );
        });

        test('secondary is AppColors.secondary', () {
          expect(
            AppTheme.themeData.colorScheme.secondary,
            AppColors.secondary,
          );
        });
      });

      group('divider', () {
        test('horizontal padding is AppSpacing.lg', () {
          expect(
            AppTheme.themeData.dividerTheme.indent,
            AppSpacing.lg,
          );
          expect(
            AppTheme.themeData.dividerTheme.endIndent,
            AppSpacing.lg,
          );
        });

        test('space is AppSpacing.lg', () {
          expect(
            AppTheme.themeData.dividerTheme.space,
            AppSpacing.lg,
          );
        });
      });

      group('switchTheme', () {
        group('thumbColor', () {
          test('returns darkAqua when selected', () {
            expect(
              AppTheme
                  .themeData
                  .switchTheme
                  .thumbColor
                  ?.resolve({MaterialState.selected}),
              equals(AppColors.darkAqua),
            );
          });

          test('returns eerieBlack when not selected', () {
            expect(
              AppTheme.themeData.switchTheme.thumbColor?.resolve({}),
              equals(AppColors.eerieBlack),
            );
          });
        });

        group('trackColor', () {
          test('returns primaryContainer when selected', () {
            expect(
              AppTheme
                  .themeData
                  .switchTheme
                  .trackColor
                  ?.resolve({MaterialState.selected}),
              equals(AppColors.primaryContainer),
            );
          });

          test('returns paleSky when not selected', () {
            expect(
              AppTheme.themeData.switchTheme.trackColor?.resolve({}),
              equals(AppColors.paleSky),
            );
          });
        });
      });

      group('progressIndicatorTheme', () {
        test('color is AppColors.darkAqua', () {
          expect(
            AppTheme.themeData.progressIndicatorTheme.color,
            equals(AppColors.darkAqua),
          );
        });

        test('circularTrackColor is AppColors.borderOutline', () {
          expect(
            AppTheme.themeData.progressIndicatorTheme.circularTrackColor,
            equals(AppColors.borderOutline),
          );
        });
      });
    });
  });

  // group('AppDarkTheme', () {
  //   group('themeData', () {
  //     group('color', () {
  //       test('primary is blue', () {
  //         expect(
  //           AppDarkTheme.themeData.primaryColor,
  //           AppColors.blue,
  //         );
  //       });
  //
  //       test('secondary is AppColors.secondary', () {
  //         expect(
  //           const AppDarkTheme().themeData.colorScheme.secondary,
  //           AppColors.secondary,
  //         );
  //       });
  //
  //       test('background is grey.shade900', () {
  //         expect(
  //           const AppDarkTheme().themeData.colorScheme.background,
  //           AppColors.grey.shade900,
  //         );
  //       });
  //     });
  //
  //     group('divider', () {
  //       test('horizontal padding is AppSpacing.lg', () {
  //         expect(
  //           AppTheme.themeData.dividerTheme.indent,
  //           AppSpacing.lg,
  //         );
  //         expect(
  //           AppTheme.themeData.dividerTheme.endIndent,
  //           AppSpacing.lg,
  //         );
  //       });
  //
  //       test('space is AppSpacing.lg', () {
  //         expect(
  //           AppTheme.themeData.dividerTheme.space,
  //           AppSpacing.lg,
  //         );
  //       });
  //     });
  //   });
  // });
}
