import 'package:expence_tracker/models/expences.dart';
import 'package:flutter/material.dart';

class ExpenceList extends StatelessWidget {
  ExpenceList(this.expences, this.removeItem, {super.key});
  void Function(Expences exp) removeItem;
  final List<Expences> expences;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expences.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expences[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          onDismissed: (direction) {
            removeItem(expences[index]);
          },
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expences[index].title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      "\$${expences[index].amount.toStringAsFixed(2)}",
                      //textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Icon(
                      categoryIcons[expences[index].category],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      expences[index].formatedDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
