import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_hero/app/core/theme/theme.dart';
import 'package:code_hero/app/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';

class DetailsPageArguments {
  final CharacterEntity character;

  DetailsPageArguments({required this.character});
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late DetailsPageArguments pageArgs;

  @override
  Widget build(BuildContext context) {
    pageArgs =
        ModalRoute.of(context)!.settings.arguments as DetailsPageArguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Hero(
                      tag: pageArgs.character.name!,
                      child: CachedNetworkImage(
                        height: 64,
                        fit: BoxFit.cover,
                        imageUrl: pageArgs.character.thumbnail!.url,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: CircleAvatar(
                        backgroundColor: AppColors.white.withOpacity(.6),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 42,
                width: double.infinity,
                color: AppColors.primary,
                alignment: Alignment.center,
                child: Text(
                  pageArgs.character.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.h1Style.copyWith(color: AppColors.white),
                ),
              ),
              if (pageArgs.character.description?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '"${pageArgs.character.description!}"',
                    textAlign: TextAlign.center,
                    style: TextStyles.h4Style.copyWith(
                      color: AppColors.grey3,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              Card(
                color: AppColors.white,
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      'Séries',
                      style:
                          TextStyles.h2Style.copyWith(color: AppColors.grey3),
                    ),
                    backgroundColor: AppColors.white,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.all(16),
                    children: pageArgs.character.series!.items!
                        .map(
                          (item) => Text(
                            ' - ${item.name!}',
                            style: TextStyles.h5Style.copyWith(),
                            textAlign: TextAlign.start,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Card(
                color: AppColors.white,
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      'Eventos',
                      style:
                          TextStyles.h2Style.copyWith(color: AppColors.grey3),
                    ),
                    backgroundColor: AppColors.white,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.all(16),
                    children: pageArgs.character.events!.items!
                        .map(
                          (item) => Text(
                            ' - ${item.name!}',
                            style: TextStyles.h5Style.copyWith(),
                            textAlign: TextAlign.start,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
