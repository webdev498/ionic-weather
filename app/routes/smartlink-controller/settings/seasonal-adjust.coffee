`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`
`import { translationMacro as t } from 'ember-i18n'`

months = []

getSeasonalAdjust = (programs, identifier, monthIndex) ->
  programs.findBy('identifier', identifier).get('programSeasonalAdjustments').findBy('month', parseInt(monthIndex)+1)

SmartlinkControllerSettingsSeasonalAdjustRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  i18n: Ember.inject.service(),
  init: ->
    months = [
      this.get('i18n').t('common.months.jan'),
      this.get('i18n').t('common.months.feb'),
      this.get('i18n').t('common.months.mar'),
      this.get('i18n').t('common.months.apr'),
      this.get('i18n').t('common.months.may'),
      this.get('i18n').t('common.months.jun'),
      this.get('i18n').t('common.months.jul'),
      this.get('i18n').t('common.months.aug'),
      this.get('i18n').t('common.months.sep'),
      this.get('i18n').t('common.months.oct'),
      this.get('i18n').t('common.months.nov'),
      this.get('i18n').t('common.months.dec')
    ]
  model: (params) ->
    id = @paramsFor('smartlink-controller').controllerId
    @store.find('smartlink-controller', id).then (ctrl) ->
      ctrl.get('programs').then (programs) ->
        {
          smartlinkController: ctrl
          months: months.map (monthName, monthIndex) ->
            {
              name: monthName
              index: monthIndex
              programASeasonalAdjust: getSeasonalAdjust(programs, 'A', monthIndex)
              programBSeasonalAdjust: getSeasonalAdjust(programs, 'B', monthIndex)
              programCSeasonalAdjust: getSeasonalAdjust(programs, 'C', monthIndex)
              programDSeasonalAdjust: getSeasonalAdjust(programs, 'D', monthIndex)
            }
        }

})

`export default SmartlinkControllerSettingsSeasonalAdjustRoute`
