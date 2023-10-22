import 'package:flutter/material.dart';

class OptionBar extends StatelessWidget {
  final double _borderRadius;
  final Color _borderColor;
  final List<String> _items;

  OptionBar(this._borderRadius, this._borderColor, this._items);

  @override
  Widget build(BuildContext context) {    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        border: Border.all(color: _borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            items: _items.map((value) => DropdownMenuItem(child: Text(value))).toList(),
            onChanged: (value) {
              
            },
          ),
        ),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final Text? _title;
  final Text? _subtitle;
  final Widget _image;
  final Icon? _icon;
  final Color _cardColor;

  const BlogCard(this._title, this._subtitle, this._image, this._icon, this._cardColor);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _cardColor,
      child: Row(
        children: [
          _image,
          Expanded(
            child: ListTile(
              title: _title,
              subtitle: _subtitle,
              trailing: _icon,
            ),
          ),
        ],
      ),
    );
  }
}