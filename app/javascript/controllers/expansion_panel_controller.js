import {Controller} from 'stimulus';

// See https://daemonite.github.io/material/docs/4.1/components/collapse
// and https://daemonite.github.io/material/docs/4.1/material/expansion-panels
// for documentation and examples.
//
// This controller collapses an element manually
// instead of 'automatically' when using `data-toggle='collapse'
// since we need a way to prevent the toggling when clicking
// on a link or button inside the collapse parent.
//
// See app/views/articles/_article.html.slim for a use case.
//
// This example controller works with specially annotated HTML like:
//
// <div data-action="click->expansion-panel#toggle" data-controller="expansion-panel">
//   ...
//   <div data-toggle="no-collapse">
//     <!-- links and buttons will *not* toggle the panel -->
//   </div>
//   ...
//
//   <div class="collapse">...</div>
// </div>
//
export default class extends Controller {
  toggle(e) {
    if (e.target.closest('[data-toggle="no-collapse"]')) return;

    $(this.element)
      .find('.collapse')
      .collapse('toggle');
  }
}
