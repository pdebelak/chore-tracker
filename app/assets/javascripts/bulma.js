document.addEventListener('turbolinks:load', function() {
  var deletes = document.querySelectorAll('button.delete');
  for (var i=0;i<deletes.length;i++) {
    deletes[i].addEventListener('click', function() {
      var parent = this.parentNode;
      parent.parentNode.removeChild(parent);
    });
  }
});
