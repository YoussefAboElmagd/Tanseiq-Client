// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tanseiq/core/helpers/extentions.dart';
// import 'package:tanseiq/core/routing/routes.dart';
// import 'package:tanseiq/core/theming/colors.dart';
// import 'package:tanseiq/features/auth/presentation/views/logout_alert.dart';
// import 'package:tanseiq/features/drawer/presentation/manager/darwer_cubit.dart';
// import 'package:tanseiq/features/drawer/presentation/manager/drawer_states.dart';
// import 'package:tanseiq/features/drawer/presentation/views/widgets/drawer_list_item.dart';
// import 'package:tanseiq/features/drawer/presentation/views/widgets/top_drawer_row_icons.dart';
// import 'package:tanseiq/features/home/presentation/views/widgets/logout_buttom.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({
//     super.key,
//     required this.globalKey,
//   });
//   final GlobalKey<ScaffoldState> globalKey;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DarwerCubit(),
//       child: BlocBuilder<DarwerCubit, DrawerState>(
//         builder: (context, state) {
//           var cubit = DarwerCubit.get(context);
//           return Drawer(
//             backgroundColor: ColorsManager.white,
//             child: SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TopDrawerRowIcons(globalKey: globalKey),
//                     const Divider(),
//                     20.height,
//                     Expanded(
//                       child: ListView.separated(
//                         physics: const NeverScrollableScrollPhysics(),
//                         separatorBuilder: (context, index) => const Divider(),
//                         itemBuilder: (context, index) => GestureDetector(
//                           onTap: () {
//                             cubit.changeDrawerItem(index);
//                             if (index == 0) {
//                               context.pushNamed(Routes.camps);
//                             }
//                             if (index == 2) {
//                               context.pushNamed(Routes.team);
//                             }
//                             if (index == 6) {
//                               context.pushNamed(
//                                 Routes.displayProblems,
//                                 routerNavigator: true,
//                               );
//                             }
//                             if (index == 7) {
//                               context.pushNamed(
//                                 Routes.support,
//                               );
//                             }
//                           },
//                           child: DrawerListItem(
//                             selectedItem: cubit.selectedItem,
//                             index: index,
//                           ),
//                         ),
//                         itemCount: drawerTitles.length,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => const PopScope(
//                             canPop: false,
//                             child: LogoutAlert(),
//                           ),
//                         );
//                       },
//                       child: const LogoutButtom(),
//                     ),
//                     10.height,
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
