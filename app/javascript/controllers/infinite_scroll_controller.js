import { Controller } from "stimulus";

export default class extends Controller {
  initialize() {
    let options = {
      rootMargin: "200px",
    };

    this.intersectionObserver = new IntersectionObserver(
      (entries) => this.processIntersectionEntries(entries),
      options
    );
  }

  connect() {
    this.intersectionObserver.observe(this.element);
  }

  disconnect() {
    this.intersectionObserver.unobserve(this.element);
  }

  processIntersectionEntries(entries) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        this.loadMore();
      }
    });
  }

  loadMore() {
    this.element.click();
  }
}
