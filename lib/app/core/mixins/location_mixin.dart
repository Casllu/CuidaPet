import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

typedef TryAgain = void Function();

mixin LocationMixin<E extends StatefulWidget> on State<E>{
  void showDialogLocationServiceUnavailable() {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return AlertDialog(
            title: Text('Precisamos da sua localização'),
            content: Text(
              'Para realizar a busca da sua localização, precisamos que vc ative o GPS',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(contextDialog);
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(contextDialog);
                  Geolocator.openLocationSettings();
                },
                child: Text('Abrir configurações'),
              ),
            ],
          );
        });
  }

  void showDialogLocationDenied({TryAgain? tryAgain}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return AlertDialog(
            title: Text('Precisamos da sua autorização'),
            content: Text(
              'Para realizar a busca da sua localização, precisamos que vc autorize a utilização',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(contextDialog);
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(contextDialog);
                  if(tryAgain != null) {
                    tryAgain();
                  }
                },
                child: Text('Tentar Novamente'),
              ),
            ],
          );
        });
  }
  void showDialogLocationDeniedForever() {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return AlertDialog(
            title: Text('Precisamos da sua autorização'),
            content: Text(
              'Para realizar a busca da sua localização, precisamos que vc autorize a utilização. Clique no botão abrir cofigurações e autorize a utilização e clique novamente no botão Localização Atual',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(contextDialog);
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(contextDialog);
                  Geolocator.openLocationSettings();
                },
                child: Text('Abrir configurações'),
              ),
            ],
          );
        });
  }
}