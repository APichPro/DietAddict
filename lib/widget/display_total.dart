import 'package:diet_junkie/design.dart';
import 'package:diet_junkie/widget/color_text.dart';
import 'package:flutter/material.dart';

class DisplayTotal extends StatefulWidget {
  double tcal;
  double tprot;
  double tlip;
  double tglu;
  double vCal = 2500;
  double vprot = 30;
  double vlip = 20;
  double vglu = 50;

  bool? diffCal;
  bool? displayObj;
  DateTime? date;
  DateTime? weekDate;
  bool? reductedString;

  DisplayTotal({
    required this.tcal,
    required this.tglu,
    required this.tlip,
    required this.tprot,
    this.diffCal,
    this.displayObj,
    this.date,
    this.weekDate,
    this.reductedString,
    Key? key,
  }) : super(key: key);
  @override
  _DisplayTotalState createState() => _DisplayTotalState();
}

class _DisplayTotalState extends State<DisplayTotal> {
  @override
  Widget build(BuildContext context) {
    late DateTime lundi;
    late DateTime dimanche;
    if (widget.weekDate != null) {
      lundi = DateTime(widget.weekDate!.year, widget.weekDate!.month,
              widget.weekDate!.day)
          .subtract(Duration(days: widget.weekDate!.weekday - 1));
      dimanche = new DateTime(lundi.year, lundi.month, lundi.day)
          .add(Duration(days: 7));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.date != null)
          Text(
            '${widget.date?.day.toString()}/${widget.date?.month.toString()}',
            style: whiteTextStyle(15),
          ),
        if (widget.weekDate != null)
          Text(
            '${lundi.day.toString()}/${lundi.month.toString()}-${dimanche.day.toString()}/${dimanche.month.toString()}',
            style: whiteTextStyle(15),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.reductedString == true ? 'Cal :' : 'Calorie :',
              style: whiteTextStyle(25),
            ),
            Text(
              widget.tcal.toStringAsFixed(1),
              style: whiteTextStyle(30),
            ),
            if (widget.displayObj == true)
              Text(
                '/${widget.vCal}',
                style: whiteTextStyle(15),
              ),
          ],
        ),
        if (widget.diffCal == true)
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.reductedString == true ? 'Diff :' : 'Différentiel :',
                  style: whiteTextStyle(18),
                ),
                Text(
                  (widget.vCal - widget.tcal).toStringAsFixed(1),
                  style: whiteTextStyle(18),
                ),
              ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.reductedString == true ? 'Prot :' : 'Protide :',
              style: whiteTextStyle(23),
            ),
            ColorText(
                size: 25,
                ratio: (((((widget.tprot * 4) /
                                (widget.tprot * 4 +
                                    widget.tglu * 4 +
                                    widget.tlip * 9)) *
                            100) /
                        widget.vprot) *
                    100),
                text: widget.tprot == 0
                    ? '0'
                    : '${(((widget.tprot * 4) / ((widget.tprot * 4) + (widget.tglu * 4) + (widget.tlip * 9))) * 100).toStringAsFixed(0)}%'),
            if (widget.displayObj == true)
              Text(
                '/${widget.vprot}%',
                style: whiteTextStyle(15),
              ),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.reductedString == true ? 'Lip :' : 'Lipide :',
                style: whiteTextStyle(23),
              ),
              ColorText(
                  size: 25,
                  ratio: (((((widget.tlip * 9) /
                                  (widget.tprot * 4 +
                                      widget.tglu * 4 +
                                      widget.tlip * 9)) *
                              100) /
                          widget.vlip) *
                      100),
                  text: widget.tlip == 0
                      ? '0'
                      : '${(((widget.tlip * 9) / ((widget.tprot * 4) + (widget.tglu * 4) + (widget.tlip * 9))) * 100).toStringAsFixed(0)}%'),
              if (widget.displayObj == true)
                Text(
                  '/${widget.vlip}%',
                  style: whiteTextStyle(15),
                ),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.reductedString == true ? 'Glu :' : 'Glucide :',
                style: whiteTextStyle(23),
              ),
              ColorText(
                  size: 25,
                  ratio: (((((widget.tglu * 4) /
                                  (widget.tprot * 4 +
                                      widget.tglu * 4 +
                                      widget.tlip * 9)) *
                              100) /
                          widget.vglu) *
                      100),
                  text: widget.tglu == 0
                      ? '0'
                      : '${(((widget.tglu * 4) / ((widget.tprot * 4) + (widget.tglu * 4) + (widget.tlip * 9))) * 100).toStringAsFixed(0)}%'),
              if (widget.displayObj == true)
                Text(
                  '/${widget.vglu}%',
                  style: whiteTextStyle(15),
                ),
            ]),
      ],
    );
  }
}
