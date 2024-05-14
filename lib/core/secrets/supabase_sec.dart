// ignore_for_file: constant_identifier_names

import 'package:clean_blog/core/utils/env/env.dart';

class SupaBaseSecrets {
  static final String SUPABASE_URL = Env.supabaseUrl;
  static final String SUPABASE_ANON_KEY = Env.supaBaseAnonkey;
}
