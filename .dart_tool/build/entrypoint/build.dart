// ignore_for_file: directives_ordering
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:json_serializable/builder.dart' as _i2;
import 'package:mobx_codegen/builder.dart' as _i3;
import 'package:source_gen/builder.dart' as _i4;
import 'package:auto_route_generator/builder.dart' as _i5;
import 'package:injectable_generator/builder.dart' as _i6;
import 'dart:isolate' as _i7;
import 'package:build_runner/build_runner.dart' as _i8;
import 'dart:io' as _i9;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(r'json_serializable:json_serializable', [_i2.jsonSerializable],
      _i1.toDependentsOf(r'json_serializable'),
      hideOutput: true,
      appliesBuilders: const [r'source_gen:combining_builder']),
  _i1.apply(r'mobx_codegen:mobx_generator', [_i3.storeGenerator],
      _i1.toDependentsOf(r'mobx_codegen'),
      hideOutput: true,
      appliesBuilders: const [r'source_gen:combining_builder']),
  _i1.apply(r'source_gen:combining_builder', [_i4.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: const [r'source_gen:part_cleanup']),
  _i1.apply(r'auto_route_generator:autoRouteGenerator',
      [_i5.autoRouteGenerator], _i1.toDependentsOf(r'auto_route_generator'),
      hideOutput: false),
  _i1.apply(r'injectable_generator:injectable_builder', [_i6.injectableBuilder],
      _i1.toDependentsOf(r'injectable_generator'),
      hideOutput: true),
  _i1.apply(
      r'injectable_generator:injectable_config_builder',
      [_i6.injectableConfigBuilder],
      _i1.toDependentsOf(r'injectable_generator'),
      hideOutput: false),
  _i1.applyPostProcess(r'source_gen:part_cleanup', _i4.partCleanup)
];
void main(List<String> args, [_i7.SendPort? sendPort]) async {
  var result = await _i8.run(args, _builders);
  sendPort?.send(result);
  _i9.exitCode = result;
}
