import 'package:flutter/material.dart';
import 'package:task_manger/data/model/task.dart';

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
  });
  final Task task;
  @override
  State<StatefulWidget> createState() => _TaskItemCard();
}

class _TaskItemCard extends State<TaskItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(widget.task.description ?? ''),
            Text('Date: ${widget.task.createdDate}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_forever_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
