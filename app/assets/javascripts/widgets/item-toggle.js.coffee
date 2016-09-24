class ItemToggle
  constructor: (el) ->
    @el = $(el)
    @item = $(@el.data('target'))

    @el.click(@toggle)

  toggle: (evt) =>
    @item.toggleClass("hidden")

$(document).ready ->
  new ItemToggle(button) for button in $('.script-item-toggle')
