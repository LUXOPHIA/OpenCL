unit cl_functions;

interface //#################################################################### ■

uses cl_version, cl_platform, cl;

const
     {$IF Defined(MSWINDOWS)} DLLNAME = 'OpenCL.dll';
     {$ELSEIF Defined(MACOS)} DLLNAME = '/System/Library/Frameworks/OpenCL.framework/OpenCL';
     {$ELSEIF Defined(ANDROID)} DLLNAME = 'libOpenCL.so';
     {$ELSE} DLLNAME = 'libOpenCL.so.1';
     {$ENDIF}

(* CL_NO_PROTOTYPES implies CL_NO_CORE_PROTOTYPES: *)
{$IF Defined( CL_NO_PROTOTYPES ) and not Defined( CL_NO_CORE_PROTOTYPES ) }
{$DEFINE CL_NO_CORE_PROTOTYPES }
{$ENDIF}

{$IF not Defined( CL_NO_CORE_PROTOTYPES ) }

(* Platform API *)
var clGetPlatformIDs                         :T_clGetPlatformIDs                        ; {CL_API_SUFFIX__VERSION_1_0}

var clGetPlatformInfo                        :T_clGetPlatformInfo                       ; {CL_API_SUFFIX__VERSION_1_0}

(* Device APIs *)
var clGetDeviceIDs                           :T_clGetDeviceIDs                          ; {CL_API_SUFFIX__VERSION_1_0}

var clGetDeviceInfo                          :T_clGetDeviceInfo                         ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

var clCreateSubDevices                       :T_clCreateSubDevices                      ; {CL_API_SUFFIX__VERSION_1_2}

var clRetainDevice                           :T_clRetainDevice                          ; {CL_API_SUFFIX__VERSION_1_2}

var clReleaseDevice                          :T_clReleaseDevice                         ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_1 <> 0 }

var clSetDefaultDeviceCommandQueue           :T_clSetDefaultDeviceCommandQueue          ; {CL_API_SUFFIX__VERSION_2_1}

var clGetDeviceAndHostTimer                  :T_clGetDeviceAndHostTimer                 ; {CL_API_SUFFIX__VERSION_2_1}

var clGetHostTimer                           :T_clGetHostTimer                          ; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

(* Context APIs *)

var clCreateContext                          :T_clCreateContext                         ; {CL_API_SUFFIX__VERSION_1_0}

var clCreateContextFromType                  :T_clCreateContextFromType                 ; {CL_API_SUFFIX__VERSION_1_0}

var clRetainContext                          :T_clRetainContext                         ; {CL_API_SUFFIX__VERSION_1_0}

var clReleaseContext                         :T_clReleaseContext                        ; {CL_API_SUFFIX__VERSION_1_0}

var clGetContextInfo                         :T_clGetContextInfo                        ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_3_0 <> 0 }

var clSetContextDestructorCallback           :T_clSetContextDestructorCallback          ; {CL_API_SUFFIX__VERSION_3_0}

{$ENDIF}

(* Command Queue APIs *)

{$IF CL_VERSION_2_0 <> 0 }

var clCreateCommandQueueWithProperties       :T_clCreateCommandQueueWithProperties      ; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

var clRetainCommandQueue                     :T_clRetainCommandQueue                    ; {CL_API_SUFFIX__VERSION_1_0}

var clReleaseCommandQueue                    :T_clReleaseCommandQueue                   ; {CL_API_SUFFIX__VERSION_1_0}

var clGetCommandQueueInfo                    :T_clGetCommandQueueInfo                   ; {CL_API_SUFFIX__VERSION_1_0}

(* Memory Object APIs *)
var clCreateBuffer                           :T_clCreateBuffer                          ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

var clCreateSubBuffer                        :T_clCreateSubBuffer                       ; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

var clCreateImage                            :T_clCreateImage                           ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_0 <> 0 }

var clCreatePipe                             :T_clCreatePipe                            ; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

{$IF CL_VERSION_3_0 <> 0 }

var clCreateBufferWithProperties             :T_clCreateBufferWithProperties            ; {CL_API_SUFFIX__VERSION_3_0}

