import types
export types
{.experimental: "codeReordering".}
const JackLib = "libjack.so.0"




proc jackGetVersion*(majorPtr: var cint; minorPtr: var cint; microPtr: var cint; protoPtr: var cint) {.cdecl, importc: "jack_get_version", dynlib: JackLib.}

proc jackGetVersionString*(): cstring {.cdecl, importc: "jack_get_version_string", dynlib: JackLib.}

proc jackClientOpen*(clientName: cstring; options: JackOptions; status: var JackStatus): JackClient {.varargs, cdecl, importc: "jack_client_open", dynlib: JackLib.}

proc jackClientNew*(clientName: cstring): JackClient {.cdecl, importc: "jack_client_new", dynlib: JackLib.}

proc jackClientClose*(client: JackClient): cint {.cdecl, importc: "jack_client_close", dynlib: JackLib.}

proc jackClientNameSize*(): cint {.cdecl, importc: "jack_client_name_size", dynlib: JackLib.}

proc jackGetClientName*(client: JackClient): cstring {.cdecl, importc: "jack_get_client_name", dynlib: JackLib.}

proc jackGetUuidForClientName*(client: JackClient; clientName: cstring): cstring {.cdecl, importc: "jack_get_uuid_for_client_name", dynlib: JackLib.}

proc jackGetClientNameByUuid*(client: JackClient; clientUuid: cstring): cstring {.cdecl, importc: "jack_get_client_name_by_uuid", dynlib: JackLib.}

proc jackInternalClientNew*(clientName: cstring; loadName: cstring; loadInit: cstring): cint {.cdecl, importc: "jack_internal_client_new", dynlib: JackLib.}

proc jackInternalClientClose*(clientName: cstring) {.cdecl, importc: "jack_internal_client_close", dynlib: JackLib.}

proc jackActivate*(client: JackClient): cint {.cdecl, importc: "jack_activate", dynlib: JackLib.}

proc jackDeactivate*(client: JackClient): cint {.cdecl, importc: "jack_deactivate", dynlib: JackLib.}

proc jackGetClientPid*(name: cstring): cint {.cdecl, importc: "jack_get_client_pid", dynlib: JackLib.}

#proc jackClientThreadId*(client: JackClient): JackNativeThread {.cdecl, importc: "jack_client_thread_id", dynlib: JackLib.}

proc jackIsRealtime*(client: JackClient): cint {.cdecl, importc: "jack_is_realtime", dynlib: JackLib.}

proc jackThreadWait*(client: JackClient; status: cint): JackNframes {.cdecl, importc: "jack_thread_wait", dynlib: JackLib.}

proc jackCycleWait*(client: JackClient): JackNframes {.cdecl, importc: "jack_cycle_wait", dynlib: JackLib.}

proc jackCycleSignal*(client: JackClient; status: cint) {.cdecl, importc: "jack_cycle_signal", dynlib: JackLib.}

proc jackSetProcessThread*(client: JackClient; threadCallback: JackThreadCallback; arg: pointer): cint {.cdecl, importc: "jack_set_process_thread", dynlib: JackLib.}

proc jackSetThreadInitCallback*(client: JackClient; threadInitCallback: JackThreadInitCallback; arg: pointer): cint {.cdecl, importc: "jack_set_thread_init_callback", dynlib: JackLib.}

proc jackOnShutdown*(client: JackClient; shutdownCallback: JackShutdownCallback; arg: pointer) {.cdecl, importc: "jack_on_shutdown", dynlib: JackLib.}

proc jackOnInfoShutdown*(client: JackClient; shutdownCallback: JackInfoShutdownCallback; arg: pointer) {.cdecl, importc: "jack_on_info_shutdown", dynlib: JackLib.}

proc jackSetProcessCallback*(client: JackClient; processCallback: JackProcessCallback; arg: pointer): cint {.cdecl, importc: "jack_set_process_callback", dynlib: JackLib.}

proc jackSetFreewheelCallback*(client: JackClient; freewheelCallback: JackFreewheelCallback; arg: pointer): cint {.cdecl, importc: "jack_set_freewheel_callback", dynlib: JackLib.}

proc jackSetBufferSizeCallback*(client: JackClient; bufsizeCallback: JackBufferSizeCallback; arg: pointer): cint {.cdecl, importc: "jack_set_buffer_size_callback", dynlib: JackLib.}

proc jackSetSampleRateCallback*(client: JackClient; srateCallback: JackSampleRateCallback; arg: pointer): cint {.cdecl, importc: "jack_set_sample_rate_callback", dynlib: JackLib.}

proc jackSetClientRegistrationCallback*(client: JackClient; registrationCallback: JackClientRegistrationCallback; arg: pointer): cint {.cdecl, importc: "jack_set_client_registration_callback", dynlib: JackLib.}

proc jackSetPortRegistrationCallback*(client: JackClient; registrationCallback: JackPortRegistrationCallback; arg: pointer): cint {.cdecl, importc: "jack_set_port_registration_callback", dynlib: JackLib.}

