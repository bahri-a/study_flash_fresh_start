import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flash/src/core/providers/flashcard_provider.dart';
import 'package:study_flash/src/features/study/presentation/widgets/show_add_flashcard_dialog.dart';

class AddFlashcardScreen extends ConsumerWidget {
  final FlashcardParams params;
  const AddFlashcardScreen({super.key, required this.params});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InkWell(
          child: Container(
            color: Colors.grey,
            constraints: BoxConstraints(maxHeight: 250, maxWidth: 350),
          ),
          onTap: () {
            //!todo: Direkt auf die Flashcard schreiben statt popup-Dialog
            showAddFlashcardDialog(context, ref, params);
          },
        ),
      ),
    );
  }
}
