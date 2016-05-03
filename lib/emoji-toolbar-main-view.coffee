Emoji = require './emoji-data'

{ScrollView} = require 'atom-space-pen-views'

{CompositeDisposable} = require 'atom'

module.exports =
class EmojiToolbarMainView extends ScrollView
  # to manage the disposable events and tooltips
  subscriptions: null

  @content: ->
    @div class: 'emoji-toolbar-main', =>
      for category, data of Emoji
        hideClass = 'invisible'
        # set invisible class to all except the first category of people
        if category is 'people'
          hideClass = ''
          @div class: 'emoji-toolbar-list recently invisible', =>
            @ul class: 'background-message', =>
              @li 'No emojis used recently'
        @div class: "emoji-toolbar-list btn-group #{hideClass} #{category}", =>
          # use the while -ve loop for max performance
          i = len = data.length
          while i
            # create emoji button
            @button outlet: "#{category}[#{len - i}]", class: 'btn', 'data-emoji': "#{atom.packages.getPackageDirPaths()[0]}\\emoji-toolbar\\#{data[len - i].name}", =>
              # add image to button
              @img src: "#{atom.packages.getPackageDirPaths()[0]}\\emoji-toolbar\\#{data[len - i].path}"
            i--

  initialize: (serializeState) ->

  addTooltips: ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    # add tooltips
    for category, data of Emoji
      # use the while -ve loop for max performance
      i = len = data.length
      while i
        @subscriptions.add atom.tooltips.add @["#{category}[#{len - i}]"], {title: data[len - i].name}
        i--

  # TODO
  # use the serialized state in storing the value of recently used emojis
  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @subscriptions.dispose()
    @element.remove()

  getElement: ->
    @element
