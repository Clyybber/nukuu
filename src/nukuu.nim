import jack/[jack, midiport]
import system/ansi_c, os
from posix import EEXIST
from strutils import split

when defined(benchmarking): import times
template benchable(code: untyped) =
  when defined(benchmarking):
    let t0 = cpuTime()
    for i in 0..10000:
      code
    let t1 = cpuTime()
    echo t1 - t0
  else:
    code

type Note* = object
  start*: JackNFrames
  stop*: JackNFrames
  freq*: uint8
  vel*: uint8

import parse

var notes: seq[Note]

var loopNsamp: JackNFrames
var loopIndex: JackNFrames

var outputPort: JackPort

var exit = false

proc process(nframes: JackNFrames, arg: pointer): cint {.cdecl.} =
  var portBuf = jackPortGetBuffer(outputPort, nframes)
  jackMidiClearBuffer(portBuf)

  if unlikely(exit):
    when false:
      var buffer = cast[ptr UncheckedArray[JackMidiData]](jackMidiEventReserve(portBuf, 0, 3))
      buffer[0] = 0xB0.char  #channel mode
      buffer[1] = 0x7B.char  #all notes off
      buffer[2] = 0x00.char
    else:
      for j in 0..<notes.len:
        var buffer = cast[ptr UncheckedArray[JackMidiData]](jackMidiEventReserve(portBuf, 0, 3))
        buffer[0] = 0x80.char  #note off
        buffer[1] = JackMidiData notes[j].freq
        buffer[2] = JackMidiData notes[j].vel
    exit = false
    return

  for i in 0..<nframes:
    for j in 0..<notes.len:
      if loopIndex == notes[j].start:
        var buffer = cast[ptr UncheckedArray[JackMidiData]](jackMidiEventReserve(portBuf, i, 3))
        buffer[0] = 0x90.char  #note on
        buffer[1] = JackMidiData notes[j].freq
        buffer[2] = JackMidiData notes[j].vel
      elif loopIndex == notes[j].stop:
        var buffer = cast[ptr UncheckedArray[JackMidiData]](jackMidiEventReserve(portBuf, i, 3))
        buffer[0] = 0x80.char  #note off
        buffer[1] = JackMidiData notes[j].freq
        buffer[2] = JackMidiData notes[j].vel
    loopIndex = if loopIndex+1 >= loopNsamp: 0'u32 else: loopIndex+1

var client: JackClient

proc nukuu(
    inputFile: string = "",
    eval: string = "",
    beatLength = 1.0,
    scale = "c,c#|db,d,d#|eb,e|fb,e#|f,f#|gb,g,g#|ab,a,a#|hb|b,h|cb,h#|c",
    name: string = "nukuu",
    connect = ""
  ) =

  var inputLines = if eval.len > 0: @[eval]
                   else:
                     if inputFile.len == 0: quit "Please provide an input file or a string to evaluate. See `nukuu --help`"
                     readFile(inputFile).split('\n')

  var scaleAllCandidates: seq[(int8, int8)]
  var (scale, octaveLength) = parseScale(scale)
  for toneIdx, names in scale:
    for nameIdx, _ in names:
      scaleAllCandidates.add (toneIdx.int8, nameIdx.int8)

  var status: JackStatus
  client = jackClientOpen(name, {}, status)
  if client == nil: quit "JACK server not running?"

  discard client.jackSetProcessCallback(process, nil)
  outputPort = client.jackPortRegister("out", JACK_DEFAULT_MIDI_TYPE, JackPortIsOutput.uint32, 0)

  var defaultLength = JackNFrames(beatLength * client.jackGetSampleRate().float64)

  benchable:
    (notes, loopNsamp) = parseNoteLine(inputLines[0], defaultLength, octaveLength, scale, scaleAllCandidates)

  if connect.len > 0:
    if client.jackConnect(jack_port_name(outputPort), connect) notin {0, EEXIST}:
      echo "could not autoconnect"

  if client.jackActivate() != 0: quit "cannot activate client"

  proc signalHandler(sig: cint) {.noconv.} =
    exit = true
    while exit: # Wait until all notes off has been sent
      sleep 1
    discard client.jackPortDisconnect(outputPort)
    discard client.jackClientClose()
    quit()
  c_signal(SIGTERM, signalHandler)
  c_signal(SIGINT, signalHandler)

  sleep int.high

  discard client.jackClientClose()

when isMainModule:
  import cligen; dispatch(nukuu)
