import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableAction { archive, share, more, edit, delete }

class SlidableWidget extends StatelessWidget {
  final String uniqueId;
  final Widget child;
  final Function(SlidableAction action) onDismissed;

  final SlidableController slidableController = SlidableController();

  SlidableWidget({
    @required this.child,
    @required this.uniqueId,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(uniqueId),
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      child: child,

      /// left side
      actions: <Widget>[
        // IconSlideAction(
        //   caption: 'Archive',
        //   color: Colors.blue,
        //   icon: Icons.archive,
        //   onTap: () => onDismissed(SlidableAction.archive),
        // ),
        // IconSlideAction(
        //   caption: 'Share',
        //   color: Colors.indigo,
        //   icon: Icons.share,
        //   onTap: () => onDismissed(SlidableAction.share),
        // ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => onDismissed(SlidableAction.delete),
        ),
      ],

      /// right side
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.teal,
          icon: Icons.edit,
          onTap: () => onDismissed(SlidableAction.edit),
        ),
      ],
    );
  }
}
