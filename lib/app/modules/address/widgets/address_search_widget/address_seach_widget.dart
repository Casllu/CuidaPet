part of '../../address_page.dart';

typedef AddressSelectedCallback = void Function(PlaceModel);

class _AddressSeachWidget extends StatefulWidget {
  final AddressSelectedCallback addressSelectedCallback;
  final PlaceModel? place;

  _AddressSeachWidget({
    super.key,
    required this.addressSelectedCallback,
    required this.place,
  });

  @override
  State<_AddressSeachWidget> createState() => _AddressSeachWidgetState();
}

class _AddressSeachWidgetState extends State<_AddressSeachWidget> {
  final _searchTextEC = TextEditingController();
  final _searchTextFN = FocusNode();

  final controller = Modular.get<AddressSearchController>();

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      _searchTextEC.text = widget.place?.address ?? '';
      _searchTextFN.requestFocus();
    }
  }

  @override
  void dispose() {
    _searchTextEC.dispose();
    _searchTextFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(style: BorderStyle.none, color: Colors.black));
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: TypeAheadFormField<PlaceModel>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _searchTextEC,
          focusNode: _searchTextFN,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_on),
            hintText: 'Insira um endereço',
            border: border,
            disabledBorder: border,
            enabledBorder: border,
          ),
        ),
        itemBuilder: (_, item) {
          return _ItemTile(
            address: item.address,
          );
        },
        onSuggestionSelected: _onSuggestionSelected,
        suggestionsCallback: _suggestionsCallback,
      ),
    );
  }

  Future<List<PlaceModel>> _suggestionsCallback(String pattern) async {
    if (pattern.isNotEmpty) {
      return controller.searchAddress(pattern);
    }

    return <PlaceModel>[];
  }

  void _onSuggestionSelected(suggestion) {
    _searchTextEC.text = suggestion.address;
    widget.addressSelectedCallback(suggestion);
  }
}

class _ItemTile extends StatelessWidget {
  final String address;

  _ItemTile({required this.address, });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
