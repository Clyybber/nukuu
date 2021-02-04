{.experimental: "codeReordering".}
const JackLib = "libjack.so.0"


type
  JackUuid* = uint64
  JackShmsize* = int32


type
  JackNframes* = uint32


const
  JackMaxFrames* = (4294967295'i64)


type
  JackTime* = uint64


const
  JackLoadInitLimit* = 1024


type
  JackIntclient* = uint64


type
  JackPort* = pointer


type
  JackClient* = pointer


type
  JackPortId* = uint32
  JackPortTypeId* = uint32


type
  JackOptions* = set[JackOption]
  JackOption* {.size: sizeof(cint).} = enum
    JackNullOption = 0x00000000, JackNoStartServer = 0x00000001, JackUseExactName = 0x00000002, JackServerName = 0x00000004, JackLoadName = 0x00000008, JackLoadInit = 0x00000010, JackSessionID = 0x00000020



const
  JackOpenOptions* = (JackSessionID, JackServerName, JackNoStartServer, JackUseExactName)


const
  JackLoadOptions* = (JackLoadInit, JackLoadName, JackUseExactName)






type
  JackStatus* = set[JackState]
  JackState* {.size: sizeof(cint).} = enum
    JackFailure = 0x00000001, JackInvalidOption = 0x00000002, JackNameNotUnique = 0x00000004, JackServerStarted = 0x00000008, JackServerFailed = 0x00000010, JackServerError = 0x00000020, JackNoSuchClient = 0x00000040, JackLoadFailure = 0x00000080, JackInitFailure = 0x00000100, JackShmFailure = 0x00000200, JackVersionError = 0x00000400, JackBackendError = 0x00000800, JackClientZombie = 0x00001000







type
  JackLatencyCallbackMode* {.size: sizeof(cint).} = enum
    JackCaptureLatency, JackPlaybackLatency







type
  JackLatencyCallback* = proc (mode: JackLatencyCallbackMode; arg: pointer) {.cdecl.}


type
  JackLatencyRange* {.bycopy.} = object
    min*: JackNframes
    max*: JackNframes




type
  JackProcessCallback* = proc (nframes: JackNframes; arg: pointer): cint {.cdecl.}


type
  JackThreadCallback* = proc (arg: pointer): pointer {.cdecl.}


type
  JackThreadInitCallback* = proc (arg: pointer) {.cdecl.}


type
  JackGraphOrderCallback* = proc (arg: pointer): cint {.cdecl.}


type
  JackXRunCallback* = proc (arg: pointer): cint {.cdecl.}


type
  JackBufferSizeCallback* = proc (nframes: JackNframes; arg: pointer): cint {.cdecl.}


type
  JackSampleRateCallback* = proc (nframes: JackNframes; arg: pointer): cint {.cdecl.}


type
  JackPortRegistrationCallback* = proc (port: JackPortId; a2: cint; arg: pointer) {.cdecl.}


type
  JackClientRegistrationCallback* = proc (name: cstring; a2: cint; arg: pointer) {.cdecl.}


type
  JackPortConnectCallback* = proc (a: JackPortId; b: JackPortId; connect: cint; arg: pointer) {.cdecl.}


type
  JackPortRenameCallback* = proc (port: JackPortId; oldName: cstring; newName: cstring; arg: pointer) {.cdecl.}


type
  JackFreewheelCallback* = proc (starting: cint; arg: pointer) {.cdecl.}


type
  JackShutdownCallback* = proc (arg: pointer) {.cdecl.}


type
  JackInfoShutdownCallback* = proc (code: JackStatus; reason: cstring; arg: pointer) {.cdecl.}


const
  JackDefaultAudioType* = "32 bit float mono audio"
  JackDefaultMidiType* = "8 bit raw midi"


type
  JackDefaultAudioSample* = cfloat


type
  JackPortFlags* = set[JackPortFlag]
  JackPortFlag* {.size: sizeof(cint).} = enum
    JackPortIsInput = 0x00000001, JackPortIsOutput = 0x00000002, JackPortIsPhysical = 0x00000004, JackPortCanMonitor = 0x00000008, JackPortIsTerminal = 0x00000010



type
  JackTransportState* {.size: sizeof(cint).} = enum
    JackTransportStopped = 0, JackTransportRolling = 1, JackTransportLooping = 2, JackTransportStarting = 3, JackTransportNetStarting = 4
  JackUnique* = uint64



type
  JackPositionBits* {.size: sizeof(cint).} = enum
    JackPositionBBT = 0x00000010, JackPositionTimecode = 0x00000020, JackBBTFrameOffset = 0x00000040, JackAudioVideoRatio = 0x00000080, JackVideoFrameOffset = 0x00000100



const
  JackPositionMask* = (JackPositionBBT, JackPositionTimecode)
  EXTENDEDTimeInfo* = true

type
  JackPosition* {.bycopy.} = object
    unique1*: JackUnique
    usecs*: JackTime
    frameRate*: JackNframes
    frame*: JackNframes
    valid*: JackPositionBits
    bar*: int32
    beat*: int32
    tick*: int32
    barStartTick*: cdouble
    beatsPerBar*: cfloat
    beatType*: cfloat
    ticksPerBeat*: cdouble
    beatsPerMinute*: cdouble
    frameTime*: cdouble
    nextTime*: cdouble
    bbtOffset*: JackNframes
    audioFramesPerVideoFrame*: cfloat
    videoOffset*: JackNframes
    padding*: array[7, int32]
    unique2*: JackUnique




type
  JackSyncCallback* = proc (state: JackTransportState; pos: ptr JackPosition; arg: pointer): cint {.cdecl.}


type
  JackTimebaseCallback* = proc (state: JackTransportState; nframes: JackNframes; pos: ptr JackPosition; newPos: cint; arg: pointer) {.cdecl.}


type
  JackTransportBits* {.size: sizeof(cint), pure.} = enum
    JackTransportState = 0x00000001, JackTransportPosition = 0x00000002, JackTransportLoop = 0x00000004, JackTransportSMPTE = 0x00000008, JackTransportBBT = 0x00000010



type
  JackTransportInfo* {.bycopy.} = object
    frameRate*: JackNframes
    usecs*: JackTime
    valid*: JackTransportBits
    transportState*: JackTransportState
    frame*: JackNframes
    loopStart*: JackNframes
    loopEnd*: JackNframes
    smpteOffset*: clong
    smpteFrameRate*: cfloat
    bar*: cint
    beat*: cint
    tick*: cint
    barStartTick*: cdouble
    beatsPerBar*: cfloat
    beatType*: cfloat
    ticksPerBeat*: cdouble
    beatsPerMinute*: cdouble

