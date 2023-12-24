class SettingsConstants {
  static const baseUrl = 'BASE_URL';
}

class EndpointConstants {
  static const getCategories = 'GET_CATEGORIES';
  static const saveCategories = 'SAVE_CATEGORIES';
  static const deleteCategory = 'DELETE_CATEGORY';
  static const saveCategory = 'SAVE_CATEGORY';

  static const getContexts = 'GET_CONTEXTS';
  static const saveContexts = 'SAVE_CONTEXTS';
  static const deleteContext = 'DELETE_CONTEXT';
  static const saveContext = 'SAVE_CONTEXT';

  static const getExpenses = 'GET_EXPENSES';
  static const saveExpenses = 'SAVE_EXPENSES';
  static const deleteExpense = 'DELETE_EXPENSE';
  static const saveExpense = 'SAVE_EXPENSE';

  static const getOrigins = 'GET_ORIGINS';
  static const saveOrigins = 'SAVE_ORIGINS';
  static const deleteOrigin = 'DELETE_ORIGIN';
  static const saveOrigin = 'SAVE_ORIGIN';

  static const getIncomes = 'GET_INCOMES';
  static const saveIncome = 'SAVE_INCOME';

  static const saveCashflow = 'SAVE_CASHFLOW';
  static const getCashflows = 'GET_CASHFLOWS';
}

abstract class ISettings {
  String get baseUrl;
  Map<String, String> get endpoints;
  String endpointByName(String name);
}

class Settings implements ISettings {
  final String env;

  Settings({this.env = 'dev'});

  final mapOfEndpointsByEnv = {
    'dev': {
      EndpointConstants.getCategories: '/category',
      EndpointConstants.saveCategories: '/category',
      EndpointConstants.deleteCategory: '/category/{id}',
      EndpointConstants.saveCategory: '/category',
      EndpointConstants.getContexts: '/context',
      EndpointConstants.saveContexts: '/context',
      EndpointConstants.deleteContext: '/context/{id}',
      EndpointConstants.saveContext: '/context',
      EndpointConstants.getExpenses: '/expense',
      EndpointConstants.saveExpenses: '/expense',
      EndpointConstants.deleteExpense: '/expense/{id}',
      EndpointConstants.saveExpense: '/expense',
      EndpointConstants.getOrigins: '/origin',
      EndpointConstants.saveOrigin: '/origin',
      EndpointConstants.deleteOrigin: '/origin/{id}',
      EndpointConstants.getIncomes: '/income',
      EndpointConstants.saveIncome: '/income',
      EndpointConstants.saveCashflow: '/cashflow',
      EndpointConstants.getCashflows: '/cashflow',
    },
    'prod': {
      EndpointConstants.getCategories: '/category',
      EndpointConstants.saveCategories: '/category',
      EndpointConstants.deleteCategory: '/category/{id}',
      EndpointConstants.getContexts: '/contexts',
      EndpointConstants.saveContexts: '/contexts',
      EndpointConstants.deleteContext: '/contexts/{id}',
      EndpointConstants.getExpenses: '/expenses',
      EndpointConstants.saveExpense: '/expenses',
      EndpointConstants.deleteExpense: '/expenses/{id}',
      EndpointConstants.getOrigins: '/origins',
      EndpointConstants.saveOrigin: '/origins',
      EndpointConstants.deleteOrigin: '/origins/{id}',
      EndpointConstants.getIncomes: '/income',
      EndpointConstants.saveIncome: '/income',
      EndpointConstants.saveCashflow: '/cashflow',
      EndpointConstants.getCashflows: '/cashflow',
    },
  };

  final mapOfSettingsByEnv = {
    'dev': {
      SettingsConstants.baseUrl:
          'https://c6bs6iq059.execute-api.sa-east-1.amazonaws.com/api',
    },
    'prod': {
      SettingsConstants.baseUrl:
          'https://c6bs6iq059.execute-api.sa-east-1.amazonaws.com/api',
    },
  };

  @override
  String get baseUrl => mapOfSettingsByEnv[env]![SettingsConstants.baseUrl]!;

  @override
  Map<String, String> get endpoints => mapOfEndpointsByEnv[env]!;

  @override
  String endpointByName(String name) {
    return baseUrl + mapOfEndpointsByEnv[env]![name]!;
  }
}
