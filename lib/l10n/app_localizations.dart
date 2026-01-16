import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @add_property.
  ///
  /// In en, this message translates to:
  /// **'Add Property'**
  String get add_property;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @property_added_success.
  ///
  /// In en, this message translates to:
  /// **'Property added successfully!'**
  String get property_added_success;

  /// No description provided for @amenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities : '**
  String get amenities;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area : '**
  String get area;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price : '**
  String get price;

  /// No description provided for @beds.
  ///
  /// In en, this message translates to:
  /// **'Beds'**
  String get beds;

  /// No description provided for @baths.
  ///
  /// In en, this message translates to:
  /// **'Baths'**
  String get baths;

  /// No description provided for @edit_property.
  ///
  /// In en, this message translates to:
  /// **'Edit Property'**
  String get edit_property;

  /// No description provided for @address_details.
  ///
  /// In en, this message translates to:
  /// **'Address details'**
  String get address_details;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete_property.
  ///
  /// In en, this message translates to:
  /// **'Delete Property'**
  String get delete_property;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @my_properties.
  ///
  /// In en, this message translates to:
  /// **'My Properties'**
  String get my_properties;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @no_properties.
  ///
  /// In en, this message translates to:
  /// **'No properties available'**
  String get no_properties;

  /// No description provided for @no_properties_yet.
  ///
  /// In en, this message translates to:
  /// **'No properties yet'**
  String get no_properties_yet;

  /// No description provided for @no_bookings_found.
  ///
  /// In en, this message translates to:
  /// **'No bookings found'**
  String get no_bookings_found;

  /// No description provided for @my_properties_booking.
  ///
  /// In en, this message translates to:
  /// **'My Properties Booking'**
  String get my_properties_booking;

  /// No description provided for @error_loading_bookings.
  ///
  /// In en, this message translates to:
  /// **'Error loading bookings:'**
  String get error_loading_bookings;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @apply_filter.
  ///
  /// In en, this message translates to:
  /// **'Apply filter'**
  String get apply_filter;

  /// No description provided for @filter_results.
  ///
  /// In en, this message translates to:
  /// **'Filter Results'**
  String get filter_results;

  /// No description provided for @no_results.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get no_results;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category : '**
  String get category;

  /// No description provided for @pricing_range.
  ///
  /// In en, this message translates to:
  /// **'Pricing range'**
  String get pricing_range;

  /// No description provided for @bedrooms.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get bedrooms;

  /// No description provided for @bathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get bathrooms;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @per_night.
  ///
  /// In en, this message translates to:
  /// **'per night'**
  String get per_night;

  /// No description provided for @per_mon.
  ///
  /// In en, this message translates to:
  /// **'/per mon'**
  String get per_mon;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'BOOK'**
  String get book;

  /// No description provided for @bedrooms_label.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get bedrooms_label;

  /// No description provided for @bathrooms_label.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get bathrooms_label;

  /// No description provided for @this_apartment_booked.
  ///
  /// In en, this message translates to:
  /// **'This apartment is booked:'**
  String get this_apartment_booked;

  /// No description provided for @choose_available_date.
  ///
  /// In en, this message translates to:
  /// **'Choose an available date:'**
  String get choose_available_date;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From : '**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To :      '**
  String get to;

  /// No description provided for @total_price.
  ///
  /// In en, this message translates to:
  /// **'Total price'**
  String get total_price;

  /// No description provided for @booking_success.
  ///
  /// In en, this message translates to:
  /// **'Booking created successfully'**
  String get booking_success;

  /// No description provided for @select_city_governorate.
  ///
  /// In en, this message translates to:
  /// **'Please select governorate and city'**
  String get select_city_governorate;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get profile;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get edit_profile;

  /// No description provided for @top_up_balance.
  ///
  /// In en, this message translates to:
  /// **'Top Up Balance'**
  String get top_up_balance;

  /// No description provided for @enter_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount you would like to top up:'**
  String get enter_amount;

  /// No description provided for @balance_success.
  ///
  /// In en, this message translates to:
  /// **'Balance topped up successfully'**
  String get balance_success;

  /// No description provided for @enter_valid_amount.
  ///
  /// In en, this message translates to:
  /// **'Enter valid amount'**
  String get enter_valid_amount;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// No description provided for @enter_phone_num.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enter_phone_num;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enter_pass.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_pass;

  /// No description provided for @enter_pass_again.
  ///
  /// In en, this message translates to:
  /// **'Enter your password again'**
  String get enter_pass_again;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t you have an account?'**
  String get dontHaveAccount;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get create_account;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @pass_confirm.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation'**
  String get pass_confirm;

  /// No description provided for @your_first_name.
  ///
  /// In en, this message translates to:
  /// **'Your first name'**
  String get your_first_name;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enter_first_name;

  /// No description provided for @your_last_name.
  ///
  /// In en, this message translates to:
  /// **'Your last name'**
  String get your_last_name;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enter_last_name;

  /// No description provided for @your_birthday.
  ///
  /// In en, this message translates to:
  /// **'Your birthday'**
  String get your_birthday;

  /// No description provided for @birth_date.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birth_date;

  /// No description provided for @date_hint.
  ///
  /// In en, this message translates to:
  /// **'Day / Month / Year'**
  String get date_hint;

  /// No description provided for @your_photo.
  ///
  /// In en, this message translates to:
  /// **'Your photo'**
  String get your_photo;

  /// No description provided for @your_id_photo.
  ///
  /// In en, this message translates to:
  /// **'Your ID photo'**
  String get your_id_photo;

  /// No description provided for @select_image.
  ///
  /// In en, this message translates to:
  /// **'Please select images'**
  String get select_image;

  /// No description provided for @my_booking.
  ///
  /// In en, this message translates to:
  /// **'My Booking'**
  String get my_booking;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @update_request.
  ///
  /// In en, this message translates to:
  /// **'Update request'**
  String get update_request;

  /// No description provided for @no_bookings.
  ///
  /// In en, this message translates to:
  /// **'No bookings found'**
  String get no_bookings;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @my_favorite.
  ///
  /// In en, this message translates to:
  /// **'My favorite'**
  String get my_favorite;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
