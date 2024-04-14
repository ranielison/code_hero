import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_hero/app/core/routes/routes.dart';
import 'package:code_hero/app/core/theme/theme.dart';
import 'package:code_hero/app/domain/entities/character_entity.dart';
import 'package:code_hero/app/presentation/presentation.dart';
import 'package:flutter/material.dart';

class WebListWidget extends StatelessWidget {
  final List<CharacterEntity> characters;

  const WebListWidget({super.key, required this.characters});

  _onSelectCharacter(BuildContext context, CharacterEntity character) {
    Navigator.pushNamed(
      context,
      DETAILS_ROUTE,
      arguments: DetailsPageArguments(
        character: character,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
          dataRowMinHeight: 60,
          dataRowMaxHeight: 100,
          columnSpacing: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Container(
                  color: AppColors.primary,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Personagem',
                    style: TextStyles.h5Style.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Container(
                  color: AppColors.primary,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Séries',
                    style: TextStyles.h5Style.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Container(
                  color: AppColors.primary,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Eventos',
                    style: TextStyles.h5Style.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
          rows: characters
              .map(
                (character) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Row(
                        children: [
                          if (character.thumbnail?.url != null)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Hero(
                                tag: character.name!,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CachedNetworkImage(
                                      height: 50,
                                      fit: BoxFit.cover,
                                      imageUrl: character.thumbnail!.url,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            child: Text(
                              character.name?.toUpperCase() ?? '',
                              style: const TextStyle(
                                color: AppColors.grey3,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: () => _onSelectCharacter(context, character),
                    ),
                    DataCell(
                      character.series != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: character.series!.items!.length > 3
                                  ? character.series!.items!
                                      .sublist(1, 3)
                                      .map(
                                        (item) => Text(
                                          item.name!,
                                          style: TextStyles.h5Style.copyWith(),
                                        ),
                                      )
                                      .toList()
                                  : character.series!.items!
                                      .map(
                                        (item) => Text(
                                          item.name!,
                                          style: TextStyles.h5Style.copyWith(),
                                        ),
                                      )
                                      .toList(),
                            )
                          : const SizedBox(),
                    ),
                    DataCell(
                      character.events != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: character.events!.items!.length > 3
                                  ? character.events!.items!
                                      .sublist(1, 3)
                                      .map(
                                        (item) => Text(
                                          item.name!,
                                          style: TextStyles.h5Style.copyWith(),
                                        ),
                                      )
                                      .toList()
                                  : character.events!.items!
                                      .map(
                                        (item) => Text(
                                          item.name!,
                                          style: TextStyles.h5Style.copyWith(),
                                        ),
                                      )
                                      .toList(),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              )
              .toList()),
    );
  }
}