proc jackSetPortConnectCallback*(client: JackClient; connectCallback: JackPortConnectCallback; arg: pointer): cint {.cdecl, importc: "jack_set_port_connect_callback", dynlib: JackLib.}

proc jackSetPortRenameCallback*(client: JackClient; renameCallback: JackPortRenameCallback; arg: pointer): cint {.cdecl, importc: "jack_set_port_rename_callback", dynlib: JackLib.}

proc jackSetGraphOrderCallback*(client: JackClient; graphCallback: JackGraphOrderCallback; a3: pointer): cint {.cdecl, importc: "jack_set_graph_order_callback", dynlib: JackLib.}

proc jackSetXrunCallback*(client: JackClient; xrunCallback: JackXRunCallback; arg: pointer): cint {.cdecl, importc: "jack_set_xrun_callback", dynlib: JackLib.}

proc jackSetLatencyCallback*(client: JackClient; latencyCallback: JackLatencyCallback; a3: pointer): cint {.cdecl, importc: "jack_set_latency_callback", dynlib: JackLib.}

proc jackSetFreewheel*(client: JackClient; onoff: cint): cint {.cdecl, importc: "jack_set_freewheel", dynlib: JackLib.}

proc jackSetBufferSize*(client: JackClient; nframes: JackNframes): cint {.cdecl, importc: "jack_set_buffer_size", dynlib: JackLib.}

proc jackGetSampleRate*(a1: JackClient): JackNframes {.cdecl, importc: "jack_get_sample_rate", dynlib: JackLib.}

proc jackGetBufferSize*(a1: JackClient): JackNframes {.cdecl, importc: "jack_get_buffer_size", dynlib: JackLib.}

proc jackEngineTakeoverTimebase*(a1: JackClient): cint {.cdecl, importc: "jack_engine_takeover_timebase", dynlib: JackLib.}

proc jackCpuLoad*(client: JackClient): cfloat {.cdecl, importc: "jack_cpu_load", dynlib: JackLib.}

proc jackPortRegister*(client: JackClient; portName: cstring; portType: cstring; flags: culong; bufferSize: culong): JackPort {.cdecl, importc: "jack_port_register", dynlib: JackLib.}

proc jackPortUnregister*(client: JackClient; port: JackPort): cint {.cdecl, importc: "jack_port_unregister", dynlib: JackLib.}

proc jackPortGetBuffer*(port: JackPort; a2: JackNframes): pointer {.cdecl, importc: "jack_port_get_buffer", dynlib: JackLib.}

proc jackPortUuid*(port: JackPort): JackUuid {.cdecl, importc: "jack_port_uuid", dynlib: JackLib.}

proc jackPortName*(port: JackPort): cstring {.cdecl, importc: "jack_port_name", dynlib: JackLib.}

proc jackPortShortName*(port: JackPort): cstring {.cdecl, importc: "jack_port_short_name", dynlib: JackLib.}

proc jackPortFlags*(port: JackPort): cint {.cdecl, importc: "jack_port_flags", dynlib: JackLib.}

proc jackPortType*(port: JackPort): cstring {.cdecl, importc: "jack_port_type", dynlib: JackLib.}

proc jackPortTypeId*(port: JackPort): JackPortTypeId {.cdecl, importc: "jack_port_type_id", dynlib: JackLib.}

proc jackPortIsMine*(client: JackClient; port: JackPort): cint {.cdecl, importc: "jack_port_is_mine", dynlib: JackLib.}

proc jackPortConnected*(port: JackPort): cint {.cdecl, importc: "jack_port_connected", dynlib: JackLib.}

proc jackPortConnectedTo*(port: JackPort; portName: cstring): cint {.cdecl, importc: "jack_port_connected_to", dynlib: JackLib.}

proc jackPortGetConnections*(port: JackPort): cstringArray {.cdecl, importc: "jack_port_get_connections", dynlib: JackLib.}

proc jackPortGetAllConnections*(client: JackClient; port: JackPort): cstringArray {.cdecl, importc: "jack_port_get_all_connections", dynlib: JackLib.}

proc jackPortTie*(src: JackPort; dst: JackPort): cint {.cdecl, importc: "jack_port_tie", dynlib: JackLib.}

proc jackPortUntie*(port: JackPort): cint {.cdecl, importc: "jack_port_untie", dynlib: JackLib.}

proc jackPortSetName*(port: JackPort; portName: cstring): cint {.cdecl, importc: "jack_port_set_name", dynlib: JackLib.}

proc jackPortRename*(client: JackClient; port: JackPort; portName: cstring): cint {.cdecl, importc: "jack_port_rename", dynlib: JackLib.}

proc jackPortSetAlias*(port: JackPort; alias: cstring): cint {.cdecl, importc: "jack_port_set_alias", dynlib: JackLib.}

proc jackPortUnsetAlias*(port: JackPort; alias: cstring): cint {.cdecl, importc: "jack_port_unset_alias", dynlib: JackLib.}

proc jackPortGetAliases*(port: JackPort; aliases: array[2, cstring]): cint {.cdecl, importc: "jack_port_get_aliases", dynlib: JackLib.}

