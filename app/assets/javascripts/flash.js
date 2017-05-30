var ChoreTracker = ChoreTracker || {};
ChoreTracker.Flash = (function() {
  function removeElem(elem) {
    if (elem) {
      elem.parentNode.removeChild(elem);
    }
  }

  function removeFlash() {
    var existingSuccess = document.querySelector('.is-success.global-notification');
    var existingError = document.querySelector('.is-danger.global-notification');
    removeElem(existingSuccess);
    removeElem(existingError);
  }

  function addFlash(flash) {
    if (flash.success) {
      ChoreTracker.Bulma.addNotification(flash.success, 'is-success');
    } else if (flash.error) {
      ChoreTracker.Bulma.addNotification(flash.error, 'is-danger');
    }
  }
  return {
    removeFlash: removeFlash,
    addFlash: addFlash,
  };
})();