var clCreateImageWithProperties              :T_clCreateImageWithProperties             ; {CL_API_SUFFIX__VERSION_3_0}

{$ENDIF}

var clRetainMemObject                        :T_clRetainMemObject                       ; {CL_API_SUFFIX__VERSION_1_0}

var clReleaseMemObject                       :T_clReleaseMemObject                      ; {CL_API_SUFFIX__VERSION_1_0}

var clGetSupportedImageFormats               :T_clGetSupportedImageFormats              ; {CL_API_SUFFIX__VERSION_1_0}

var clGetMemObjectInfo                       :T_clGetMemObjectInfo                      ; {CL_API_SUFFIX__VERSION_1_0}

var clGetImageInfo                           :T_clGetImageInfo                          ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_0 <> 0 }

var clGetPipeInfo                            :T_clGetPipeInfo                           ; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

{$IF CL_VERSION_1_1 <> 0 }

var clSetMemObjectDestructorCallback         :T_clSetMemObjectDestructorCallback        ; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

(* SVM Allocation APIs *)

{$IF CL_VERSION_2_0 <> 0 }

var clSVMAlloc                               :T_clSVMAlloc                              ; {CL_API_SUFFIX__VERSION_2_0}

var clSVMFree                                :T_clSVMFree                               ; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

(* Sampler APIs *)

{$IF CL_VERSION_2_0 <> 0 }

var clCreateSamplerWithProperties            :T_clCreateSamplerWithProperties           ; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

var clRetainSampler                          :T_clRetainSampler                         ; {CL_API_SUFFIX__VERSION_1_0}

var clReleaseSampler                         :T_clReleaseSampler                        ; {CL_API_SUFFIX__VERSION_1_0}

var clGetSamplerInfo                         :T_clGetSamplerInfo                        ; {CL_API_SUFFIX__VERSION_1_0}

(* Program Object APIs *)
var clCreateProgramWithSource                :T_clCreateProgramWithSource               ; {CL_API_SUFFIX__VERSION_1_0}

var clCreateProgramWithBinary                :T_clCreateProgramWithBinary               ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

var clCreateProgramWithBuiltInKernels        :T_clCreateProgramWithBuiltInKernels       ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_1 <> 0 }

var clCreateProgramWithIL                    :T_clCreateProgramWithIL                   ; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

var clRetainProgram                          :T_clRetainProgram                         ; {CL_API_SUFFIX__VERSION_1_0}

var clReleaseProgram                         :T_clReleaseProgram                        ; {CL_API_SUFFIX__VERSION_1_0}

var clBuildProgram                           :T_clBuildProgram                          ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

var clCompileProgram                         :T_clCompileProgram                        ; {CL_API_SUFFIX__VERSION_1_2}

var clLinkProgram                            :T_clLinkProgram                           ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_2 <> 0 }

var clSetProgramReleaseCallback              :T_clSetProgramReleaseCallback             ; {CL_API_SUFFIX__VERSION_2_2_DEPRECATED}

var clSetProgramSpecializationConstant       :T_clSetProgramSpecializationConstant      ; {CL_API_SUFFIX__VERSION_2_2}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

var clUnloadPlatformCompiler                 :T_clUnloadPlatformCompiler                ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

var clGetProgramInfo                         :T_clGetProgramInfo                        ; {CL_API_SUFFIX__VERSION_1_0}

var clGetProgramBuildInfo                    :T_clGetProgramBuildInfo                   ; {CL_API_SUFFIX__VERSION_1_0}

(* Kernel Object APIs *)
var clCreateKernel                           :T_clCreateKernel                          ; {CL_API_SUFFIX__VERSION_1_0}

var clCreateKernelsInProgram                 :T_clCreateKernelsInProgram                ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_1 <> 0 }

var clCloneKernel                            :T_clCloneKernel                           ; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

var clRetainKernel                           :T_clRetainKernel                          ; {CL_API_SUFFIX__VERSION_1_0}

var clReleaseKernel                          :T_clReleaseKernel                         ; {CL_API_SUFFIX__VERSION_1_0}

var clSetKernelArg                           :T_clSetKernelArg                          ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_0 <> 0 }

var clSetKernelArgSVMPointer                 :T_clSetKernelArgSVMPointer                ; {CL_API_SUFFIX__VERSION_2_0}