proc jackPortRequestMonitor*(port: JackPort; onoff: cint): cint {.cdecl, importc: "jack_port_request_monitor", dynlib: JackLib.}

proc jackPortRequestMonitorByName*(client: JackClient; portName: cstring; onoff: cint): cint {.cdecl, importc: "jack_port_request_monitor_by_name", dynlib: JackLib.}

proc jackPortEnsureMonitor*(port: JackPort; onoff: cint): cint {.cdecl, importc: "jack_port_ensure_monitor", dynlib: JackLib.}

proc jackPortMonitoringInput*(port: JackPort): cint {.cdecl, importc: "jack_port_monitoring_input", dynlib: JackLib.}

proc jackConnect*(client: JackClient; sourcePort: cstring; destinationPort: cstring): cint {.cdecl, importc: "jack_connect", dynlib: JackLib.}

proc jackDisconnect*(client: JackClient; sourcePort: cstring; destinationPort: cstring): cint {.cdecl, importc: "jack_disconnect", dynlib: JackLib.}

proc jackPortDisconnect*(client: JackClient; port: JackPort): cint {.cdecl, importc: "jack_port_disconnect", dynlib: JackLib.}

proc jackPortNameSize*(): cint {.cdecl, importc: "jack_port_name_size", dynlib: JackLib.}

proc jackPortTypeSize*(): cint {.cdecl, importc: "jack_port_type_size", dynlib: JackLib.}

proc jackPortTypeGetBufferSize*(client: JackClient; portType: cstring): csize_t {.cdecl, importc: "jack_port_type_get_buffer_size", dynlib: JackLib.}

proc jackPortSetLatency*(port: JackPort; a2: JackNframes) {.cdecl, importc: "jack_port_set_latency", dynlib: JackLib.}

proc jackPortGetLatencyRange*(port: JackPort; mode: JackLatencyCallbackMode; range: var JackLatencyRange) {.cdecl, importc: "jack_port_get_latency_range", dynlib: JackLib.}

proc jackPortSetLatencyRange*(port: JackPort; mode: JackLatencyCallbackMode; range: var JackLatencyRange) {.cdecl, importc: "jack_port_set_latency_range", dynlib: JackLib.}

proc jackRecomputeTotalLatencies*(client: JackClient): cint {.cdecl, importc: "jack_recompute_total_latencies", dynlib: JackLib.}

proc jackPortGetLatency*(port: JackPort): JackNframes {.cdecl, importc: "jack_port_get_latency", dynlib: JackLib.}

proc jackPortGetTotalLatency*(client: JackClient; port: JackPort): JackNframes {.cdecl, importc: "jack_port_get_total_latency", dynlib: JackLib.}

proc jackRecomputeTotalLatency*(a1: JackClient; port: JackPort): cint {.cdecl, importc: "jack_recompute_total_latency", dynlib: JackLib.}

proc jackGetPorts*(client: JackClient; portNamePattern: cstring; typeNamePattern: cstring; flags: culong): cstringArray {.cdecl, importc: "jack_get_ports", dynlib: JackLib.}

proc jackPortByName*(client: JackClient; portName: cstring): JackPort {.cdecl, importc: "jack_port_by_name", dynlib: JackLib.}

proc jackPortById*(client: JackClient; portId: JackPortId): JackPort {.cdecl, importc: "jack_port_by_id", dynlib: JackLib.}

proc jackFramesSinceCycleStart*(a1: JackClient): JackNframes {.cdecl, importc: "jack_frames_since_cycle_start", dynlib: JackLib.}

proc jackFrameTime*(a1: JackClient): JackNframes {.cdecl, importc: "jack_frame_time", dynlib: JackLib.}

proc jackLastFrameTime*(client: JackClient): JackNframes {.cdecl, importc: "jack_last_frame_time", dynlib: JackLib.}

proc jackGetCycleTimes*(client: JackClient; currentFrames: var JackNframes; currentUsecs: var JackTime; nextUsecs: var JackTime; periodUsecs: var cfloat): cint {.cdecl, importc: "jack_get_cycle_times", dynlib: JackLib.}

proc jackFramesToTime*(client: JackClient; a2: JackNframes): JackTime {.cdecl, importc: "jack_frames_to_time", dynlib: JackLib.}

proc jackTimeToFrames*(client: JackClient; a2: JackTime): JackNframes {.cdecl, importc: "jack_time_to_frames", dynlib: JackLib.}

proc jackGetTime*(): JackTime {.cdecl, importc: "jack_get_time", dynlib: JackLib.}

var jackErrorCallback*: proc (msg: cstring) {.cdecl.}


proc jackSetErrorFunction*(`func`: proc (a1: cstring) {.cdecl.}) {.cdecl, importc: "jack_set_error_function", dynlib: JackLib.}

var jackInfoCallback*: proc (msg: cstring) {.cdecl.}


proc jackSetInfoFunction*(`func`: proc (a1: cstring) {.cdecl.}) {.cdecl, importc: "jack_set_info_function", dynlib: JackLib.}

proc jackFree*(`ptr`: pointer) {.cdecl, importc: "jack_free", dynlib: JackLib.}
