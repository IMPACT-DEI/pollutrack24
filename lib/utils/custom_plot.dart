import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:pollutrack24/models/inhalation_rate.dart';

class CustomPlot extends StatelessWidget {
  const CustomPlot({
    Key? key,
    required this.inhalationRates,
  }) : super(key: key);

  final List<InhalationRate> inhalationRates;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = _parseData(inhalationRates);
    return Chart(
      rebuild: true,
      data: data,
      variables: {
        'date': Variable(
          accessor: (Map map) => map['date'] as String,
          scale: OrdinalScale(tickCount: 5),
        ),
        'points': Variable(
          accessor: (Map map) => map['points'] as num,
        ),
        'type': Variable(
          accessor: (Map map) => map['type'] as String,
        ),
      },
      marks: <Mark<Shape>>[
        LineMark(
          position: Varset('date') * Varset('points') / Varset('type'),
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          size: SizeEncode(value: 2),
          color: ColorEncode(
              values: [const Color(0xFF326F5E), const Color(0xFF89453C)],
              variable: 'type'),
        ),
        AreaMark(
            gradient: GradientEncode(
          value: LinearGradient(
            begin: const Alignment(0, 0),
            end: const Alignment(0, 1),
            colors: [
              const Color(0xFF326F5E).withOpacity(0.6),
              const Color(0xFFFFFFFF).withOpacity(0.0),
            ],
          ),
        ))
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {'tap': PointSelection(dim: Dim.x)},
    );
  }

  List<Map<String, dynamic>> _parseData(List<InhalationRate> inhalationRates) {
    var out = inhalationRates
        .map(
          (e) => {
            'date': DateFormat('HH:mm').format(e.timestamp),
            'points': e.value,
            'type': 'Inhalation Rate',
          },
        )
        .toList();

    return out.toList();
  }
}
