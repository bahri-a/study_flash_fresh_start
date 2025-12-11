import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/providers/app_user_provider.dart';
import 'package:study_flash/src/features/home/presentation/widgets/greeting_title_home.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDaten = ref.watch(currentUserDataProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          SizedBox(
            height: 65,
            width: 65,

            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(30),
              child: Image.asset(
                'lib/constants/images/profilbild.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Icon(
          //   Icons.circle,
          //   size: 60,
          // ), //!
          //            Profilbild
          Expanded(
            child: userDaten.when(
              data: (data) {
                final displayName = data?.username ?? "anonymer Gast";
                return GreetingTitleHome(name: displayName);
              },
              loading: () => GreetingTitleHome(name: "..."),
              error: (error, stackTrace) =>
                  GreetingTitleHome(name: "anonymer Gast"),
            ),
          ),

          SizedBox(width: 35),
        ],
      ),
    );
  }
}
