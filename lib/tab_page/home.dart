import 'package:flutter/cupertino.dart';

/// 首页
class HomePage extends StatelessWidget {
  HomePage({Key key, @required this.title, @required this.data})
      : super(key: key);

  final String title;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return _HomeItemView(
            position: index,
            leading: CupertinoIcons.phone,
            content: data[index],
            onClick: () => print('你点击了${data[index]}!'),
          );
        },
      ),
    );
  }
}

/// item view
class _HomeItemView extends StatelessWidget {
  _HomeItemView(
      {Key key,
      @required this.position,
      @required this.leading,
      @required this.content,
      @required this.onClick})
      : super(key: key);

  final int position;
  final String content;
  final IconData leading;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color:
            position.isEven ? const Color(0xffca8687) : const Color(0xfff8aba6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(leading),
          Expanded(child: Center(child: Text(content))),
        ],
      ),
    );
  }
}
