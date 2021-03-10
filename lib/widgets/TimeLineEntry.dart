import 'package:check_to_check/core/models/TimeLineEntryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeLineEntry extends StatelessWidget {
  TimeLineEntry({this.model, @required this.onToggled});
  final TimeLineEntryModel model;
  final _biggerFont = TextStyle(fontSize: 18.0); //this should be higher!
  final ValueChanged<int> onToggled;

  void _handleToggle(bool value) {
      onToggled(model.id);
  }

  @override
  Widget build(BuildContext context) {
    final amount = model.isIncome ? "+ "+model.amount : model.amount;
    final subTitleStyle = new TextStyle(fontWeight: FontWeight.bold);
    final TextStyle amountStyle = model.isIncome ? new TextStyle(fontStyle: FontStyle.italic, color: Color(0xff07ce07), fontWeight: FontWeight.bold) : subTitleStyle;
    return LayoutBuilder(
        builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return _buildWide(amount, subTitleStyle, amountStyle);
      } else {
        return _buildCompact(amount, subTitleStyle, amountStyle);
      }
    });
  }

  //Used for wide displays
  Widget _buildWide(String amount, TextStyle subTitleStyle, TextStyle amountStyle) {
    return CheckboxListTile(
      value: model.enabled,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        model.description,
        style: _biggerFont,
      ),
      subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(model.date, style: subTitleStyle)],
                )),
            Expanded( child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(amount, style: amountStyle)],
            )),
            Expanded( child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(model.newTotal, style: subTitleStyle)],
            )),
          ]),
      secondary: IconButton(
        icon: Icon(
            Icons.edit_outlined,
            color: Colors.blueAccent),
        onPressed: (){
          debugPrint("Clicked on edit");
        },
      ),
      onChanged: (value) {
        _handleToggle(value);
      },
    );
  }

  //Used for smaller displays
  Widget _buildCompact(String amount, TextStyle subTitleStyle, TextStyle amountStyle) {
    return CheckboxListTile(
      value: model.enabled,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        model.description + " "+model.date,
        style: _biggerFont,
      ),
      subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded( child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text(amount, style: amountStyle)],
            )),
            Expanded( child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text(model.newTotal, style: subTitleStyle)],
            )),
          ]),
      secondary: IconButton(
        icon: Icon(
            Icons.edit_outlined,
            color: Colors.blueAccent),
        onPressed: (){
          debugPrint("Clicked on edit");
        },
      ),
      onChanged: (value) {
        _handleToggle(value);
      },
    );
  }
}
