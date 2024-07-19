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
    final familyModel = context.read<FamilyModel>();
    //familyModel.updateFamily();
    return familyModel.familyIsExist
        ? FamilyExistWidget(familyModel: familyModel)
        : FamilyIsNotExistWidget(
            familyModel: familyModel,
          );
  }
}

class FamilyExistWidget extends StatelessWidget {
  const FamilyExistWidget({
    super.key,
    required this.familyModel,
  });

  final FamilyModel familyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text("Члены семьи"),
                SizedBox(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return familyListTile(
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

class familyListTile extends StatelessWidget {
  const familyListTile({
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
      leading: avatarFamilyListTile(
        type: type,
      ),
      title: Text("${familyModel.getName(index)}"),
      subtitle: Text('$type'),
    );
  }
}

class avatarFamilyListTile extends StatelessWidget {
  const avatarFamilyListTile({
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

class FamilyIsNotExistWidget extends StatelessWidget {
  final FamilyModel familyModel;
  const FamilyIsNotExistWidget({super.key, required this.familyModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Нет семьи'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "btn4",
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) => FamilyCreateWidget()));
        },
        icon: Icon(Icons.add),
        label: Text("Создать семью"),
      ),
    );
  }
}
