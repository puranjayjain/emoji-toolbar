Emoji = require './emoji-data'

module.exports =
class EmojiToolbarView
  constructor: (serializedState) ->
    # TODO
    # use the serialized state in storing the value of recently used emojis
    # Create root element
    # TODO change it to scroll-view element
    @element = document.createElement 'div'
    @element.classList.add 'emoji-toolbar'

    # use document fragment for best performance
    docFrag = document.createDocumentFragment()
    # use the while -ve loop for max performance
    i = len = Emoji.length
    while i
      # create emoji button
      button = document.createElement 'BUTTON'
      button.classList.add 'btn'
      # create emoji image
      img = document.createElement 'img'
      # IDEA
      # convert this path to absolute path according to the current install of package
      # or simply put all emoji names as classnames and all emoji paths inside them in main less file
      img.src = Emoji[len - i].path
      # add image to button
      button.appendChild img
      # append them to document fragment
      docFrag.appendChild button
      i--
    # append fragment to main body
    @element.appendChild docFrag

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
