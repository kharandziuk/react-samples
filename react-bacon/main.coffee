React = require('react')
Bacon = require('baconjs').Bacon
# Reverses a given string.
reverse = (s) -> s.split('').reverse().join('')

# Reverses the text property of a given object.
reverseText = (object) ->
  object.text = reverse(object.text)
  object

# A text field component binds the text in an <input> element to an output stream.
TextField = React.createClass
  getInitialState: ->
    text: ''

  handleChange: (text) ->
    @setState({text}, -> @props.stream.push(@state))

  render: ->
    valueLink = {value: @state.text, requestChange: @handleChange}
    React.DOM.input(type: 'text', placeholder: 'Enter some text', valueLink: valueLink)

# A label component binds an input stream to the text in a <p> element.
Label = React.createClass
  getInitialState: ->
    text: ''

  componentWillMount: ->
    console.log this.text
    @props.stream.onValue(@setState.bind(@))

  render: ->
    React.DOM.p(null, @state.text)

# The text stream object represents the state of the text field component over time.
textStream = new Bacon.Bus

# The label stream is the text stream with the reverseText function mapped over it.
labelStream = textStream.map(reverseText)

React.renderComponent(
  React.DOM.div(
    null,
    TextField(stream: textStream),
    Label(stream: labelStream)
  ),
  document.body
)
