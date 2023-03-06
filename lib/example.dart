import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final DecorationTween _tween = DecorationTween(
  begin: BoxDecoration(
    color: CupertinoColors.systemYellow,
    boxShadow: const <BoxShadow>[],
    borderRadius: BorderRadius.circular(20.0),
  ),
  end: BoxDecoration(
    color: CupertinoColors.systemYellow,
    boxShadow: CupertinoContextMenu.kEndBoxShadow,
    borderRadius: BorderRadius.circular(20.0),
  ),
);

void main() => runApp(const ContextMenuApp());

class ContextMenuApp extends StatelessWidget {
  const ContextMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ContextMenuExample(),
    );
  }
}

class ContextMenuExample extends StatelessWidget {
  const ContextMenuExample({super.key});

  // Or just do this inline in the builder below?
  static Animation<Decoration> _boxDecorationAnimation(
      Animation<double> animation) {
    return _tween.animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.0,
          CupertinoContextMenu.animationOpensAt,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoContextMenu Sample'),
      ),
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CupertinoContextMenu.builder(
            actions: <Widget>[
              CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                trailingIcon: CupertinoIcons.heart,
                child: const Text('Favorite'),
              ),
              CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                trailingIcon: CupertinoIcons.eye_slash,
                child: const Text('Hide'),
              ),
              CupertinoContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
                trailingIcon: CupertinoIcons.delete,
                child: const Text('Delete'),
              ),
            ],
            builder: (BuildContext context, Animation<double> animation) {
              final Animation<Decoration> boxDecorationAnimation =
                  _boxDecorationAnimation(animation);

              return Container(
                decoration:
                    animation.value < CupertinoContextMenu.animationOpensAt
                        ? boxDecorationAnimation.value
                        : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemYellow,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const FlutterLogo(size: 500.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
