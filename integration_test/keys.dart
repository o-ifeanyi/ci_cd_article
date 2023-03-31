import 'package:flutter/foundation.dart';

class Keys {
  // Auth
  static const emailField = ValueKey('email_field');
  static const passwordField = ValueKey('password_field');
  static const confirmPassField = ValueKey('confirm_password_field');
  static const authBtn = ValueKey('auth_button');
  static const authSwitchBtn = ValueKey('auth_switch_button');

  // Home
  static const addBtn = ValueKey('add_button');
  static const titleField = ValueKey('title_field');
  static const addNewItemBtn = ValueKey('add_new_item_button');
  static const deleteBtn = ValueKey('delete_button');
  static const searchField = ValueKey('search_field');
  static const profileBtn = ValueKey('profile_button');
  static const divider = ValueKey('divider');

  // Profile
  static const logoutBtn = ValueKey('logout_button');
  static const deleteAccBtn = ValueKey('delete_acc_button');
  static const contDeleteAccBtn = ValueKey('continue_delete_acc_button');
}
