export default function() {
  this.transition(
    this.fromRoute('sites'),
    this.toRoute('site.index'),
    this.use('toLeft')
  );

  this.transition(
    this.fromRoute('site.index'),
    this.toRoute('sites'),
    this.use('toRight')
  );
}
