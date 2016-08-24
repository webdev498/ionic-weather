import Ember from 'ember';

export default Ember.Component.extend({
  pullThreshold: 35,

  spinnerTimeout: 1,

  pullToRefreshLoadingHtml: `
    <div class="pull-indicator">
      <div class="arrow-body"></div>
      <div class="triangle-down"></div>
    </div>
  `,

  didInsertElement() {
    this.setupPullToRefresh();
  },

  setupPullToRefresh() {
    this.$('>:first-child').xpull({
      callback: () => {
        this.sendAction('refreshData');
      },
      pullThreshold: this.get('pullThreshold'),
      spinnerTimeout: this.get('spinnerTimeout'),
      loadingHtml: this.get('pullToRefreshLoadingHtml'),
    });
  },
});
