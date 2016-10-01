class ItemToggle
  constructor: (el) ->
    @el = $(el)
    @item = $(@el.data('target'))
    @focus = $(@item).find('input:nth-of-type(1)')


    @el.click(@toggle)

  toggle: (evt) =>
    @item.toggleClass("hidden")
    # console.log(@item)
    @focus.focus()

hookInstances = ->
  new ItemToggle(button) for button in $('.script-item-toggle')

$(document).ready(hookInstances)
$(document).on('turbolinks:load', hookInstances)
