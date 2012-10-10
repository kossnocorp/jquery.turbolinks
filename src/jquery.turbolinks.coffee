###
  jquery.turbolinks.js ~ v0.1.0 ~ https://github.com/kossnocorp/jquery.turbolinks

  jQuery plugin for drop-in fix binded events problem caused by Turbolinks

  The MIT License

  Copyright (c) 2012 Sasha Koss
###

$ = require?('jquery') || window.jQuery

# List for store callbacks passed to `$` or `$.ready`
callbacks = []

# Call each callback in list
ready = ->
  callback() for callback in callbacks

# Bind `ready` to DOM ready event
$(ready)

# Store callbacks in list on `$` and `$.ready`
$.fn.ready = (callback) ->
  callbacks.push(callback)

# Bind `ready` to Tubolinks page change event
$(document).on('page:load', ready)
