import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/family_screen/family_create_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/user_model.dart';

class FamilyListWidget extends StatelessWidget {
  const FamilyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    final familyModel = context.watch<FamilyModel>();
    // if (familyModel.familyIsExist) {}
    familyModel.updateFamily();
    return familyModel.familyIsExist
        ? _FamilyExistWidget(familyModel: familyModel)
        : _FamilyIsNotExistWidget(
            familyModel: familyModel,
          );
  }
}

class _FamilyExistWidget extends StatelessWidget {
  const _FamilyExistWidget({
    super.key,
    required this.familyModel,
  });

  final FamilyModel familyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Семья'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return _FamilyListTile(
                        familyModel: familyModel,
                        index: index,
                      );
                    },
                    itemCount: familyModel.family?.members.length,
                    shrinkWrap: true,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FamilyListTile extends StatelessWidget {
  const _FamilyListTile({
    super.key,
    required this.familyModel,
    required this.index,
  });

  final FamilyModel familyModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    String? type = familyModel.getType(index);
    return ListTile(
      leading: _AvatarFamilyListTile(
        type: type,
      ),
      title: Text("${familyModel.getName(index)}"),
      subtitle: Text('$type'),
    );
  }
}

class _AvatarFamilyListTile extends StatelessWidget {
  const _AvatarFamilyListTile({
    super.key,
    required this.type,
  });
  final String? type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'Мама':
        return const CircleAvatar(
          child: Icon(Icons.woman),
        );
      case 'Брат':
        return const CircleAvatar(
          child: Icon(Icons.boy),
        );
      default:
        return const CircleAvatar(
          child: Icon(Icons.man),
        );
    }
  }
}

class _FamilyIsNotExistWidget extends StatelessWidget {
  final FamilyModel familyModel;
  const _FamilyIsNotExistWidget({super.key, required this.familyModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Семья'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              // heroTag: "btn4",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (context) => FamilyCreateWidget()));
              },
              child: Text("Создать семью"),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   heroTag: "btn4",
      //   onPressed: () {
      //     Navigator.of(context).push(MaterialPageRoute<void>(
      //         builder: (context) => FamilyCreateWidget()));
      //   },
      //   icon: Icon(Icons.add),
      //   label: Text("Создать семью"),
      // ),
    );
  }
}
