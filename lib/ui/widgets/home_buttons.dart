import 'package:flutter/material.dart';
import 'package:tractian/core/components/button_widget.dart';
import 'package:tractian/core/components/state_widget.dart';
import 'package:tractian/core/components/loading_widget.dart';
import 'package:tractian/core/enums/status.dart';
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
    final controller = refCompaniesController(context);

    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) => switch (controller.status) {
        Status.loading => const LoadingWidget(),
        Status.error =>
          const StateWidget.error(text: 'Erro ao tentar obter empresas.'),
        Status.success => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.companies
                    .map(
                      (company) => Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: ButtonWidget.large(
                          filled: true,
                          text: company.name,
                          iconData: Icons.widgets,
                          onPressed: () {
                            controller.selectCompanyId(company.id);
                            _navigateToAssetsPage(context);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
      },
    );
  }
}
