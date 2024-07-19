import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/widgets/family_screen/family_create_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FamilyCreateWidget extends StatelessWidget {
  const FamilyCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final modelFamily = context.read<FamilyModel>();
    final modelCreateFamily = context.read<FamilyCreateModel>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Создать семью'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 22),
                _TypeIdForHostMenuWidget(
                  modelFamily: modelFamily,
                  modelCreateFamily: modelCreateFamily,
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _AlertDialogAddFamilyMemberWidget(
                      modelCreateFamily: modelCreateFamily,
                      modelFamily: modelFamily,
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        modelCreateFamily.createFamily(context);
                        modelFamily.updateFamily();
                      },
                      child: const Text('Сохранить'),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(),
                _ListAddFamilyMemberWidget(),
              ],
            ),
          ),
        ));
  }
}

class _AlertDialogAddFamilyMemberWidget extends StatelessWidget {
  FamilyModel modelFamily;
  FamilyCreateModel modelCreateFamily;
  _AlertDialogAddFamilyMemberWidget({
    super.key,
    required this.modelCreateFamily,
    required this.modelFamily,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
                        controller: modelCreateFamily.idMemberController,
                        decoration: const InputDecoration(
                          labelText: 'ID члена семьи',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {},
                      ),
                      const SizedBox(height: 22),
                      _TypeIdForMembersMenuWidget(
                        modelFamily: modelFamily,
                        modelCreateFamily: modelCreateFamily,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Отменить'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('ОК'),
                    onPressed: () {
                      modelCreateFamily.addFamilyMember(context);
                    },
                  ),
                ],
              ));
            });
      },
      child: const Icon(Icons.person_add_alt),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final errorMessage =
    //     NotifierProvider.watch<SignUpModel>(context)?.errorMessage;
    final errorMessage = context.watch<FamilyCreateModel>().errorMessage;
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

class _ListAddFamilyMemberWidget extends StatelessWidget {
  _ListAddFamilyMemberWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final modelCreateFamily = context.watch<FamilyCreateModel>();
    final listMembers = modelCreateFamily.familyMembers;
    return listMembers.isEmpty
        ? Text('Нет членов семьи.\n     Добавьте их!')
        : ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("${listMembers[index].userId}"),
                subtitle: Text('${listMembers[index].typeId}'),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1);
            },
            itemCount: listMembers.length,
            shrinkWrap: true,
          );
  }
}

class _TypeIdForMembersMenuWidget extends StatelessWidget {
  FamilyModel modelFamily;
  FamilyCreateModel modelCreateFamily;
  _TypeIdForMembersMenuWidget({
    super.key,
    required this.modelFamily,
    required this.modelCreateFamily,
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
            controller: modelCreateFamily.typeIdForMemberController,
            // width: 100,
            // initialSelection: list.first,
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

class _TypeIdForHostMenuWidget extends StatelessWidget {
  FamilyModel modelFamily;
  FamilyCreateModel modelCreateFamily;
  _TypeIdForHostMenuWidget({
    super.key,
    required this.modelFamily,
    required this.modelCreateFamily,
  });
  @override
  Widget build(BuildContext context) {
    final list = modelCreateFamily.listTypes
        .map((e) => modelFamily.returnTypeString(e))
        .toList();
    String dropdownValue = list.first;
    return list != null
        ? DropdownMenu<String>(
            label: const Text("Кто ты в семье?"),
            controller: modelCreateFamily.typeIdForHostController,
            width: 300,
            initialSelection: list.first,
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
