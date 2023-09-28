part of '../address_page.dart';

class _AddressItem extends StatelessWidget {

  final String address;
  final String additional;
  final VoidCallback onTap;

  const _AddressItem({required this.address, required this.additional, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(Icons.location_on, color: Colors.black,),
          radius: 30,
          backgroundColor: Colors.white,
        ),
        title: Text(address),
        subtitle: Text(additional),
      ),
    );
  }
}
