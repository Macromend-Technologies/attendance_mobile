library app_core;

import 'package:macro_attendance_app/Core/AppModel/app_profile.dart';
import 'package:macro_attendance_app/Core/Engine/dialogue_engine.dart';
import 'package:macro_attendance_app/Core/Engine/http_engine.dart';
import 'package:macro_attendance_app/Core/Engine/sp_engine.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Core/application_core.dart';
import 'package:get_it/get_it.dart';
export 'dart:async';
export 'package:flutter/material.dart';
export 'Base/base_model.dart';
export 'Base/base_view.dart';
export 'package:provider/provider.dart';
export 'package:flutter/foundation.dart';
export 'package:shared_preferences/shared_preferences.dart';

part 'app_base.dart';

part 'locator.dart';

SpEngine? spEngine;
ApplicationCore? applicationCore;
HttpEngine? httpEngine;
DialogueEngine? dialogueEngine;


setUpBase() {
  locator.registerSingleton(SpEngine());
  locator.registerSingleton(HttpEngine());
  locator.registerSingleton(DialogueEngine());
  locator.registerSingleton(ApplicationCore());
  spEngine = locator.get<SpEngine>();
  httpEngine = locator.get<HttpEngine>();
  dialogueEngine = locator.get<DialogueEngine>();
  applicationCore = locator.get<ApplicationCore>();
}

Future<void> initApplication(Widget rootApplication,
    {required AppProfile debugProfile,
    required AppProfile releaseProfile}) async {
  await setUpBase();
  switch (ProfileManager.getProfileState()) {
    case ProfileState.debug:
      // print("Switch debug mode");
      applicationCore!._appProfile = debugProfile;
      break;
    case ProfileState.profile:
      applicationCore!._appProfile = debugProfile;
      break;
    case ProfileState.release:
      applicationCore!._appProfile = releaseProfile;
      break;
  }
  runApp(Provider<ApplicationCore>(
    create: (context) => applicationCore!,
    builder: (context, child) => rootApplication,
  ));
}
