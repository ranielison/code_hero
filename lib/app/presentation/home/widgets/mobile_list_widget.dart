import 'package:code_hero/app/core/theme/theme.dart';
import 'package:code_hero/app/domain/entities/character_entity.dart';
import 'package:code_hero/app/presentation/home/widgets/character_item_horizontal_card.dart';
import 'package:code_hero/app/presentation/home/widgets/character_item_vertical_card.dart';
import 'package:flutter/material.dart';

class MobileListWidget extends StatefulWidget {
  final List<CharacterEntity> characters;

  const MobileListWidget({super.key, required this.characters});

  @override
  State<MobileListWidget> createState() => _MobileListWidgetState();
}

class _MobileListWidgetState extends State<MobileListWidget> {
  bool viewIsGrid = false;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = View.of(context).viewInsets.bottom > 0.0;

    return Column(
      children: [
        Expanded(
          child: viewIsGrid
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 8.0, // spacing between columns
                  ),
                  padding: const EdgeInsets.all(8.0), // padding around the grid
                  itemCount: widget.characters.length, // total number of items
                  itemBuilder: (context, index) {
                    final item = widget.characters[index];
                    return CharacterItemVerticalCard(character: item);
                  },
                )
              : ListView.builder(
                  itemCount: widget.characters.length,
                  itemBuilder: (context, index) {
                    final item = widget.characters[index];
                    return CharacterItemHorizontalCard(character: item);
                  },
                ),
        ),
        Visibility(
          visible: !keyboardIsOpen,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (!viewIsGrid) return;
                  setState(() {
                    viewIsGrid = !viewIsGrid;
                  });
                },
                child: Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: viewIsGrid ? AppColors.white : AppColors.primary,
                    border: Border.all(
                      width: 1,
                      color:
                          viewIsGrid ? AppColors.primary : Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                  ),
                  child: Icon(
                    Icons.list,
                    color: viewIsGrid ? AppColors.primary : AppColors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (viewIsGrid) return;
                  setState(() {
                    viewIsGrid = !viewIsGrid;
                  });
                },
                child: Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: viewIsGrid ? AppColors.primary : AppColors.white,
                    border: Border.all(
                      width: 1,
                      color:
                          viewIsGrid ? Colors.transparent : AppColors.primary,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: Icon(
                    Icons.grid_view_outlined,
                    color: viewIsGrid ? AppColors.white : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
