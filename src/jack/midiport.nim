import types
export types
{.experimental: "codeReordering".}
const JackLib = "libjack.so.0"



type
  JackMidiData* = cuchar


type
  JackMidiEvent* {.bycopy.} = object
    time*: JackNframes
    size*: csize_t
    buffer*: ptr JackMidiData



proc jackMidiGetEventCount*(portBuffer: pointer): uint32 {.cdecl, importc: "jack_midi_get_event_count", dynlib: JackLib.}

proc jackMidiEventGet*(event: var JackMidiEvent; portBuffer: pointer; eventIndex: uint32): cint {.cdecl, importc: "jack_midi_event_get", dynlib: JackLib.}

proc jackMidiClearBuffer*(portBuffer: pointer) {.cdecl, importc: "jack_midi_clear_buffer", dynlib: JackLib.}

proc jackMidiResetBuffer*(portBuffer: pointer) {.cdecl, importc: "jack_midi_reset_buffer", dynlib: JackLib.}

proc jackMidiMaxEventSize*(portBuffer: pointer): csize_t {.cdecl, importc: "jack_midi_max_event_size", dynlib: JackLib.}

proc jackMidiEventReserve*(portBuffer: pointer; time: JackNframes; dataSize: csize_t): ptr JackMidiData {.cdecl, importc: "jack_midi_event_reserve", dynlib: JackLib.}

proc jackMidiEventWrite*(portBuffer: pointer; time: JackNframes; data: var JackMidiData; dataSize: csize_t): cint {.cdecl, importc: "jack_midi_event_write", dynlib: JackLib.}

proc jackMidiGetLostEventCount*(portBuffer: pointer): uint32 {.cdecl, importc: "jack_midi_get_lost_event_count", dynlib: JackLib.}
