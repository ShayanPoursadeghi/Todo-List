import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/data/repo/repository.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/screens/edit/edit.dart';
import 'package:todo_list/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<String> searchKeywordNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    // final box = Hive.box<TaskEntity>(taskBoxName);
    final themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditTaskScreen(
                    task: TaskEntity(),
                  )));
        },
        label: const Row(
          children: [
            Text('Add New Task'),
            SizedBox(
              width: 3,
            ),
            Icon(
              CupertinoIcons.add_circled,
              size: 20,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                themeData.colorScheme.primary,
                themeData.colorScheme.onPrimaryFixedVariant,
              ])),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To-Do List',
                          style: themeData.textTheme.headlineSmall!
                              .apply(color: themeData.colorScheme.onPrimary),
                        ),
                        Icon(
                          CupertinoIcons.share,
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 38,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: themeData.colorScheme.onPrimary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                            )
                          ]),
                      child: TextField(
                        onChanged: (value) {
                          searchKeywordNotifier.value = controller.text;
                        },
                        controller: controller,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.search),
                            label: Text('Search Tasks')),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: searchKeywordNotifier,
                builder: (context, value, child) {
                  // final repository =
                  //     Provider.of<Repository<TaskEntity>>(context);
                  // if (controller.text.isEmpty) {

                  // } else {
                  //   items = box.values
                  //       .where((task) => task.name.contains(controller.text))
                  //       .toList();
                  // }
                  return Consumer<Repository<TaskEntity>>(
                    builder: (context, repository, child) {
                      return FutureBuilder<List<TaskEntity>>(
                          future:
                              repository.getAll(searchKeyword: controller.text),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return TaskList(
                                    items: snapshot.data!,
                                    themeData: themeData);
                              } else {
                                return const EmptyState();
                              }
                            } else {
                              return const CircularProgressIndicator();
                            }
                          });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.items,
    required this.themeData,
  });

  final List<TaskEntity> items;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today',
                      //style: themeData.textTheme!.apply(fontSizeFactor: 0.8),
                    ),
                    Container(
                      width: 70,
                      height: 3,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                    )
                  ],
                ),
                MaterialButton(
                    color: const Color(0xffEAEFF5),
                    textColor: secondaryTextColor,
                    elevation: 0,
                    onPressed: () {
                      final taskRepository =
                          Provider.of<Repository<TaskEntity>>(context, listen: false);
                      taskRepository.deleteAll();
                    },
                    child: const Row(
                      children: [
                        Text('Delete All'),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          CupertinoIcons.delete_solid,
                          size: 18,
                        ),
                      ],
                    )),
              ],
            );
          } else {
            final TaskEntity task = items[index - 1];
            return TaskItem(task: task);
          }
        });
  }
}

class TaskItem extends StatefulWidget {
  static const double height = 74;
  static const double borderRadius = 8;

  const TaskItem({
    super.key,
    required this.task,
  });

  final TaskEntity task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Color priorityColor;
    switch (widget.task.priority) {
      case Priority.low:
        priorityColor = lowPriority;
      case Priority.normal:
        priorityColor = normalPriority;
      case Priority.high:
        priorityColor = highPriority;
    }
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditTaskScreen(task: widget.task)));
      },
      onLongPress: () {
        widget.task.delete();
      },
      child: Container(
        height: TaskItem.height,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TaskItem.borderRadius),
            color: themeData.colorScheme.surface,
            boxShadow: [
              BoxShadow(blurRadius: 10, color: Colors.grey.withOpacity(0.2))
            ]),
        child: Row(
          children: [
            MyCheckBox(
              value: widget.task.isCompleted,
              onTap: () {
                setState(() {
                  widget.task.isCompleted = !widget.task.isCompleted;
                });
              },
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                widget.task.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              width: 5,
              height: TaskItem.height,
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(TaskItem.borderRadius),
                  bottomRight: Radius.circular(TaskItem.borderRadius),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
