class SettingsConstants {
  static const baseUrl = 'BASE_URL';
}

class EndpointConstants {
  static const getCategories = 'GET_CATEGORIES';
  static const saveCategories = 'SAVE_CATEGORIES';
  static const deleteCategory = 'DELETE_CATEGORY';

  static const getContexts = 'GET_CONTEXTS';
  static const saveContexts = 'SAVE_CONTEXTS';
  static const deleteContext = 'DELETE_CONTEXT';

  static const getExpenses = 'GET_EXPENSES';
  static const saveExpense = 'SAVE_EXPENSE';
  static const deleteExpense = 'DELETE_EXPENSE';

  static const getOrigins = 'GET_ORIGINS';
  static const saveOrigin = 'SAVE_ORIGIN';
  static const deleteOrigin = 'DELETE_ORIGIN';

  static const getIncomes = 'GET_INCOMES';
  static const saveIncome = 'SAVE_INCOME';
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
      EndpointConstants.getCategories: '/categories',
      EndpointConstants.saveCategories: '/categories',
      EndpointConstants.deleteCategory: '/categories/{id}',
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
    },
    'prod': {
      EndpointConstants.getCategories: '/categories',
      EndpointConstants.saveCategories: '/categories',
      EndpointConstants.deleteCategory: '/categories/{id}',
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
    },
  };

  final mapOfSettingsByEnv = {
    'dev': {
      SettingsConstants.baseUrl:
          'https://b7xtmm9hbj.execute-api.sa-east-1.amazonaws.com/api',
    },
    'prod': {
      SettingsConstants.baseUrl:
          'https://b7xtmm9hbj.execute-api.sa-east-1.amazonaws.com/api',
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
