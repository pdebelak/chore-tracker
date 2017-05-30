var ChoreTracker = ChoreTracker || {};
ChoreTracker.Bulma = (function() {
  function handleDelete() {
    var parent = this.parentNode;
    parent.parentNode.removeChild(parent);
  }

  function addNotification(message, klass) {
    var div = document.createElement('div');
    div.className = ['notification', 'global-notification', klass].join(' ');
    var button = document.createElement('button');
    button.className = 'delete';
    button.addEventListener('click', ChoreTracker.Bulma.handleDelete);
    div.appendChild(button);
    var container = document.createElement('div');
    container.className = 'container';
    container.textContent = message;
    div.appendChild(container);
    var body = document.getElementsByTagName('body')[0];
    body.insertBefore(div, body.firstChild);
  }

  function createBox(html, id) {
    var box = document.createElement('section');
    box.className = 'box';
    box.id = id;
    box.innerHTML = html;
    return box;
  }

  return {
    handleDelete: handleDelete,
    addNotification: addNotification,
    createBox: createBox,
  };
})();

document.addEventListener('turbolinks:load', function() {
  var deletes = document.querySelectorAll('button.delete');
  for (var i=0;i<deletes.length;i++) {
    deletes[i].addEventListener('click', ChoreTracker.Bulma.handleDelete);
  }
});
