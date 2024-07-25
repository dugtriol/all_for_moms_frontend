import 'package:all_for_moms_frontend/utils/build_text_field_widget.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/family_screen/family_create_model.dart';
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
    final familyCreateModel = context.read<FamilyCreateModel>();
    return familyModel.familyIsExist
        ? _FamilyExistWidget(
            familyModel: familyModel,
            familyCreateModel: familyCreateModel,
            userModel: userModel,
          )
        : _FamilyIsNotExistWidget(
            familyModel: familyModel,
          );
  }
}

class _FamilyExistWidget extends StatelessWidget {
  const _FamilyExistWidget({
    super.key,
    required this.familyModel,
    required this.familyCreateModel,
    required this.userModel,
  });

  final FamilyModel familyModel;
  final UserModel userModel;
  final FamilyCreateModel familyCreateModel;

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
                        userModel: userModel,
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
      floatingActionButton: FloatButtonAddMemberToFamily(
          familyCreateModel: familyCreateModel, familyModel: familyModel),
    );
  }
}

class FloatButtonAddMemberToFamily extends StatelessWidget {
  const FloatButtonAddMemberToFamily({
    super.key,
    required this.familyCreateModel,
    required this.familyModel,
  });

  final FamilyCreateModel familyCreateModel;
  final FamilyModel familyModel;

  @override
  Widget build(BuildContext context) {
    final idMemberController = TextEditingController();
    final typeIdForMemberController = TextEditingController();
    return FloatingActionButton(
      heroTag: "btn5",
      child: const Icon(Icons.person_add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: Text('Добавить члена семьи'),
                content: SizedBox(
                  // height: 170,
                  child: Column(
                    children: [
                      _ErrorMessageWidget(),
                      TextField(
                        controller: idMemberController,
                        decoration: const InputDecoration(
                          labelText: 'ID члена семьи',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {},
                      ),
                      const SizedBox(height: 22),
                      _TypeIdForMembersMenuWidget(
                        modelFamily: familyModel,
                        modelCreateFamily: familyCreateModel,
                        typeIdForMemberController: typeIdForMemberController,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Отменить'),
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: контроллеры очистить
                    },
                  ),
                  TextButton(
                    child: const Text('ОК'),
                    onPressed: () {
                      // modelCreateFamily.addFamilyMember(context);
                      familyModel.addFamilyMember(
                        context,
                        idMemberController.text,
                        typeIdForMemberController.text,
                      );
                      // TODO: контроллеры очистить
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _FamilyListTile extends StatelessWidget {
  const _FamilyListTile({
    super.key,
    required this.familyModel,
    required this.index,
    required this.userModel,
  });

  final FamilyModel familyModel;
  final UserModel userModel;
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
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Член семьи'),
                scrollable: true,
                content: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      buildTextField('Идентификатор',
                          familyModel.members![index].id.toString()),
                      buildTextField(
                          'Имя', familyModel.getName(index).toString()),
                      buildTextField('Электронная почта',
                          familyModel.members![index].email),
                      buildTextField(
                          'В семье', familyModel.getType(index).toString()),
                      buildTextField(
                          'Дата рождения', familyModel.getDateOfBirth(index)),
                    ],
                  ),
                ),
                actions: [
                  (familyModel.isHost(userModel.id) &&
                          familyModel.members![index].id != userModel.id)
                      ? ElevatedButton(
                          onPressed: () {
                            int id = familyModel.members![index].id!;
                            String typeStr = familyModel.getType(index)!;
                            familyModel.deleteFamilyMember(
                              context,
                              id,
                              typeStr,
                            );
                          },
                          child: const Text('Удалить из семьи'),
                        )
                      : const SizedBox.shrink(),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Выход"))
                ],
              );
            });
      },
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.watch<FamilyModel>().errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
    );
  }
}

class _TypeIdForMembersMenuWidget extends StatelessWidget {
  FamilyModel modelFamily;
  FamilyCreateModel modelCreateFamily;
  TextEditingController typeIdForMemberController;
  _TypeIdForMembersMenuWidget({
    super.key,
    required this.modelFamily,
    required this.modelCreateFamily,
    required this.typeIdForMemberController,
  });
  @override
  Widget build(BuildContext context) {
    final list = modelCreateFamily.listTypes
        .map((e) => modelFamily.returnTypeString(e))
        .toList();
    String dropdownValue = list.first;
    return list != null
        ? DropdownMenu<String>(
            label: const Text("Какая роль в семье?"),
            controller: typeIdForMemberController,
            onSelected: (String? value) {
              dropdownValue = value!;
            },
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          )
        : const SizedBox.shrink();
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (context) => const FamilyCreateWidget()));
              },
              child: const Text("Создать семью"),
            ),
          ],
        ),
      ),
    );
  }
}
