class PharmOwnerForm
  constructor: (el) ->
    @el = $(el)
    @target = $(@el.data('target'))

    @el.on('click', 'button[type=submit]', @submit)

  form: => $('form', @el)

  ownerOption: (el) ->
    "<option id='#{el.id}'>#{el.name}</option>"

  rebuildOptions: =>
    items = $('.current-owners', @el).data('list')
    options = items.map(@ownerOption).join('')
    @target.html(options)
    @target.focus()

  clearOptions: =>
    # убираем алерт и прячем обратно под hidden
    @el.delay(5000).queue ->
      $(this).addClass('hidden')
      alert = $(this).find('.alert-success')
      alert.remove()
      return

  submit: (evt) =>
    # Не даем браузеру самостоятельно сделать submit
    evt.preventDefault()

    # Сериализируем и отправим форму.
    $(@form(), @el).ajaxSubmit (data) =>
      @el.html(data)
      @rebuildOptions()
      @clearOptions()

$(document).ready ->
  new PharmOwnerForm(form) for form in $('.script-pharm-owner-form')
