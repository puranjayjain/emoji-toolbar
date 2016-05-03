Emoji = require './emoji-data'

{View} = require 'atom-space-pen-views'

module.exports =
class EmojiToolbarHeaderView extends View

  # currently selected tab
  current = 'people'

  @content: ->
    @div class: 'emoji-toolbar-header btn-group padded', =>
      @button outlet: 'recently', class: 'btn', 'Recently Used'
      for category, data of Emoji
        selected = ''
        # TODO change this logic to the default one of recently used emoji and select this after it is declared empty
        if category is 'people'
          selected = 'selected'
        @button outlet: "#{category}", class: "btn #{selected}", category.capitalizeFirstLetter()


  initialize: (serializeState) ->

  addEvents: ->
    # for just the recently selected tab
    @recently.on 'click', (e) =>
      console.log e
      console.log @
    # for all emoji category
    for category, data of Emoji
      @["#{category}"].on 'click', (e) =>
        if @current isnt category
          console.log e
          console.log @

  # TODO
  # use the serialized state in storing the value of recently used emojis
  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    # @subscriptions.dispose()
    @element.remove()

  getElement: ->
    @element

  # capitalize first letter of string
  String::capitalizeFirstLetter = ->
    @charAt(0).toUpperCase() + @slice(1)
