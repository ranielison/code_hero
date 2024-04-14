import 'package:code_hero/app/core/theme/theme.dart';
import 'package:code_hero/app/core/utils/debouncer.dart';
import 'package:code_hero/app/presentation/home/bloc/home_bloc.dart';
import 'package:code_hero/app/presentation/home/widgets/list_shimer.dart';
import 'package:code_hero/app/presentation/home/widgets/mobile_list_widget.dart';
import 'package:code_hero/app/presentation/home/widgets/pagination_container.dart';
import 'package:code_hero/app/presentation/home/widgets/web_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _debouncer = Debouncer(milliseconds: 700);
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'BUSCA MARVEL ',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                      children: [
                        TextSpan(
                          text: 'TESTE FRONT-END',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (!isMobile)
                    const Text(
                      'RANIÉLISON SOARES',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    )
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                width: 65,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  homeBloc.add(ChangeSearchTermEvent(value));
                  _debouncer.run(
                    () {
                      homeBloc.add(const GetCharactersEvent());
                    },
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Nome do personagem',
                  hintStyle: const TextStyle(color: AppColors.grey3),
                  labelText: 'Nome do personagem',
                  labelStyle: const TextStyle(color: AppColors.primary),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.grey3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.grey3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.grey3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: AppColors.grey3,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      homeBloc.add(const ChangeSearchTermEvent(''));
                      homeBloc.add(const GetCharactersEvent());
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.grey3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeSuccess) {
                    return Expanded(
                      child: state.isLoading
                          ? const ListShimmer()
                          : state.characters.isNotEmpty
                              ? isMobile
                                  ? MobileListWidget(
                                      characters: state.characters)
                                  : WebListWidget(characters: state.characters)
                              : const Center(
                                  child: Text('Nenhum resultado encontrado'),
                                ),
                    );
                  }

                  if (state is HomeLoading) {}

                  return Container();
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return PaginationContainer(
              atualPage: state.atualPage,
              maxPage: state.maxPage,
              isLoading: state.isLoading,
              pagesInScreen: isMobile ? 3 : 5,
              onChangePage: (page) => homeBloc.add(
                GetCharactersEvent(page: page),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
