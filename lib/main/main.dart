import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flychat/main/flavors.dart';
import 'package:flychat/presentation/app/app.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void appMain({required AppFlavor appFlavor}) async {

  F.appFlavor = appFlavor;
  await F.loadEnvironment();

  const requiredEnvVars = ['SUPABASE_URL', 'SUPABASE_ANON_KEY'];

  bool hasEnv = dotenv.isEveryDefined(requiredEnvVars);

  debugPrint("API_BASE_URL:${dotenv.env['SUPABASE_URL']}");


  if (!hasEnv) {
    throw Exception('Missing the environment variables');
  }

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(MyApp());
}