var clSetKernelExecInfo                      :T_clSetKernelExecInfo                     ; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

var clGetKernelInfo                          :T_clGetKernelInfo                         ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

var clGetKernelArgInfo                       :T_clGetKernelArgInfo                      ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

var clGetKernelWorkGroupInfo                 :T_clGetKernelWorkGroupInfo                ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_1 <> 0 }

var clGetKernelSubGroupInfo                  :T_clGetKernelSubGroupInfo                 ; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

(* Event Object APIs *)
var clWaitForEvents                          :T_clWaitForEvents                         ; {CL_API_SUFFIX__VERSION_1_0}

var clGetEventInfo                           :T_clGetEventInfo                          ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

var clCreateUserEvent                        :T_clCreateUserEvent                       ; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

var clRetainEvent                            :T_clRetainEvent                           ; {CL_API_SUFFIX__VERSION_1_0}

var clReleaseEvent                           :T_clReleaseEvent                          ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

var clSetUserEventStatus                     :T_clSetUserEventStatus                    ; {CL_API_SUFFIX__VERSION_1_1}

var clSetEventCallback                       :T_clSetEventCallback                      ; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

(* Profiling APIs *)
var clGetEventProfilingInfo                  :T_clGetEventProfilingInfo                 ; {CL_API_SUFFIX__VERSION_1_0}

(* Flush and Finish APIs *)
var clFlush                                  :T_clFlush                                 ; {CL_API_SUFFIX__VERSION_1_0}

var clFinish                                 :T_clFinish                                ; {CL_API_SUFFIX__VERSION_1_0}

(* Enqueued Commands APIs *)
var clEnqueueReadBuffer                      :T_clEnqueueReadBuffer                     ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

var clEnqueueReadBufferRect                  :T_clEnqueueReadBufferRect                 ; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

var clEnqueueWriteBuffer                     :T_clEnqueueWriteBuffer                    ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

var clEnqueueWriteBufferRect                 :T_clEnqueueWriteBufferRect                ; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

var clEnqueueFillBuffer                      :T_clEnqueueFillBuffer                     ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

var clEnqueueCopyBuffer                      :T_clEnqueueCopyBuffer                     ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

var clEnqueueCopyBufferRect                  :T_clEnqueueCopyBufferRect                 ; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

var clEnqueueReadImage                       :T_clEnqueueReadImage                      ; {CL_API_SUFFIX__VERSION_1_0}

var clEnqueueWriteImage                      :T_clEnqueueWriteImage                     ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

var clEnqueueFillImage                       :T_clEnqueueFillImage                      ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

var clEnqueueCopyImage                       :T_clEnqueueCopyImage                      ; {CL_API_SUFFIX__VERSION_1_0}

var clEnqueueCopyImageToBuffer               :T_clEnqueueCopyImageToBuffer              ; {CL_API_SUFFIX__VERSION_1_0}

var clEnqueueCopyBufferToImage               :T_clEnqueueCopyBufferToImage              ; {CL_API_SUFFIX__VERSION_1_0}

var clEnqueueMapBuffer                       :T_clEnqueueMapBuffer                      ; {CL_API_SUFFIX__VERSION_1_0}

var clEnqueueMapImage                        :T_clEnqueueMapImage                       ; {CL_API_SUFFIX__VERSION_1_0}

var clEnqueueUnmapMemObject                  :T_clEnqueueUnmapMemObject                 ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

var clEnqueueMigrateMemObjects               :T_clEnqueueMigrateMemObjects              ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

var clEnqueueNDRangeKernel                   :T_clEnqueueNDRangeKernel                  ; {CL_API_SUFFIX__VERSION_1_0}

var clEnqueueNativeKernel                    :T_clEnqueueNativeKernel                   ; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

var clEnqueueMarkerWithWaitList              :T_clEnqueueMarkerWithWaitList             ; {CL_API_SUFFIX__VERSION_1_2}

var clEnqueueBarrierWithWaitList             :T_clEnqueueBarrierWithWaitList            ; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_0 <> 0 }

var clEnqueueSVMFree                         :T_clEnqueueSVMFree                        ; {CL_API_SUFFIX__VERSION_2_0}

