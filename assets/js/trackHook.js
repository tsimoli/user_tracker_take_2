export default {
  mounted() {
    this.pushEvent("content_visible", { content_visible: true });
    document.addEventListener("visibilitychange", (_) => {
      if (document.visibilityState == "visible") {
        this.pushEvent("content_visible", { content_visible: true });
      } else {
        this.pushEvent("content_visible", { content_visible: false });
      }
    });
  },
};
