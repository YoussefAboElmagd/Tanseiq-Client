import 'package:flutter/material.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/routing/routes.dart';
import 'package:tanseiq/features/team/presentation/views/widgets/team_app_bar.dart';
import 'package:tanseiq/features/team/presentation/views/widgets/team_user_item_design.dart';

class Team extends StatelessWidget {
  const Team({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: CustomScrollView(
        slivers: [
          TeamAppBar(
            onTap: () {
              context.pushNamed(Routes.addNewUserTeam);
            },
          ),
          SliverList.builder(
            itemCount: 15,
            itemBuilder:
                (context, index) => GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.userTeamDetails);
                  },
                  child: const TeamUserItemDesign(),
                ),
          ),
        ],
      ),
    );
  }
}