var clEnqueueSVMMemcpy                       :T_clEnqueueSVMMemcpy                      ; {CL_API_SUFFIX__VERSION_2_0}

var clEnqueueSVMMemFill                      :T_clEnqueueSVMMemFill                     ; {CL_API_SUFFIX__VERSION_2_0}

var clEnqueueSVMMap                          :T_clEnqueueSVMMap                         ; {CL_API_SUFFIX__VERSION_2_0}

var clEnqueueSVMUnmap                        :T_clEnqueueSVMUnmap                       ; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

{$IF CL_VERSION_2_1 <> 0 }

var clEnqueueSVMMigrateMem                   :T_clEnqueueSVMMigrateMem                  ; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

{$IF CL_VERSION_3_1 <> 0 }

var clGetKernelSuggestedLocalWorkSize        :T_clGetKernelSuggestedLocalWorkSize       ; {CL_API_SUFFIX__VERSION_3_1}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* Extension function access
 *
 * Returns the extension function address for the given function name,
 * or NULL if a valid function can not be found.  The client must
 * check to make sure the address is not NULL, before using or
 * calling the returned function address.
 *)
var clGetExtensionFunctionAddressForPlatform :T_clGetExtensionFunctionAddressForPlatform; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IFDEF CL_USE_DEPRECATED_OPENCL_1_0_APIS }
    (*
     *  WARNING:
     *     This API introduces mutable state into the OpenCL implementation. It has been REMOVED
     *  to better facilitate thread safety.  The 1.0 API is not thread safe. It is not tested by the
     *  OpenCL 1.1 conformance test, and consequently may not work or may not work dependably.
     *  It is likely to be non-performant. Use of this API is not advised. Use at your own risk.
     *
     *  Software developers previously relying on this API are instructed to set the command queue
     *  properties when creating the queue, instead.
     *)
var clSetCommandQueueProperty                :T_clSetCommandQueueProperty               ; {CL_API_SUFFIX__VERSION_1_0_DEPRECATED}
{$ENDIF} (* CL_USE_DEPRECATED_OPENCL_1_0_APIS *)

(* Deprecated OpenCL 1.1 APIs *)
var clCreateImage2D                          :T_clCreateImage2D                         ; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

var clCreateImage3D                          :T_clCreateImage3D                         ; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

var clEnqueueMarker                          :T_clEnqueueMarker                         ; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

var clEnqueueWaitForEvents                   :T_clEnqueueWaitForEvents                  ; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

var clEnqueueBarrier                         :T_clEnqueueBarrier                        ; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

var clUnloadCompiler                         :T_clUnloadCompiler                        ; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

var clGetExtensionFunctionAddress            :T_clGetExtensionFunctionAddress           ; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

(* Deprecated OpenCL 2.0 APIs *)
var clCreateCommandQueue                     :T_clCreateCommandQueue                    ; {CL_API_SUFFIX__VERSION_1_2_DEPRECATED}

var clCreateSampler                          :T_clCreateSampler                         ; {CL_API_SUFFIX__VERSION_1_2_DEPRECATED}

var clEnqueueTask                            :T_clEnqueueTask                           ; {CL_API_SUFFIX__VERSION_1_2_DEPRECATED}

{$ENDIF} (* !defined(CL_NO_CORE_PROTOTYPES) *)

function LoadFunctions( const LibName_:String = DLLNAME ) :Boolean;

implementation //############################################################### ■

uses {$IFDEF MSWINDOWS} Winapi.Windows, {$ENDIF} System.SysUtils;

var
   _OpenCLLib :HMODULE = 0;

