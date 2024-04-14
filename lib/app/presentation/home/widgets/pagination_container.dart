import 'package:code_hero/app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class PaginationContainer extends StatelessWidget {
  final int atualPage;
  final int pagesInScreen;
  final int? maxPage;
  final bool isLoading;
  final Function(int)? onChangePage;

  const PaginationContainer({
    super.key,
    required this.atualPage,
    required this.pagesInScreen,
    required this.maxPage,
    required this.isLoading,
    this.onChangePage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (atualPage == 1 || isLoading) return;
            onChangePage?.call(atualPage - 1);
          },
          child: const Icon(
            Icons.arrow_left_outlined,
            color: AppColors.primary,
            size: 50,
          ),
        ),
        ...List.generate(
          pagesInScreen,
          (index) {
            int page;

            if (atualPage < pagesInScreen) {
              page = index + 1;
            } else {
              page = index + (atualPage - pagesInScreen) + 1;
            }

            bool isAtual = page == atualPage;

            return GestureDetector(
              onTap: () {
                if ((maxPage != null && page > maxPage!) || isLoading) return;
                onChangePage?.call(page);
              },
              child: Container(
                height: 32,
                width: 32,
                margin: EdgeInsets.only(left: index > 0 ? 16 : 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isAtual
                      ? AppColors.primary
                      : maxPage != null && page > maxPage!
                          ? AppColors.grey5
                          : Colors.transparent,
                  border: Border.all(
                    width: 1,
                    color: AppColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '$page',
                  style: TextStyle(
                    color: isAtual ? AppColors.white : AppColors.primary,
                  ),
                ),
              ),
            );
          },
        ).toList(),
        GestureDetector(
          onTap: () {
            if (((atualPage + 1) > maxPage!) || isLoading) return;
            onChangePage?.call(atualPage + 1);
          },
          child: const Icon(
            Icons.arrow_right_outlined,
            color: AppColors.primary,
            size: 50,
          ),
        ),
      ],
    );
  }
}
