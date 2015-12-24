// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require maskedinput
//= require maskmoney


$( document ).ready(function() {
  jQuery(function($){
    $('.edit_account').on('submit', function() {
       var balance = document.getElementById("account_balance");
       value = $('#account_balance').maskMoney('unmasked')[0];
       $('#account_balance').maskMoney('destroy');
       balance.value = value
    });

    $('.new_account').on('submit', function() {
       var balance = document.getElementById("account_balance");
       value = $('#account_balance').maskMoney('unmasked')[0];
       $('#account_balance').maskMoney('destroy');
       balance.value = value
    });

    $("#holder_cpf").mask("999.999.999-99");
    $("#account_agency").mask("9999-9");
    $("#account_account").mask("99999-9");
    $("#account_balance").val(parseFloat($('#account_balance').val()).toFixed(2));
    $('#account_balance').maskMoney();
  });
});

