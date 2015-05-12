`import Ember from 'ember'`

dasherize = Ember.String.dasherize

ApplicationSettingsService = Ember.Service.extend
  localStoragePrefix: 'sln-mobile-application-setting'

  getSetting: (name) ->
    localStorage.getItem(@localStorageKey(name)) or @defaultValue(name)

  changeSetting: (name, value) ->
    localStorage.setItem(@localStorageKey(name), value)

  localStorageKey: (name) ->
    "#{@localStoragePrefix}--#{@normalizeKey(name)}"

  normalizeKey: (key) ->
    dasherize(key)

  defaultValue: (name) -> @defaultValues[@normalizeKey(name)]

  defaultValues:
    'sites-sort-method': 'proximity'

`export default ApplicationSettingsService`
