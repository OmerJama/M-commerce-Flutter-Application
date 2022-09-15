import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';

class DashboardCard extends ConsumerStatefulWidget {
  final String title;
  final int number;
  final Icon icon;
  final Color notSelectedColour;
  final Color selectedColour;
  final EdgeInsetsGeometry padding;
  const DashboardCard(
      {Key? key,
      required this.title,
      required this.number,
      required this.icon,
      required this.padding,
      required this.selectedColour,
      required this.notSelectedColour})
      : super(key: key);

  @override
  ConsumerState<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends ConsumerState<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    final firestore = ref.watch(firestoreProvider);

    return Padding(
      padding: widget.padding,
      child: Card(
        child: ListTile(
            title: TextButton.icon(
              onPressed: () {},
              icon: widget.icon,
              label: Text(widget.title,
                  style: TextStyle(
                    color: widget.notSelectedColour,
                  )),
            ),
            subtitle: FutureBuilder<int>(
              future: firestore?.countCategoryDocuments(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.selectedColour,
                        fontSize: 42,
                        fontFamily: 'Mula'),
                  );
                } else {
                  return const Text("0");
                }
              },
            )),
      ),
    );
  }
}
