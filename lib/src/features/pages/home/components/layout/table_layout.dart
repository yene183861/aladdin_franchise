import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TableLayoutPage extends StatefulWidget {
  const TableLayoutPage({super.key});

  @override
  State<TableLayoutPage> createState() => _TableLayoutPageState();
}

class _TableLayoutPageState extends State<TableLayoutPage> {
  final Map<String, Offset> _tablePositions = {};
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadPositions();
  }

  Future<void> _loadPositions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('table_positions_ratio');
    if (data != null) {
      final decoded = jsonDecode(data) as Map<String, dynamic>;
      decoded.forEach((key, value) {
        _tablePositions[key] = Offset(
          (value['dx'] as num).toDouble(),
          (value['dy'] as num).toDouble(),
        );
      });
    } else {
      // Khởi tạo vị trí mặc định theo tỉ lệ
      for (int i = 1; i <= 30; i++) {
        _tablePositions['Bàn $i'] = Offset(0.1 * i, 0.2);
      }
    }
    setState(() => _isLoaded = true);
  }

  Future<void> _savePositions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _tablePositions.map((key, offset) => MapEntry(
          key,
          {'dx': offset.dx, 'dy': offset.dy},
        ));
    await prefs.setString('table_positions_ratio', jsonEncode(data));
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sơ đồ bàn (theo tỉ lệ)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePositions,
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final maxHeight = constraints.maxHeight;

                return InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(200),
                  minScale: 0.5,
                  maxScale: 2.5,
                  child: Stack(
                    children: _tablePositions.entries.map((entry) {
                      final absolutePosition = Offset(
                        entry.value.dx * maxWidth,
                        entry.value.dy * maxHeight,
                      );

                      return MovableTable(
                        label: entry.key,
                        initialPosition: absolutePosition,
                        onPositionChanged: (newOffset) {
                          final ratio = Offset(
                            (newOffset.dx / maxWidth).clamp(0.0, 1.0),
                            (newOffset.dy / maxHeight).clamp(0.0, 1.0),
                          );
                          setState(() => _tablePositions[entry.key] = ratio);
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovableTable extends StatefulWidget {
  final String label;
  final Offset initialPosition;
  final ValueChanged<Offset> onPositionChanged;

  const MovableTable({
    super.key,
    required this.label,
    required this.initialPosition,
    required this.onPositionChanged,
  });

  @override
  State<MovableTable> createState() => _MovableTableState();
}

class _MovableTableState extends State<MovableTable> {
  late Offset _position;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta;
          });
          widget.onPositionChanged(_position);
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.teal.shade400,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(2, 3),
              )
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
