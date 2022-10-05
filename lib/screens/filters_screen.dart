import 'package:flutter/material.dart';
import 'package:flutter_meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FiltersScreen({
    super.key,
    required this.saveFilters,
    required this.currentFilters,
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool)? updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final selectedFilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian
                };
                widget.saveFilters(selectedFilter);
              }),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection.',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
          child: ListView(children: [
            _buildSwitchListTile(
                'Gluten-free', 'Only include gluten-free meal', _glutenFree,
                (newVal) {
              setState(() {
                _glutenFree = newVal;
              });
            }),
            _buildSwitchListTile(
                'Lactose-free', 'Only include lactose-free meal', _lactoseFree,
                (newVal) {
              setState(() {
                _lactoseFree = newVal;
              });
            }),
            _buildSwitchListTile(
                'Vegetarian', 'Only include vegetarian meal', _vegetarian,
                (newVal) {
              setState(() {
                _vegetarian = newVal;
              });
            }),
            _buildSwitchListTile('Vegan', 'Only include vegan meal', _vegan,
                (newVal) {
              setState(() {
                _vegan = newVal;
              });
            })
          ]),
        )
      ]),
    );
  }
}
