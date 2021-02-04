from jack/jack import JackNFrames
from nukuu import Note
import strutils

type State = object
  beatLength: JackNFrames # Default beat length; influenced by > and <
  noteLength: JackNFrames # Default note length; influenced by _ and .
  transposition: int8 # Offset in notes (think octave transposition); influenced by ' and ,
  velocity: uint8 # Velocity; influenced by ! and ?

proc parseNoteLine*(input: string, defaultLength: JackNFrames, octaveLength: int, scale: seq[seq[string]], scaleAllCandidates: seq[(int8, int8)]): tuple[notes: seq[Note], length: JackNFrames] =
  var currPos = 0'u32
  var i = 0
  var lastGroupStartStack: seq[tuple[begin: int, prevState: State]]
  var currState = State(
    beatLength: defaultLength,
    noteLength: defaultLength,
    transposition: 0,
    velocity: 60
  )
  while i < input.len:
    var f: int8
    var lengthOfTone: int
    block:
      var candidates = scaleAllCandidates
      var charIdx = 0 
      while candidates.len > 0:
        var newCandidates: seq[(int8, int8)]
        for (toneIdx, nameIdx) in candidates:
          if charIdx < scale[toneIdx][nameIdx].len and i + charIdx < input.len and
             input[i + charIdx] == scale[toneIdx][nameIdx][charIdx]:
            if charIdx + 1 == scale[toneIdx][nameIdx].len:
              f = toneIdx # Definitely found one
              lengthOfTone = charIdx + 1
            else:
              newCandidates.add (toneIdx, nameIdx)

        candidates = newCandidates
        inc charIdx

    if lengthOfTone > 0:
      inc i, lengthOfTone

      f += 48 # start from c
      f += currState.transposition

      var beatLength = currState.beatLength
      var noteLength = currState.noteLength
      var vel = currState.velocity

      while i < input.len:
        case input[i]
        of '\'':
          inc f, octaveLength
        of ',':
          dec f, octaveLength
        of '_':
          noteLength += defaultLength
          beatLength += defaultLength
        of '.':
          noteLength = noteLength div 2
        of '!':
          vel += currState.velocity
        of '?':
          vel = vel div 2
        else: break
        inc i

      result.notes.add Note(start: currPos,
                            stop: currPos + noteLength - 1'u32,
                            freq: uint8(f), vel: uint8(vel))
      currPos += beatLength.uint32
    else:
      case input[i]
      of '>':
        currState.beatLength = currState.beatLength div 2
        currState.noteLength = currState.noteLength div 2
        inc i
      of '<':
        currState.beatLength *= 2
        currState.noteLength *= 2
        inc i
      of '[':
        lastGroupStartStack.add (result.notes.len, currState)
        inc i
        template postFixOps(i) =
          while i < input.len:
            case input[i]
            of '\'':
              inc currState.transposition, octaveLength
            of ',':
              dec currState.transposition, octaveLength
            of '_':
              currState.noteLength += defaultLength
              currState.beatLength += defaultLength
            of '.':
              currState.noteLength = currState.noteLength div 2
            of '!':
              currState.velocity += currState.velocity
            of '?':
              currState.velocity = currState.velocity div 2
            else: break
            inc i
        postFixOps(i)
        block searchForEnd:
          var j = i
          while j < input.len:
            case input[j]
            of ']':
              inc j
              postFixOps(j)
              break searchForEnd
            else: inc j
          echo "unclosed ["
      of ']':
        inc i
        while i < input.len:
          case input[i]
          of '\'',',','_','.','!','?': discard # Handled already
          else: break
          inc i
        currState = lastGroupStartStack[^1].prevState
        lastGroupStartStack.setLen lastGroupStartStack.len - 1
      of ' ':
        # ignore silently
        inc i
      else:
        echo "ignoring '",input[i],"'"
        inc i

  result.length = currPos

func parseScale*(scaleString: string): tuple[scale: seq[seq[string]], octaveLength: int] =
  var scaleSeq = scaleString.split(',')
  result.scale.setLen scaleSeq.len
  result.octaveLength = scaleSeq.len
  for i in 0..<scaleSeq.len:
    result.scale[i] = scaleSeq[i].split('|')
  for i in 0..<result.scale[^1].len:
    if result.scale[^1][i] in result.scale[0]:
      result.scale[^1].delete(i)
      dec result.octaveLength
      break

