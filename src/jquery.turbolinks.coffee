###
  jquery.turbolinks.js ~ v0.1.0 ~ https://github.com/kossnocorp/jquery.turbolinks

  jQuery plugin for rebind events problem caused by Tubrolinks

  The MIT License

  Copyright (c) 2012 Sasha Koss
###

$ = require?('jquery') || window.jQuery

callbacks = []

ready = ->
  callback() for callback in callbacks

$(ready)

$.fn.ready = (callback) ->
  callbacks.push(callback)

$(document).on('page:change', ready)
