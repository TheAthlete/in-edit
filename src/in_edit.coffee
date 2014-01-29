#
# Project's main unit
#
# Copyright (C) 2014 TheAthlete
#
class InEdit extends Form
  include: core.Options
  extend:
    Options: # default options
      url:    null    # the url address where to send the stuff
      name:   'text'  # the field name
      method: 'put'   # the method

      type:   'text'  # the input type, 'text', 'file', 'password' or 'textarea'

      toggle:  null   # a reference to an element that should get hidden when the editor is active

      update:  true   # a marker if the element should be updated with the response-text

      Xhr: {}          # additional XMLHTTPRequerst options

    i18n:
      Save: 'Save'
      Cancel: 'Cancel'

    current: null

  #
  # Constructor
  #
  # @param mixed an element reference
  # @param Object options
  # @return void
  #
  constructor: (element, options) ->
    element = $(element)

    @field    = new Input(type: @options.type, name: @options.name, class: 'field')
    @spinner  = new Spinner(4)
    @submit   = new Input(type: 'submit', class: 'submit', value: InEdit.i18n.Save)
    @cancel   = new Element('a', class: 'cancel', href: '#', html: InEdit.i18n.Cancel)

    @$super(options).addClass('in-edit').attr('action', @options.url)
    @append(@field, @spinner, @submit, @cancel).on('click', @clicked).on('submit', @send)
  
  # 
  # Shows the inline-editor form
  # 
  # @return InEdit this
  # 
  show: ->
    if InEdit.current isnt @
      InEdit.current.hide() if InEdit.current

      @oldContent = @element.html()

      @field.attr('value', @oldContent) unless @options.type in ['file', 'password']

      @element.update @
      
      @spinner.hide()
      @submit.show()

      $(@options.toggle).hide() if @options.toggle

      @field.focus() if @options.type isnt "file"

      InEdit.current = @
      @emit 'show'


  # 
  # Hides the form and brings the content back
  # 
  # @param String optional new content
  # @return InEdit this
  # 
  hide: ->
    @element._.innerHTML = @oldContent

    @ajax.cancel() if @ajax

    @finish()

  # 
  # Triggers the form remote submit
  # 
  # @return InEdit this
  # 
  send: (event) ->
    event.stop() if event

    @spinner.show().size(@submit.size())
    @submit.hide()

    @ajax = new Ajax(@options.url, Hash.merge(@options.Xhr, method: @options.method, spinner: @spinner))
    @ajax.on 'complete', bind(@receive, @)
    @ajax.send()

    @emit 'send'


# protected

  # finishes up with the form
  finish: ->
    $(@options.toggle).show() if @options.toggle

    InEdit.current = null

    @emit 'hide'

  # the xhr callback
  receive: ->
    if @options.update
      @element.update(@ajax.responseText)
      @emit 'update'

    @ajax = null

    @finish()

  # catches clicks on the element
  clicked: (event) ->
    if event.target is @cancel
      event.stop()
      @hide()