function LoadFunctions( const LibName_:String ) :Boolean;
begin
     if _OpenCLLib <> 0 then Exit( True );

     _OpenCLLib := SafeLoadLibrary( LibName_ );

     Result := _OpenCLLib <> 0;

     if not Result then Exit;

     {$IF not Defined( CL_NO_CORE_PROTOTYPES ) }

     clGetPlatformIDs                         := GetProcAddress( _OpenCLLib, 'clGetPlatformIDs' );
     clGetPlatformInfo                        := GetProcAddress( _OpenCLLib, 'clGetPlatformInfo' );
     clGetDeviceIDs                           := GetProcAddress( _OpenCLLib, 'clGetDeviceIDs' );
     clGetDeviceInfo                          := GetProcAddress( _OpenCLLib, 'clGetDeviceInfo' );
     {$IF CL_VERSION_1_2 <> 0 }

     clCreateSubDevices                       := GetProcAddress( _OpenCLLib, 'clCreateSubDevices' );
     clRetainDevice                           := GetProcAddress( _OpenCLLib, 'clRetainDevice' );
     clReleaseDevice                          := GetProcAddress( _OpenCLLib, 'clReleaseDevice' );
     {$ENDIF}

     {$IF CL_VERSION_2_1 <> 0 }

     clSetDefaultDeviceCommandQueue           := GetProcAddress( _OpenCLLib, 'clSetDefaultDeviceCommandQueue' );
     clGetDeviceAndHostTimer                  := GetProcAddress( _OpenCLLib, 'clGetDeviceAndHostTimer' );
     clGetHostTimer                           := GetProcAddress( _OpenCLLib, 'clGetHostTimer' );
     {$ENDIF}

     clCreateContext                          := GetProcAddress( _OpenCLLib, 'clCreateContext' );
     clCreateContextFromType                  := GetProcAddress( _OpenCLLib, 'clCreateContextFromType' );
     clRetainContext                          := GetProcAddress( _OpenCLLib, 'clRetainContext' );
     clReleaseContext                         := GetProcAddress( _OpenCLLib, 'clReleaseContext' );
     clGetContextInfo                         := GetProcAddress( _OpenCLLib, 'clGetContextInfo' );
     {$IF CL_VERSION_3_0 <> 0 }

     clSetContextDestructorCallback           := GetProcAddress( _OpenCLLib, 'clSetContextDestructorCallback' );
     {$ENDIF}

     {$IF CL_VERSION_2_0 <> 0 }

     clCreateCommandQueueWithProperties       := GetProcAddress( _OpenCLLib, 'clCreateCommandQueueWithProperties' );
     {$ENDIF}

     clRetainCommandQueue                     := GetProcAddress( _OpenCLLib, 'clRetainCommandQueue' );
     clReleaseCommandQueue                    := GetProcAddress( _OpenCLLib, 'clReleaseCommandQueue' );
     clGetCommandQueueInfo                    := GetProcAddress( _OpenCLLib, 'clGetCommandQueueInfo' );
     clCreateBuffer                           := GetProcAddress( _OpenCLLib, 'clCreateBuffer' );
     {$IF CL_VERSION_1_1 <> 0 }

     clCreateSubBuffer                        := GetProcAddress( _OpenCLLib, 'clCreateSubBuffer' );
     {$ENDIF}

     {$IF CL_VERSION_1_2 <> 0 }

     clCreateImage                            := GetProcAddress( _OpenCLLib, 'clCreateImage' );
     {$ENDIF}

     {$IF CL_VERSION_2_0 <> 0 }

     clCreatePipe                             := GetProcAddress( _OpenCLLib, 'clCreatePipe' );
     {$ENDIF}

     {$IF CL_VERSION_3_0 <> 0 }

     clCreateBufferWithProperties             := GetProcAddress( _OpenCLLib, 'clCreateBufferWithProperties' );
     clCreateImageWithProperties              := GetProcAddress( _OpenCLLib, 'clCreateImageWithProperties' );
     {$ENDIF}

     clRetainMemObject                        := GetProcAddress( _OpenCLLib, 'clRetainMemObject' );
     clReleaseMemObject                       := GetProcAddress( _OpenCLLib, 'clReleaseMemObject' );
     clGetSupportedImageFormats               := GetProcAddress( _OpenCLLib, 'clGetSupportedImageFormats' );
     clGetMemObjectInfo                       := GetProcAddress( _OpenCLLib, 'clGetMemObjectInfo' );
     clGetImageInfo                           := GetProcAddress( _OpenCLLib, 'clGetImageInfo' );
     {$IF CL_VERSION_2_0 <> 0 }

     clGetPipeInfo                            := GetProcAddress( _OpenCLLib, 'clGetPipeInfo' );
     {$ENDIF}

     {$IF CL_VERSION_1_1 <> 0 }

     clSetMemObjectDestructorCallback         := GetProcAddress( _OpenCLLib, 'clSetMemObjectDestructorCallback' );
     {$ENDIF}

     {$IF CL_VERSION_2_0 <> 0 }

     clSVMAlloc                               := GetProcAddress( _OpenCLLib, 'clSVMAlloc' );
     clSVMFree                                := GetProcAddress( _OpenCLLib, 'clSVMFree' );
     {$ENDIF}

     {$IF CL_VERSION_2_0 <> 0 }

     clCreateSamplerWithProperties            := GetProcAddress( _OpenCLLib, 'clCreateSamplerWithProperties' );
     {$ENDIF}

     clRetainSampler                          := GetProcAddress( _OpenCLLib, 'clRetainSampler' );
     clReleaseSampler                         := GetProcAddress( _OpenCLLib, 'clReleaseSampler' );
     clGetSamplerInfo                         := GetProcAddress( _OpenCLLib, 'clGetSamplerInfo' );
     clCreateProgramWithSource                := GetProcAddress( _OpenCLLib, 'clCreateProgramWithSource' );
     clCreateProgramWithBinary                := GetProcAddress( _OpenCLLib, 'clCreateProgramWithBinary' );
     {$IF CL_VERSION_1_2 <> 0 }

     clCreateProgramWithBuiltInKernels        := GetProcAddress( _OpenCLLib, 'clCreateProgramWithBuiltInKernels' );
     {$ENDIF}

     {$IF CL_VERSION_2_1 <> 0 }

     clCreateProgramWithIL                    := GetProcAddress( _OpenCLLib, 'clCreateProgramWithIL' );
     {$ENDIF}

     clRetainProgram                          := GetProcAddress( _OpenCLLib, 'clRetainProgram' );
     clReleaseProgram                         := GetProcAddress( _OpenCLLib, 'clReleaseProgram' );
     clBuildProgram                           := GetProcAddress( _OpenCLLib, 'clBuildProgram' );
     {$IF CL_VERSION_1_2 <> 0 }

     clCompileProgram                         := GetProcAddress( _OpenCLLib, 'clCompileProgram' );
     clLinkProgram                            := GetProcAddress( _OpenCLLib, 'clLinkProgram' );
     {$ENDIF}

     {$IF CL_VERSION_2_2 <> 0 }

     clSetProgramReleaseCallback              := GetProcAddress( _OpenCLLib, 'clSetProgramReleaseCallback' );
     clSetProgramSpecializationConstant       := GetProcAddress( _OpenCLLib, 'clSetProgramSpecializationConstant' );
     {$ENDIF}

     {$IF CL_VERSION_1_2 <> 0 }

     clUnloadPlatformCompiler                 := GetProcAddress( _OpenCLLib, 'clUnloadPlatformCompiler' );
     {$ENDIF}

     clGetProgramInfo                         := GetProcAddress( _OpenCLLib, 'clGetProgramInfo' );
     clGetProgramBuildInfo                    := GetProcAddress( _OpenCLLib, 'clGetProgramBuildInfo' );
     clCreateKernel                           := GetProcAddress( _OpenCLLib, 'clCreateKernel' );
     clCreateKernelsInProgram                 := GetProcAddress( _OpenCLLib, 'clCreateKernelsInProgram' );
     {$IF CL_VERSION_2_1 <> 0 }

     clCloneKernel                            := GetProcAddress( _OpenCLLib, 'clCloneKernel' );
     {$ENDIF}

     clRetainKernel                           := GetProcAddress( _OpenCLLib, 'clRetainKernel' );
     clReleaseKernel                          := GetProcAddress( _OpenCLLib, 'clReleaseKernel' );
     clSetKernelArg                           := GetProcAddress( _OpenCLLib, 'clSetKernelArg' );
     {$IF CL_VERSION_2_0 <> 0 }

     clSetKernelArgSVMPointer                 := GetProcAddress( _OpenCLLib, 'clSetKernelArgSVMPointer' );
     clSetKernelExecInfo                      := GetProcAddress( _OpenCLLib, 'clSetKernelExecInfo' );
     {$ENDIF}

     clGetKernelInfo                          := GetProcAddress( _OpenCLLib, 'clGetKernelInfo' );
     {$IF CL_VERSION_1_2 <> 0 }

     clGetKernelArgInfo                       := GetProcAddress( _OpenCLLib, 'clGetKernelArgInfo' );
     {$ENDIF}

     clGetKernelWorkGroupInfo                 := GetProcAddress( _OpenCLLib, 'clGetKernelWorkGroupInfo' );
     {$IF CL_VERSION_2_1 <> 0 }

     clGetKernelSubGroupInfo                  := GetProcAddress( _OpenCLLib, 'clGetKernelSubGroupInfo' );
     {$ENDIF}

     clWaitForEvents                          := GetProcAddress( _OpenCLLib, 'clWaitForEvents' );
     clGetEventInfo                           := GetProcAddress( _OpenCLLib, 'clGetEventInfo' );
     {$IF CL_VERSION_1_1 <> 0 }

     clCreateUserEvent                        := GetProcAddress( _OpenCLLib, 'clCreateUserEvent' );
     {$ENDIF}

     clRetainEvent                            := GetProcAddress( _OpenCLLib, 'clRetainEvent' );
     clReleaseEvent                           := GetProcAddress( _OpenCLLib, 'clReleaseEvent' );
     {$IF CL_VERSION_1_1 <> 0 }

     clSetUserEventStatus                     := GetProcAddress( _OpenCLLib, 'clSetUserEventStatus' );
     clSetEventCallback                       := GetProcAddress( _OpenCLLib, 'clSetEventCallback' );
     {$ENDIF}

     clGetEventProfilingInfo                  := GetProcAddress( _OpenCLLib, 'clGetEventProfilingInfo' );
     clFlush                                  := GetProcAddress( _OpenCLLib, 'clFlush' );
     clFinish                                 := GetProcAddress( _OpenCLLib, 'clFinish' );
     clEnqueueReadBuffer                      := GetProcAddress( _OpenCLLib, 'clEnqueueReadBuffer' );
     {$IF CL_VERSION_1_1 <> 0 }

     clEnqueueReadBufferRect                  := GetProcAddress( _OpenCLLib, 'clEnqueueReadBufferRect' );
     {$ENDIF}

     clEnqueueWriteBuffer                     := GetProcAddress( _OpenCLLib, 'clEnqueueWriteBuffer' );
     {$IF CL_VERSION_1_1 <> 0 }

     clEnqueueWriteBufferRect                 := GetProcAddress( _OpenCLLib, 'clEnqueueWriteBufferRect' );
     {$ENDIF}

     {$IF CL_VERSION_1_2 <> 0 }

     clEnqueueFillBuffer                      := GetProcAddress( _OpenCLLib, 'clEnqueueFillBuffer' );
     {$ENDIF}

     clEnqueueCopyBuffer                      := GetProcAddress( _OpenCLLib, 'clEnqueueCopyBuffer' );
     {$IF CL_VERSION_1_1 <> 0 }

     clEnqueueCopyBufferRect                  := GetProcAddress( _OpenCLLib, 'clEnqueueCopyBufferRect' );
     {$ENDIF}

     clEnqueueReadImage                       := GetProcAddress( _OpenCLLib, 'clEnqueueReadImage' );
     clEnqueueWriteImage                      := GetProcAddress( _OpenCLLib, 'clEnqueueWriteImage' );
     {$IF CL_VERSION_1_2 <> 0 }

     clEnqueueFillImage                       := GetProcAddress( _OpenCLLib, 'clEnqueueFillImage' );
     {$ENDIF}

     clEnqueueCopyImage                       := GetProcAddress( _OpenCLLib, 'clEnqueueCopyImage' );
     clEnqueueCopyImageToBuffer               := GetProcAddress( _OpenCLLib, 'clEnqueueCopyImageToBuffer' );
     clEnqueueCopyBufferToImage               := GetProcAddress( _OpenCLLib, 'clEnqueueCopyBufferToImage' );
     clEnqueueMapBuffer                       := GetProcAddress( _OpenCLLib, 'clEnqueueMapBuffer' );
     clEnqueueMapImage                        := GetProcAddress( _OpenCLLib, 'clEnqueueMapImage' );
     clEnqueueUnmapMemObject                  := GetProcAddress( _OpenCLLib, 'clEnqueueUnmapMemObject' );
     {$IF CL_VERSION_1_2 <> 0 }

     clEnqueueMigrateMemObjects               := GetProcAddress( _OpenCLLib, 'clEnqueueMigrateMemObjects' );
     {$ENDIF}

     clEnqueueNDRangeKernel                   := GetProcAddress( _OpenCLLib, 'clEnqueueNDRangeKernel' );
     clEnqueueNativeKernel                    := GetProcAddress( _OpenCLLib, 'clEnqueueNativeKernel' );
     {$IF CL_VERSION_1_2 <> 0 }

     clEnqueueMarkerWithWaitList              := GetProcAddress( _OpenCLLib, 'clEnqueueMarkerWithWaitList' );
     clEnqueueBarrierWithWaitList             := GetProcAddress( _OpenCLLib, 'clEnqueueBarrierWithWaitList' );
     {$ENDIF}

     {$IF CL_VERSION_2_0 <> 0 }

     clEnqueueSVMFree                         := GetProcAddress( _OpenCLLib, 'clEnqueueSVMFree' );
     clEnqueueSVMMemcpy                       := GetProcAddress( _OpenCLLib, 'clEnqueueSVMMemcpy' );
     clEnqueueSVMMemFill                      := GetProcAddress( _OpenCLLib, 'clEnqueueSVMMemFill' );
     clEnqueueSVMMap                          := GetProcAddress( _OpenCLLib, 'clEnqueueSVMMap' );
     clEnqueueSVMUnmap                        := GetProcAddress( _OpenCLLib, 'clEnqueueSVMUnmap' );
     {$ENDIF}

     {$IF CL_VERSION_2_1 <> 0 }

     clEnqueueSVMMigrateMem                   := GetProcAddress( _OpenCLLib, 'clEnqueueSVMMigrateMem' );
     {$ENDIF}

     {$IF CL_VERSION_3_1 <> 0 }

     clGetKernelSuggestedLocalWorkSize        := GetProcAddress( _OpenCLLib, 'clGetKernelSuggestedLocalWorkSize' );
     {$ENDIF}

     {$IF CL_VERSION_1_2 <> 0 }

     clGetExtensionFunctionAddressForPlatform := GetProcAddress( _OpenCLLib, 'clGetExtensionFunctionAddressForPlatform' );
     {$ENDIF}

     {$IFDEF CL_USE_DEPRECATED_OPENCL_1_0_APIS }

     clSetCommandQueueProperty                := GetProcAddress( _OpenCLLib, 'clSetCommandQueueProperty' );

     {$ENDIF} (* CL_USE_DEPRECATED_OPENCL_1_0_APIS *)

     clCreateImage2D                          := GetProcAddress( _OpenCLLib, 'clCreateImage2D' );
     clCreateImage3D                          := GetProcAddress( _OpenCLLib, 'clCreateImage3D' );
     clEnqueueMarker                          := GetProcAddress( _OpenCLLib, 'clEnqueueMarker' );
     clEnqueueWaitForEvents                   := GetProcAddress( _OpenCLLib, 'clEnqueueWaitForEvents' );
     clEnqueueBarrier                         := GetProcAddress( _OpenCLLib, 'clEnqueueBarrier' );
     clUnloadCompiler                         := GetProcAddress( _OpenCLLib, 'clUnloadCompiler' );
     clGetExtensionFunctionAddress            := GetProcAddress( _OpenCLLib, 'clGetExtensionFunctionAddress' );
     clCreateCommandQueue                     := GetProcAddress( _OpenCLLib, 'clCreateCommandQueue' );
     clCreateSampler                          := GetProcAddress( _OpenCLLib, 'clCreateSampler' );
     clEnqueueTask                            := GetProcAddress( _OpenCLLib, 'clEnqueueTask' );

     {$ENDIF} (* !defined(CL_NO_CORE_PROTOTYPES) *)

end;

end. //######################################################################### ■