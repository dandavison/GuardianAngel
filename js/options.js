// Generated by CoffeeScript 1.4.0
(function() {
  var options, restoreOptions, saveOptions;

  options = [["hide-sport", "angel-hide-sport"], ["allow-unhiding", "angel-allow-unhiding"]];

  saveOptions = function() {
    var id, key, select, setting, status, _i, _len, _ref;
    for (_i = 0, _len = options.length; _i < _len; _i++) {
      _ref = options[_i], id = _ref[0], key = _ref[1];
      select = document.getElementById(id);
      setting = select.children[select.selectedIndex].value;
      localStorage[key] = setting;
    }
    status = document.getElementById("status");
    status.innerHTML = "Options Saved.";
    return setTimeout(function() {
      return status.innerHTML = "";
    }, 750);
  };

  restoreOptions = function() {
    var child, id, key, select, setting, _i, _len, _ref, _results;
    _results = [];
    for (_i = 0, _len = options.length; _i < _len; _i++) {
      _ref = options[_i], id = _ref[0], key = _ref[1];
      setting = localStorage[key];
      if (!setting) {
        continue;
      }
      select = document.getElementById(id);
      _results.push((function() {
        var _j, _len1, _ref1, _results1;
        _ref1 = select.children;
        _results1 = [];
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          child = _ref1[_j];
          if (child.value === settings) {
            child.selected = "true";
            break;
          } else {
            _results1.push(void 0);
          }
        }
        return _results1;
      })());
    }
    return _results;
  };

  document.addEventListener('DOMContentLoaded', restoreOptions);

  document.querySelector('#save').addEventListener('click', saveOptions);

}).call(this);
