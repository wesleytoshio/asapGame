// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$valorAtom = Atom(name: '_LoginControllerBase.valor');

  @override
  String get valor {
    _$valorAtom.reportRead();
    return super.valor;
  }

  @override
  set valor(String value) {
    _$valorAtom.reportWrite(value, super.valor, () {
      super.valor = value;
    });
  }

  @override
  String toString() {
    return '''
valor: ${valor}
    ''';
  }
}
