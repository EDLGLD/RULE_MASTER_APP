// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'; // BootstrapのJavaScriptをインポート
import '../stylesheets/application'; // CSSをインポート

// Optional: jQueryのインポート（Bootstrapの一部の機能に必要）
import 'jquery';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Turbolinksのページが読み込まれたときにBootstrapのドロップダウンを初期化
document.addEventListener('turbolinks:load', () => {
  // Bootstrapのドロップダウンを再初期化
  var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'));
  var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
    return new bootstrap.Dropdown(dropdownToggleEl);
  });
});