// Generated by CoffeeScript 1.4.0
(function() {
  var options, restoreOptions, saveOptions;

  options = [["hide-sport", "angel-hide-sport"], ["hide-hider", "angel-hide-hider"]];

  saveOptions = function() {
    var id, key, select, setting, status, _i, _len, _ref;
    status = $("#status");
    for (_i = 0, _len = options.length; _i < _len; _i++) {
      _ref = options[_i], id = _ref[0], key = _ref[1];
      select = document.getElementById(id);
      setting = select.children[select.selectedIndex].value;
      chrome.storage.local.set({
        key: setting
      }, (function(key, setting) {
        return function() {
          chrome.extension.sendRequest({
            action: 'reload'
          });
          console.log("" + key + " -> " + setting);
          if (chrome.runtime.lastError) {
            console.log("ERROR: " + chrome.runtime.lastError);
          }
          return chrome.storage.local.get(key, (function(key) {
            return function(obj) {
              return console.log("after set: " + key + " -> " + obj[key]);
            };
          })(key));
        };
      })(key, setting));
    }
    status.append("Options Saved.");
    return setTimeout(function() {
      return status.text("");
    }, 1750);
  };

  restoreOptions = function() {
    var id, key, _i, _len, _ref, _results;
    _results = [];
    for (_i = 0, _len = options.length; _i < _len; _i++) {
      _ref = options[_i], id = _ref[0], key = _ref[1];
      _results.push(chrome.storage.local.get(key, (function(id, key) {
        return function(obj) {
          var child, select, setting, _j, _len1, _ref1, _results1;
          setting = obj[key];
          select = document.getElementById(id);
          console.log("restore: " + key + " -> " + setting);
          _ref1 = select.children;
          _results1 = [];
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            child = _ref1[_j];
            if (child.value === setting) {
              child.selected = "true";
              break;
            } else {
              _results1.push(void 0);
            }
          }
          return _results1;
        };
      })(id, key)));
    }
    return _results;
  };

  window.restoreOptions = restoreOptions;

  document.addEventListener('DOMContentLoaded', restoreOptions);

  document.querySelector('#save').addEventListener('click', saveOptions);

}).call(this);
