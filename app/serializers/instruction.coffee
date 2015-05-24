`import ApplicationSerializer from './application'`

InstructionSerializer = ApplicationSerializer.extend
  attrs:
    smartlinkController:
      serialize: false
      deserialize: 'id'

`export default InstructionSerializer`
