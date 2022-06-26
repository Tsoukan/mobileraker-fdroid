import 'package:flutter/material.dart';
import 'package:mobileraker/data/dto/server/klipper.dart';
import 'package:mobileraker/ui/common/mixins/selected_machine_mixin.dart';
import 'package:stacked/stacked.dart';

mixin KlippyMixin on SelectedMachineMixin {
  @protected
  static const KlippyDataStreamKey = 'cKlippy';

  bool get isKlippyInstanceReady => dataReady(KlippyDataStreamKey);

  KlipperInstance get klippyInstance => dataMap![KlippyDataStreamKey];

  bool get klippyCanReceiveCommands =>
      isKlippyInstanceReady &&
      klippyInstance.klippyState == KlipperState.ready &&
      klippyInstance.klippyConnected;

  @override
  Map<String, StreamData> get streamsMap {
    Map<String, StreamData> parentMap = super.streamsMap;

    return {
      ...parentMap,
      if (this.isSelectedMachineReady)
        KlippyDataStreamKey:
            StreamData<KlipperInstance>(klippyService.klipperStream),
    };
  }
}