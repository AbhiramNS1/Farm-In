import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int value;
  final int upperValue;
  final double labelFontSize;
  final ValueChanged<int> onValueChanged;
  final TextEditingController controller;

  QuantitySelector(
      {this.value = 1,
      this.upperValue = 999,
      this.labelFontSize = 19,
      required this.onValueChanged,
      required this.controller});

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.value;
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final value = int.tryParse(widget.controller.text);
    if (value != null) {
      setState(() {
        _quantity = value.clamp(1, widget.upperValue);
        widget.onValueChanged(_quantity);
      });
    }
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        widget.controller.text = _quantity.toString();
        widget.onValueChanged(_quantity);
      }
    });
  }

  void _increment() {
    setState(() {
      if (_quantity < widget.upperValue) {
        _quantity++;
        widget.controller.text = _quantity.toString();
        widget.onValueChanged(_quantity);
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        SizedBox(
          width: 100,
          child: TextField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              border: OutlineInputBorder(),
              labelText: 'Quantity',
              labelStyle: TextStyle(fontSize: widget.labelFontSize),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
