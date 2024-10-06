import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:tractian/core/components/button_widget.dart';
import 'package:tractian/core/components/state_widget.dart';
import 'package:tractian/core/components/loading_widget.dart';
import 'package:tractian/interactor/companies_controller.dart';
import 'package:tractian/ui/assets_page.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons({super.key});

  void _navigateToAssetsPage(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AssetsPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final companiesController = refCompaniesController(context);

    return Watch(
      (context) => companiesController.signalCompaniesAsync.value.map(
        data: (companies) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: companies
                  .map(
                    (company) => Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: ButtonWidget.large(
                        filled: true,
                        text: company.name,
                        iconData: Icons.widgets,
                        onPressed: () {
                          companiesController.selectCompanyId(company.id);
                          _navigateToAssetsPage(context);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        error: () => const StateWidget.error(
          text: 'Erro ao tentar obter empresas.',
        ),
        loading: () => const LoadingWidget(),
      ),
    );
  }
}
