package openxr


when ODIN_OS == .Windows {
    foreign import openxr_loader "openxr_loader.lib"
    @(require) foreign import "system:Advapi32.lib"
} else when ODIN_OS == .Darwin {
    foreign import openxr_loader "libopenxr_loader.dylib"
} else when ODIN_OS == .Linux {
    when ODIN_ARCH == .amd64 {
        foreign import openxr_loader "linux_x64/libopenxr_loader.so"
    } else when ODIN_ARCH == .arm64 {
        foreign import openxr_loader "linux_arm64/libopenxr_loader.so"
    } else {
        #panic("vendor/xr supports only linux amd64/arm64")
    }
}
// Link just the proc address loader
foreign openxr_loader {
	@(link_name = "xrGetInstanceProcAddr")
	GetInstanceProcAddr :: proc "system" (
		instance: Instance,
		name: cstring,
		function: ^ProcVoidFunction,
	) -> Result ---
}


// Loads all the base procedures which don't require an instance
load_base_procs :: proc() {
	out_function : ProcVoidFunction

	GetInstanceProcAddr(nil, "xrCreateInstance", &out_function)
	CreateInstance = auto_cast out_function
	GetInstanceProcAddr(nil, "xrEnumerateApiLayerProperties", &out_function)
	EnumerateApiLayerProperties = auto_cast out_function
	GetInstanceProcAddr(nil, "xrEnumerateInstanceExtensionProperties", &out_function)
	EnumerateInstanceExtensionProperties = auto_cast out_function
}


// Load all the instance procedures
load_instance_procs :: proc(instance: Instance) {
        out_function : ProcVoidFunction

	GetInstanceProcAddr(instance, "xrDestroyInstance", &out_function)
	DestroyInstance = auto_cast out_function
	GetInstanceProcAddr(instance, "xrResultToString", &out_function)
	ResultToString = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStructureTypeToString", &out_function)
	StructureTypeToString = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStructureTypeToString2KHR", &out_function)
	StructureTypeToString2KHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetInstanceProperties", &out_function)
	GetInstanceProperties = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSystem", &out_function)
	GetSystem = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSystemProperties", &out_function)
	GetSystemProperties = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSession", &out_function)
	CreateSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySession", &out_function)
	DestroySession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpace", &out_function)
	DestroySpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSwapchainFormats", &out_function)
	EnumerateSwapchainFormats = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSwapchain", &out_function)
	CreateSwapchain = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySwapchain", &out_function)
	DestroySwapchain = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSwapchainImages", &out_function)
	EnumerateSwapchainImages = auto_cast out_function
	GetInstanceProcAddr(instance, "xrAcquireSwapchainImage", &out_function)
	AcquireSwapchainImage = auto_cast out_function
	GetInstanceProcAddr(instance, "xrWaitSwapchainImage", &out_function)
	WaitSwapchainImage = auto_cast out_function
	GetInstanceProcAddr(instance, "xrReleaseSwapchainImage", &out_function)
	ReleaseSwapchainImage = auto_cast out_function
	GetInstanceProcAddr(instance, "xrBeginSession", &out_function)
	BeginSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEndSession", &out_function)
	EndSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestExitSession", &out_function)
	RequestExitSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateReferenceSpaces", &out_function)
	EnumerateReferenceSpaces = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateReferenceSpace", &out_function)
	CreateReferenceSpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateActionSpace", &out_function)
	CreateActionSpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateSpace", &out_function)
	LocateSpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateViewConfigurations", &out_function)
	EnumerateViewConfigurations = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateEnvironmentBlendModes", &out_function)
	EnumerateEnvironmentBlendModes = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetViewConfigurationProperties", &out_function)
	GetViewConfigurationProperties = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateViewConfigurationViews", &out_function)
	EnumerateViewConfigurationViews = auto_cast out_function
	GetInstanceProcAddr(instance, "xrBeginFrame", &out_function)
	BeginFrame = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateViews", &out_function)
	LocateViews = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEndFrame", &out_function)
	EndFrame = auto_cast out_function
	GetInstanceProcAddr(instance, "xrWaitFrame", &out_function)
	WaitFrame = auto_cast out_function
	GetInstanceProcAddr(instance, "xrApplyHapticFeedback", &out_function)
	ApplyHapticFeedback = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStopHapticFeedback", &out_function)
	StopHapticFeedback = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPollEvent", &out_function)
	PollEvent = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStringToPath", &out_function)
	StringToPath = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPathToString", &out_function)
	PathToString = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetReferenceSpaceBoundsRect", &out_function)
	GetReferenceSpaceBoundsRect = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetAndroidApplicationThreadKHR", &out_function)
	SetAndroidApplicationThreadKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSwapchainAndroidSurfaceKHR", &out_function)
	CreateSwapchainAndroidSurfaceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStateBoolean", &out_function)
	GetActionStateBoolean = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStateFloat", &out_function)
	GetActionStateFloat = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStateVector2f", &out_function)
	GetActionStateVector2f = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStatePose", &out_function)
	GetActionStatePose = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateActionSet", &out_function)
	CreateActionSet = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyActionSet", &out_function)
	DestroyActionSet = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateAction", &out_function)
	CreateAction = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyAction", &out_function)
	DestroyAction = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSuggestInteractionProfileBindings", &out_function)
	SuggestInteractionProfileBindings = auto_cast out_function
	GetInstanceProcAddr(instance, "xrAttachSessionActionSets", &out_function)
	AttachSessionActionSets = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetCurrentInteractionProfile", &out_function)
	GetCurrentInteractionProfile = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSyncActions", &out_function)
	SyncActions = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateBoundSourcesForAction", &out_function)
	EnumerateBoundSourcesForAction = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetInputSourceLocalizedName", &out_function)
	GetInputSourceLocalizedName = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanInstanceExtensionsKHR", &out_function)
	GetVulkanInstanceExtensionsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanDeviceExtensionsKHR", &out_function)
	GetVulkanDeviceExtensionsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsDeviceKHR", &out_function)
	GetVulkanGraphicsDeviceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetOpenGLGraphicsRequirementsKHR", &out_function)
	GetOpenGLGraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetOpenGLESGraphicsRequirementsKHR", &out_function)
	GetOpenGLESGraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsRequirementsKHR", &out_function)
	GetVulkanGraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetD3D11GraphicsRequirementsKHR", &out_function)
	GetD3D11GraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetD3D12GraphicsRequirementsKHR", &out_function)
	GetD3D12GraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMetalGraphicsRequirementsKHR", &out_function)
	GetMetalGraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPerfSettingsSetPerformanceLevelEXT", &out_function)
	PerfSettingsSetPerformanceLevelEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrThermalGetTemperatureTrendEXT", &out_function)
	ThermalGetTemperatureTrendEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetDebugUtilsObjectNameEXT", &out_function)
	SetDebugUtilsObjectNameEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateDebugUtilsMessengerEXT", &out_function)
	CreateDebugUtilsMessengerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyDebugUtilsMessengerEXT", &out_function)
	DestroyDebugUtilsMessengerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSubmitDebugUtilsMessageEXT", &out_function)
	SubmitDebugUtilsMessageEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSessionBeginDebugUtilsLabelRegionEXT", &out_function)
	SessionBeginDebugUtilsLabelRegionEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSessionEndDebugUtilsLabelRegionEXT", &out_function)
	SessionEndDebugUtilsLabelRegionEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSessionInsertDebugUtilsLabelEXT", &out_function)
	SessionInsertDebugUtilsLabelEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertTimeToWin32PerformanceCounterKHR", &out_function)
	ConvertTimeToWin32PerformanceCounterKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertWin32PerformanceCounterToTimeKHR", &out_function)
	ConvertWin32PerformanceCounterToTimeKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateVulkanInstanceKHR", &out_function)
	CreateVulkanInstanceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateVulkanDeviceKHR", &out_function)
	CreateVulkanDeviceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsDevice2KHR", &out_function)
	GetVulkanGraphicsDevice2KHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsRequirements2KHR", &out_function)
	GetVulkanGraphicsRequirements2KHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertTimeToTimespecTimeKHR", &out_function)
	ConvertTimeToTimespecTimeKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertTimespecTimeToTimeKHR", &out_function)
	ConvertTimespecTimeToTimeKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVisibilityMaskKHR", &out_function)
	GetVisibilityMaskKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorMSFT", &out_function)
	CreateSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorSpaceMSFT", &out_function)
	CreateSpatialAnchorSpaceMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialAnchorMSFT", &out_function)
	DestroySpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceActiveEXT", &out_function)
	SetInputDeviceActiveEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceStateBoolEXT", &out_function)
	SetInputDeviceStateBoolEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceStateFloatEXT", &out_function)
	SetInputDeviceStateFloatEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceStateVector2fEXT", &out_function)
	SetInputDeviceStateVector2fEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceLocationEXT", &out_function)
	SetInputDeviceLocationEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrInitializeLoaderKHR", &out_function)
	InitializeLoaderKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialGraphNodeSpaceMSFT", &out_function)
	CreateSpatialGraphNodeSpaceMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTryCreateSpatialGraphStaticNodeBindingMSFT", &out_function)
	TryCreateSpatialGraphStaticNodeBindingMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialGraphNodeBindingMSFT", &out_function)
	DestroySpatialGraphNodeBindingMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialGraphNodeBindingPropertiesMSFT", &out_function)
	GetSpatialGraphNodeBindingPropertiesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateHandTrackerEXT", &out_function)
	CreateHandTrackerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyHandTrackerEXT", &out_function)
	DestroyHandTrackerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateHandJointsEXT", &out_function)
	LocateHandJointsEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFaceTrackerFB", &out_function)
	CreateFaceTrackerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFaceTrackerFB", &out_function)
	DestroyFaceTrackerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFaceExpressionWeightsFB", &out_function)
	GetFaceExpressionWeightsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFaceTracker2FB", &out_function)
	CreateFaceTracker2FB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFaceTracker2FB", &out_function)
	DestroyFaceTracker2FB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFaceExpressionWeights2FB", &out_function)
	GetFaceExpressionWeights2FB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateBodyTrackerFB", &out_function)
	CreateBodyTrackerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyBodyTrackerFB", &out_function)
	DestroyBodyTrackerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateBodyJointsFB", &out_function)
	LocateBodyJointsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetBodySkeletonFB", &out_function)
	GetBodySkeletonFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSuggestBodyTrackingCalibrationOverrideMETA", &out_function)
	SuggestBodyTrackingCalibrationOverrideMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrResetBodyTrackingCalibrationMETA", &out_function)
	ResetBodyTrackingCalibrationMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateEyeTrackerFB", &out_function)
	CreateEyeTrackerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyEyeTrackerFB", &out_function)
	DestroyEyeTrackerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetEyeGazesFB", &out_function)
	GetEyeGazesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateHandMeshSpaceMSFT", &out_function)
	CreateHandMeshSpaceMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateHandMeshMSFT", &out_function)
	UpdateHandMeshMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetControllerModelKeyMSFT", &out_function)
	GetControllerModelKeyMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLoadControllerModelMSFT", &out_function)
	LoadControllerModelMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetControllerModelPropertiesMSFT", &out_function)
	GetControllerModelPropertiesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetControllerModelStateMSFT", &out_function)
	GetControllerModelStateMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSceneComputeFeaturesMSFT", &out_function)
	EnumerateSceneComputeFeaturesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSceneObserverMSFT", &out_function)
	CreateSceneObserverMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySceneObserverMSFT", &out_function)
	DestroySceneObserverMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSceneMSFT", &out_function)
	CreateSceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySceneMSFT", &out_function)
	DestroySceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrComputeNewSceneMSFT", &out_function)
	ComputeNewSceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneComputeStateMSFT", &out_function)
	GetSceneComputeStateMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneComponentsMSFT", &out_function)
	GetSceneComponentsMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateSceneComponentsMSFT", &out_function)
	LocateSceneComponentsMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneMeshBuffersMSFT", &out_function)
	GetSceneMeshBuffersMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDeserializeSceneMSFT", &out_function)
	DeserializeSceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSerializedSceneFragmentDataMSFT", &out_function)
	GetSerializedSceneFragmentDataMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneMarkerRawDataMSFT", &out_function)
	GetSceneMarkerRawDataMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneMarkerDecodedStringMSFT", &out_function)
	GetSceneMarkerDecodedStringMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateDisplayRefreshRatesFB", &out_function)
	EnumerateDisplayRefreshRatesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetDisplayRefreshRateFB", &out_function)
	GetDisplayRefreshRateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestDisplayRefreshRateFB", &out_function)
	RequestDisplayRefreshRateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorFromPerceptionAnchorMSFT", &out_function)
	CreateSpatialAnchorFromPerceptionAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTryGetPerceptionAnchorFromSpatialAnchorMSFT", &out_function)
	TryGetPerceptionAnchorFromSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSwapchainFB", &out_function)
	UpdateSwapchainFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSwapchainStateFB", &out_function)
	GetSwapchainStateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateColorSpacesFB", &out_function)
	EnumerateColorSpacesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetColorSpaceFB", &out_function)
	SetColorSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFoveationProfileFB", &out_function)
	CreateFoveationProfileFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFoveationProfileFB", &out_function)
	DestroyFoveationProfileFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFoveationEyeTrackedStateMETA", &out_function)
	GetFoveationEyeTrackedStateMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetHandMeshFB", &out_function)
	GetHandMeshFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateRenderModelPathsFB", &out_function)
	EnumerateRenderModelPathsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRenderModelPropertiesFB", &out_function)
	GetRenderModelPropertiesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLoadRenderModelFB", &out_function)
	LoadRenderModelFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySystemTrackedKeyboardFB", &out_function)
	QuerySystemTrackedKeyboardFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateKeyboardSpaceFB", &out_function)
	CreateKeyboardSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetEnvironmentDepthEstimationVARJO", &out_function)
	SetEnvironmentDepthEstimationVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateReprojectionModesMSFT", &out_function)
	EnumerateReprojectionModesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAudioOutputDeviceGuidOculus", &out_function)
	GetAudioOutputDeviceGuidOculus = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAudioInputDeviceGuidOculus", &out_function)
	GetAudioInputDeviceGuidOculus = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorFB", &out_function)
	CreateSpatialAnchorFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceUuidFB", &out_function)
	GetSpaceUuidFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpaceSupportedComponentsFB", &out_function)
	EnumerateSpaceSupportedComponentsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetSpaceComponentStatusFB", &out_function)
	SetSpaceComponentStatusFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceComponentStatusFB", &out_function)
	GetSpaceComponentStatusFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateTriangleMeshFB", &out_function)
	CreateTriangleMeshFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyTriangleMeshFB", &out_function)
	DestroyTriangleMeshFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshGetVertexBufferFB", &out_function)
	TriangleMeshGetVertexBufferFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshGetIndexBufferFB", &out_function)
	TriangleMeshGetIndexBufferFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshBeginUpdateFB", &out_function)
	TriangleMeshBeginUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshEndUpdateFB", &out_function)
	TriangleMeshEndUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshBeginVertexBufferUpdateFB", &out_function)
	TriangleMeshBeginVertexBufferUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshEndVertexBufferUpdateFB", &out_function)
	TriangleMeshEndVertexBufferUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughFB", &out_function)
	CreatePassthroughFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughFB", &out_function)
	DestroyPassthroughFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughStartFB", &out_function)
	PassthroughStartFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughPauseFB", &out_function)
	PassthroughPauseFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughLayerFB", &out_function)
	CreatePassthroughLayerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughLayerFB", &out_function)
	DestroyPassthroughLayerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerPauseFB", &out_function)
	PassthroughLayerPauseFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerResumeFB", &out_function)
	PassthroughLayerResumeFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerSetStyleFB", &out_function)
	PassthroughLayerSetStyleFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateGeometryInstanceFB", &out_function)
	CreateGeometryInstanceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyGeometryInstanceFB", &out_function)
	DestroyGeometryInstanceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGeometryInstanceSetTransformFB", &out_function)
	GeometryInstanceSetTransformFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySpacesFB", &out_function)
	QuerySpacesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRetrieveSpaceQueryResultsFB", &out_function)
	RetrieveSpaceQueryResultsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSaveSpaceFB", &out_function)
	SaveSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEraseSpaceFB", &out_function)
	EraseSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSaveSpaceListFB", &out_function)
	SaveSpaceListFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrShareSpacesFB", &out_function)
	ShareSpacesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceContainerFB", &out_function)
	GetSpaceContainerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceTriangleMeshMETA", &out_function)
	GetSpaceTriangleMeshMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceRoomMeshMETA", &out_function)
	GetSpaceRoomMeshMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceRoomMeshFaceIndicesMETA", &out_function)
	GetSpaceRoomMeshFaceIndicesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestBoundaryVisibilityMETA", &out_function)
	RequestBoundaryVisibilityMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceBoundingBox2DFB", &out_function)
	GetSpaceBoundingBox2DFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceBoundingBox3DFB", &out_function)
	GetSpaceBoundingBox3DFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceSemanticLabelsFB", &out_function)
	GetSpaceSemanticLabelsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceBoundary2DFB", &out_function)
	GetSpaceBoundary2DFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceRoomLayoutFB", &out_function)
	GetSpaceRoomLayoutFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestSceneCaptureFB", &out_function)
	RequestSceneCaptureFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerSetKeyboardHandsIntensityFB", &out_function)
	PassthroughLayerSetKeyboardHandsIntensityFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStartColocationDiscoveryMETA", &out_function)
	StartColocationDiscoveryMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStopColocationDiscoveryMETA", &out_function)
	StopColocationDiscoveryMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStartColocationAdvertisementMETA", &out_function)
	StartColocationAdvertisementMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStopColocationAdvertisementMETA", &out_function)
	StopColocationAdvertisementMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrShareSpacesMETA", &out_function)
	ShareSpacesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorStoreConnectionMSFT", &out_function)
	CreateSpatialAnchorStoreConnectionMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialAnchorStoreConnectionMSFT", &out_function)
	DestroySpatialAnchorStoreConnectionMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPersistSpatialAnchorMSFT", &out_function)
	PersistSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumeratePersistedSpatialAnchorNamesMSFT", &out_function)
	EnumeratePersistedSpatialAnchorNamesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorFromPersistedNameMSFT", &out_function)
	CreateSpatialAnchorFromPersistedNameMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnpersistSpatialAnchorMSFT", &out_function)
	UnpersistSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrClearSpatialAnchorStoreMSFT", &out_function)
	ClearSpatialAnchorStoreMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateBodyTrackerBD", &out_function)
	CreateBodyTrackerBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyBodyTrackerBD", &out_function)
	DestroyBodyTrackerBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateBodyJointsBD", &out_function)
	LocateBodyJointsBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFacialTrackerHTC", &out_function)
	CreateFacialTrackerHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFacialTrackerHTC", &out_function)
	DestroyFacialTrackerHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFacialExpressionsHTC", &out_function)
	GetFacialExpressionsHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughHTC", &out_function)
	CreatePassthroughHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughHTC", &out_function)
	DestroyPassthroughHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorHTC", &out_function)
	CreateSpatialAnchorHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialAnchorNameHTC", &out_function)
	GetSpatialAnchorNameHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateViveTrackerPathsHTCX", &out_function)
	EnumerateViveTrackerPathsHTCX = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateBodyTrackerHTC", &out_function)
	CreateBodyTrackerHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyBodyTrackerHTC", &out_function)
	DestroyBodyTrackerHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateBodyJointsHTC", &out_function)
	LocateBodyJointsHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetBodySkeletonHTC", &out_function)
	GetBodySkeletonHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetMarkerTrackingVARJO", &out_function)
	SetMarkerTrackingVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetMarkerTrackingTimeoutVARJO", &out_function)
	SetMarkerTrackingTimeoutVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetMarkerTrackingPredictionVARJO", &out_function)
	SetMarkerTrackingPredictionVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkerSizeVARJO", &out_function)
	GetMarkerSizeVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateMarkerSpaceVARJO", &out_function)
	CreateMarkerSpaceVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestBodyTrackingFidelityMETA", &out_function)
	RequestBodyTrackingFidelityMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetDigitalLensControlALMALENCE", &out_function)
	SetDigitalLensControlALMALENCE = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetViewOffsetVARJO", &out_function)
	SetViewOffsetVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateExternalCamerasOCULUS", &out_function)
	EnumerateExternalCamerasOCULUS = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughColorLutMETA", &out_function)
	CreatePassthroughColorLutMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughColorLutMETA", &out_function)
	DestroyPassthroughColorLutMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdatePassthroughColorLutMETA", &out_function)
	UpdatePassthroughColorLutMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumeratePerformanceMetricsCounterPathsMETA", &out_function)
	EnumeratePerformanceMetricsCounterPathsMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetPerformanceMetricsStateMETA", &out_function)
	SetPerformanceMetricsStateMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPerformanceMetricsStateMETA", &out_function)
	GetPerformanceMetricsStateMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQueryPerformanceMetricsCounterMETA", &out_function)
	QueryPerformanceMetricsCounterMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPassthroughPreferencesMETA", &out_function)
	GetPassthroughPreferencesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrApplyFoveationHTC", &out_function)
	ApplyFoveationHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpaceFromCoordinateFrameUIDML", &out_function)
	CreateSpaceFromCoordinateFrameUIDML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetDeviceSampleRateFB", &out_function)
	GetDeviceSampleRateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetTrackingOptimizationSettingsHintQCOM", &out_function)
	SetTrackingOptimizationSettingsHintQCOM = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpaceUserFB", &out_function)
	CreateSpaceUserFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceUserIdFB", &out_function)
	GetSpaceUserIdFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpaceUserFB", &out_function)
	DestroySpaceUserFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRecommendedLayerResolutionMETA", &out_function)
	GetRecommendedLayerResolutionMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSaveSpacesMETA", &out_function)
	SaveSpacesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEraseSpacesMETA", &out_function)
	EraseSpacesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDiscoverSpacesMETA", &out_function)
	DiscoverSpacesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRetrieveSpaceDiscoveryResultsMETA", &out_function)
	RetrieveSpaceDiscoveryResultsMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrApplyForceFeedbackCurlMNDX", &out_function)
	ApplyForceFeedbackCurlMNDX = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFaceTrackerANDROID", &out_function)
	CreateFaceTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFaceTrackerANDROID", &out_function)
	DestroyFaceTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFaceStateANDROID", &out_function)
	GetFaceStateANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFaceCalibrationStateANDROID", &out_function)
	GetFaceCalibrationStateANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPassthroughCameraStateANDROID", &out_function)
	GetPassthroughCameraStateANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSupportedTrackableTypesANDROID", &out_function)
	EnumerateSupportedTrackableTypesANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSupportedAnchorTrackableTypesANDROID", &out_function)
	EnumerateSupportedAnchorTrackableTypesANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateTrackableTrackerANDROID", &out_function)
	CreateTrackableTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyTrackableTrackerANDROID", &out_function)
	DestroyTrackableTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAllTrackablesANDROID", &out_function)
	GetAllTrackablesANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetTrackablePlaneANDROID", &out_function)
	GetTrackablePlaneANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateAnchorSpaceANDROID", &out_function)
	CreateAnchorSpaceANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrShareAnchorANDROID", &out_function)
	ShareAnchorANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnshareAnchorANDROID", &out_function)
	UnshareAnchorANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetTrackableObjectANDROID", &out_function)
	GetTrackableObjectANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateRaycastSupportedTrackableTypesANDROID", &out_function)
	EnumerateRaycastSupportedTrackableTypesANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRaycastANDROID", &out_function)
	RaycastANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetTrackableMarkerANDROID", &out_function)
	GetTrackableMarkerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSupportedPersistenceAnchorTypesANDROID", &out_function)
	EnumerateSupportedPersistenceAnchorTypesANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateDeviceAnchorPersistenceANDROID", &out_function)
	CreateDeviceAnchorPersistenceANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyDeviceAnchorPersistenceANDROID", &out_function)
	DestroyDeviceAnchorPersistenceANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPersistAnchorANDROID", &out_function)
	PersistAnchorANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAnchorPersistStateANDROID", &out_function)
	GetAnchorPersistStateANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePersistedAnchorSpaceANDROID", &out_function)
	CreatePersistedAnchorSpaceANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumeratePersistedAnchorsANDROID", &out_function)
	EnumeratePersistedAnchorsANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnpersistAnchorANDROID", &out_function)
	UnpersistAnchorANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumeratePerformanceMetricsCounterPathsANDROID", &out_function)
	EnumeratePerformanceMetricsCounterPathsANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetPerformanceMetricsStateANDROID", &out_function)
	SetPerformanceMetricsStateANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPerformanceMetricsStateANDROID", &out_function)
	GetPerformanceMetricsStateANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQueryPerformanceMetricsCounterANDROID", &out_function)
	QueryPerformanceMetricsCounterANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetTrackableQrCodeANDROID", &out_function)
	GetTrackableQrCodeANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughLayerANDROID", &out_function)
	CreatePassthroughLayerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughLayerANDROID", &out_function)
	DestroyPassthroughLayerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetPassthroughLayerMeshANDROID", &out_function)
	SetPassthroughLayerMeshANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSupportedSemanticLabelSetsANDROID", &out_function)
	EnumerateSupportedSemanticLabelSetsANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSceneMeshingTrackerANDROID", &out_function)
	CreateSceneMeshingTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySceneMeshingTrackerANDROID", &out_function)
	DestroySceneMeshingTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSceneMeshSnapshotANDROID", &out_function)
	CreateSceneMeshSnapshotANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySceneMeshSnapshotANDROID", &out_function)
	DestroySceneMeshSnapshotANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAllSubmeshStatesANDROID", &out_function)
	GetAllSubmeshStatesANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSubmeshDataANDROID", &out_function)
	GetSubmeshDataANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateEyeTrackerANDROID", &out_function)
	CreateEyeTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyEyeTrackerANDROID", &out_function)
	DestroyEyeTrackerANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetCoarseTrackingEyesInfoANDROID", &out_function)
	GetCoarseTrackingEyesInfoANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFineTrackingEyesInfoANDROID", &out_function)
	GetFineTrackingEyesInfoANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateLightEstimatorANDROID", &out_function)
	CreateLightEstimatorANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyLightEstimatorANDROID", &out_function)
	DestroyLightEstimatorANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetLightEstimateANDROID", &out_function)
	GetLightEstimateANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePlaneDetectorEXT", &out_function)
	CreatePlaneDetectorEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPlaneDetectorEXT", &out_function)
	DestroyPlaneDetectorEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrBeginPlaneDetectionEXT", &out_function)
	BeginPlaneDetectionEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPlaneDetectionStateEXT", &out_function)
	GetPlaneDetectionStateEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPlaneDetectionsEXT", &out_function)
	GetPlaneDetectionsEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPlanePolygonBufferEXT", &out_function)
	GetPlanePolygonBufferEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateVirtualKeyboardMETA", &out_function)
	CreateVirtualKeyboardMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyVirtualKeyboardMETA", &out_function)
	DestroyVirtualKeyboardMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateVirtualKeyboardSpaceMETA", &out_function)
	CreateVirtualKeyboardSpaceMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSuggestVirtualKeyboardLocationMETA", &out_function)
	SuggestVirtualKeyboardLocationMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVirtualKeyboardScaleMETA", &out_function)
	GetVirtualKeyboardScaleMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetVirtualKeyboardModelVisibilityMETA", &out_function)
	SetVirtualKeyboardModelVisibilityMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVirtualKeyboardModelAnimationStatesMETA", &out_function)
	GetVirtualKeyboardModelAnimationStatesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVirtualKeyboardDirtyTexturesMETA", &out_function)
	GetVirtualKeyboardDirtyTexturesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVirtualKeyboardTextureDataMETA", &out_function)
	GetVirtualKeyboardTextureDataMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSendVirtualKeyboardInputMETA", &out_function)
	SendVirtualKeyboardInputMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrChangeVirtualKeyboardTextContextMETA", &out_function)
	ChangeVirtualKeyboardTextContextMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnableUserCalibrationEventsML", &out_function)
	EnableUserCalibrationEventsML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnableLocalizationEventsML", &out_function)
	EnableLocalizationEventsML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQueryLocalizationMapsML", &out_function)
	QueryLocalizationMapsML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestMapLocalizationML", &out_function)
	RequestMapLocalizationML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrImportLocalizationMapML", &out_function)
	ImportLocalizationMapML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateExportedLocalizationMapML", &out_function)
	CreateExportedLocalizationMapML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyExportedLocalizationMapML", &out_function)
	DestroyExportedLocalizationMapML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetExportedLocalizationMapDataML", &out_function)
	GetExportedLocalizationMapDataML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateMarkerDetectorML", &out_function)
	CreateMarkerDetectorML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyMarkerDetectorML", &out_function)
	DestroyMarkerDetectorML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSnapshotMarkerDetectorML", &out_function)
	SnapshotMarkerDetectorML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkerDetectorStateML", &out_function)
	GetMarkerDetectorStateML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkersML", &out_function)
	GetMarkersML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkerReprojectionErrorML", &out_function)
	GetMarkerReprojectionErrorML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkerLengthML", &out_function)
	GetMarkerLengthML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkerNumberML", &out_function)
	GetMarkerNumberML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkerStringML", &out_function)
	GetMarkerStringML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateMarkerSpaceML", &out_function)
	CreateMarkerSpaceML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPollFutureEXT", &out_function)
	PollFutureEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCancelFutureEXT", &out_function)
	CancelFutureEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateEnvironmentDepthProviderMETA", &out_function)
	CreateEnvironmentDepthProviderMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyEnvironmentDepthProviderMETA", &out_function)
	DestroyEnvironmentDepthProviderMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStartEnvironmentDepthProviderMETA", &out_function)
	StartEnvironmentDepthProviderMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStopEnvironmentDepthProviderMETA", &out_function)
	StopEnvironmentDepthProviderMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateEnvironmentDepthSwapchainMETA", &out_function)
	CreateEnvironmentDepthSwapchainMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyEnvironmentDepthSwapchainMETA", &out_function)
	DestroyEnvironmentDepthSwapchainMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateEnvironmentDepthSwapchainImagesMETA", &out_function)
	EnumerateEnvironmentDepthSwapchainImagesMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetEnvironmentDepthSwapchainStateMETA", &out_function)
	GetEnvironmentDepthSwapchainStateMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrAcquireEnvironmentDepthImageMETA", &out_function)
	AcquireEnvironmentDepthImageMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetEnvironmentDepthHandRemovalMETA", &out_function)
	SetEnvironmentDepthHandRemovalMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetStationaryReferenceSpaceGenerationIdEXT", &out_function)
	GetStationaryReferenceSpaceGenerationIdEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFacialExpressionClientML", &out_function)
	CreateFacialExpressionClientML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFacialExpressionClientML", &out_function)
	DestroyFacialExpressionClientML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFacialExpressionBlendShapePropertiesML", &out_function)
	GetFacialExpressionBlendShapePropertiesML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateSpacesKHR", &out_function)
	LocateSpacesKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateSpaces", &out_function)
	LocateSpaces = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpatialCapabilitiesEXT", &out_function)
	EnumerateSpatialCapabilitiesEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpatialCapabilityComponentTypesEXT", &out_function)
	EnumerateSpatialCapabilityComponentTypesEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpatialCapabilityFeaturesEXT", &out_function)
	EnumerateSpatialCapabilityFeaturesEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialContextAsyncEXT", &out_function)
	CreateSpatialContextAsyncEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialContextCompleteEXT", &out_function)
	CreateSpatialContextCompleteEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialContextEXT", &out_function)
	DestroySpatialContextEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialDiscoverySnapshotAsyncEXT", &out_function)
	CreateSpatialDiscoverySnapshotAsyncEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialDiscoverySnapshotCompleteEXT", &out_function)
	CreateSpatialDiscoverySnapshotCompleteEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySpatialComponentDataEXT", &out_function)
	QuerySpatialComponentDataEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialSnapshotEXT", &out_function)
	DestroySpatialSnapshotEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialEntityFromIdEXT", &out_function)
	CreateSpatialEntityFromIdEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialEntityEXT", &out_function)
	DestroySpatialEntityEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialUpdateSnapshotEXT", &out_function)
	CreateSpatialUpdateSnapshotEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialBufferStringEXT", &out_function)
	GetSpatialBufferStringEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialBufferUint8EXT", &out_function)
	GetSpatialBufferUint8EXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialBufferUint16EXT", &out_function)
	GetSpatialBufferUint16EXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialBufferUint32EXT", &out_function)
	GetSpatialBufferUint32EXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialBufferFloatEXT", &out_function)
	GetSpatialBufferFloatEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialBufferVector2fEXT", &out_function)
	GetSpatialBufferVector2fEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialBufferVector3fEXT", &out_function)
	GetSpatialBufferVector3fEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorEXT", &out_function)
	CreateSpatialAnchorEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpatialPersistenceScopesEXT", &out_function)
	EnumerateSpatialPersistenceScopesEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialPersistenceContextAsyncEXT", &out_function)
	CreateSpatialPersistenceContextAsyncEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialPersistenceContextCompleteEXT", &out_function)
	CreateSpatialPersistenceContextCompleteEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialPersistenceContextEXT", &out_function)
	DestroySpatialPersistenceContextEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPersistSpatialEntityAsyncEXT", &out_function)
	PersistSpatialEntityAsyncEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPersistSpatialEntityCompleteEXT", &out_function)
	PersistSpatialEntityCompleteEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnpersistSpatialEntityAsyncEXT", &out_function)
	UnpersistSpatialEntityAsyncEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnpersistSpatialEntityCompleteEXT", &out_function)
	UnpersistSpatialEntityCompleteEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetSystemNotificationsML", &out_function)
	SetSystemNotificationsML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorsAsyncML", &out_function)
	CreateSpatialAnchorsAsyncML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorsCompleteML", &out_function)
	CreateSpatialAnchorsCompleteML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialAnchorStateML", &out_function)
	GetSpatialAnchorStateML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorsStorageML", &out_function)
	CreateSpatialAnchorsStorageML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialAnchorsStorageML", &out_function)
	DestroySpatialAnchorsStorageML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySpatialAnchorsAsyncML", &out_function)
	QuerySpatialAnchorsAsyncML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySpatialAnchorsCompleteML", &out_function)
	QuerySpatialAnchorsCompleteML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPublishSpatialAnchorsAsyncML", &out_function)
	PublishSpatialAnchorsAsyncML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPublishSpatialAnchorsCompleteML", &out_function)
	PublishSpatialAnchorsCompleteML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDeleteSpatialAnchorsAsyncML", &out_function)
	DeleteSpatialAnchorsAsyncML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDeleteSpatialAnchorsCompleteML", &out_function)
	DeleteSpatialAnchorsCompleteML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSpatialAnchorsExpirationAsyncML", &out_function)
	UpdateSpatialAnchorsExpirationAsyncML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSpatialAnchorsExpirationCompleteML", &out_function)
	UpdateSpatialAnchorsExpirationCompleteML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateWorldMeshDetectorML", &out_function)
	CreateWorldMeshDetectorML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyWorldMeshDetectorML", &out_function)
	DestroyWorldMeshDetectorML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestWorldMeshStateAsyncML", &out_function)
	RequestWorldMeshStateAsyncML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestWorldMeshStateCompleteML", &out_function)
	RequestWorldMeshStateCompleteML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetWorldMeshBufferRecommendSizeML", &out_function)
	GetWorldMeshBufferRecommendSizeML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrAllocateWorldMeshBufferML", &out_function)
	AllocateWorldMeshBufferML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrFreeWorldMeshBufferML", &out_function)
	FreeWorldMeshBufferML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestWorldMeshAsyncML", &out_function)
	RequestWorldMeshAsyncML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestWorldMeshCompleteML", &out_function)
	RequestWorldMeshCompleteML = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateRenderModelEXT", &out_function)
	CreateRenderModelEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyRenderModelEXT", &out_function)
	DestroyRenderModelEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRenderModelPropertiesEXT", &out_function)
	GetRenderModelPropertiesEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateRenderModelSpaceEXT", &out_function)
	CreateRenderModelSpaceEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateRenderModelAssetEXT", &out_function)
	CreateRenderModelAssetEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyRenderModelAssetEXT", &out_function)
	DestroyRenderModelAssetEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRenderModelAssetDataEXT", &out_function)
	GetRenderModelAssetDataEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRenderModelAssetPropertiesEXT", &out_function)
	GetRenderModelAssetPropertiesEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRenderModelStateEXT", &out_function)
	GetRenderModelStateEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateInteractionRenderModelIdsEXT", &out_function)
	EnumerateInteractionRenderModelIdsEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateRenderModelSubactionPathsEXT", &out_function)
	EnumerateRenderModelSubactionPathsEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRenderModelPoseTopLevelUserPathEXT", &out_function)
	GetRenderModelPoseTopLevelUserPathEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSupportedAudioSampleRateBD", &out_function)
	EnumerateSupportedAudioSampleRateBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQueryFramesPerBufferRangeBD", &out_function)
	QueryFramesPerBufferRangeBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAudioRendererBD", &out_function)
	CreateSpatialAudioRendererBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialAudioRendererBD", &out_function)
	DestroySpatialAudioRendererBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSoundObstacleMaterialBD", &out_function)
	CreateSoundObstacleMaterialBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSoundObstacleMaterialConfigBD", &out_function)
	UpdateSoundObstacleMaterialConfigBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySoundObstacleMaterialBD", &out_function)
	DestroySoundObstacleMaterialBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSoundObstacleBD", &out_function)
	CreateSoundObstacleBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSoundObstacleConfigBD", &out_function)
	UpdateSoundObstacleConfigBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySoundObstacleBD", &out_function)
	DestroySoundObstacleBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSoundObjectBD", &out_function)
	CreateSoundObjectBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSoundObjectConfigBD", &out_function)
	UpdateSoundObjectConfigBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSubmitSoundObjectBufferBD", &out_function)
	SubmitSoundObjectBufferBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySoundObjectBD", &out_function)
	DestroySoundObjectBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSoundFieldBD", &out_function)
	CreateSoundFieldBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSoundFieldConfigBD", &out_function)
	UpdateSoundFieldConfigBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSubmitSoundFieldBufferBD", &out_function)
	SubmitSoundFieldBufferBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySoundFieldBD", &out_function)
	DestroySoundFieldBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrWaitAudioPeriodBD", &out_function)
	WaitAudioPeriodBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEndAudioPeriodBD", &out_function)
	EndAudioPeriodBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialEntityUuidBD", &out_function)
	GetSpatialEntityUuidBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpatialEntityComponentTypesBD", &out_function)
	EnumerateSpatialEntityComponentTypesBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialEntityComponentDataBD", &out_function)
	GetSpatialEntityComponentDataBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSenseDataProviderBD", &out_function)
	CreateSenseDataProviderBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStartSenseDataProviderAsyncBD", &out_function)
	StartSenseDataProviderAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStartSenseDataProviderCompleteBD", &out_function)
	StartSenseDataProviderCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSenseDataProviderStateBD", &out_function)
	GetSenseDataProviderStateBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySenseDataAsyncBD", &out_function)
	QuerySenseDataAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySenseDataCompleteBD", &out_function)
	QuerySenseDataCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySenseDataSnapshotBD", &out_function)
	DestroySenseDataSnapshotBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetQueriedSenseDataBD", &out_function)
	GetQueriedSenseDataBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStopSenseDataProviderBD", &out_function)
	StopSenseDataProviderBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySenseDataProviderBD", &out_function)
	DestroySenseDataProviderBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialEntityAnchorBD", &out_function)
	CreateSpatialEntityAnchorBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyAnchorBD", &out_function)
	DestroyAnchorBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAnchorUuidBD", &out_function)
	GetAnchorUuidBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateAnchorSpaceBD", &out_function)
	CreateAnchorSpaceBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorAsyncBD", &out_function)
	CreateSpatialAnchorAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorCompleteBD", &out_function)
	CreateSpatialAnchorCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPersistSpatialAnchorAsyncBD", &out_function)
	PersistSpatialAnchorAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPersistSpatialAnchorCompleteBD", &out_function)
	PersistSpatialAnchorCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnpersistSpatialAnchorAsyncBD", &out_function)
	UnpersistSpatialAnchorAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnpersistSpatialAnchorCompleteBD", &out_function)
	UnpersistSpatialAnchorCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrShareSpatialAnchorAsyncBD", &out_function)
	ShareSpatialAnchorAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrShareSpatialAnchorCompleteBD", &out_function)
	ShareSpatialAnchorCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDownloadSharedSpatialAnchorAsyncBD", &out_function)
	DownloadSharedSpatialAnchorAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDownloadSharedSpatialAnchorCompleteBD", &out_function)
	DownloadSharedSpatialAnchorCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCaptureSceneAsyncBD", &out_function)
	CaptureSceneAsyncBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCaptureSceneCompleteBD", &out_function)
	CaptureSceneCompleteBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrResumeSimultaneousHandsAndControllersTrackingMETA", &out_function)
	ResumeSimultaneousHandsAndControllersTrackingMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPauseSimultaneousHandsAndControllersTrackingMETA", &out_function)
	PauseSimultaneousHandsAndControllersTrackingMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateFacialSimulationModesBD", &out_function)
	EnumerateFacialSimulationModesBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFaceTrackerBD", &out_function)
	CreateFaceTrackerBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFaceTrackerBD", &out_function)
	DestroyFaceTrackerBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFacialSimulationDataBD", &out_function)
	GetFacialSimulationDataBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetFacialSimulationModeBD", &out_function)
	SetFacialSimulationModeBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFacialSimulationModeBD", &out_function)
	GetFacialSimulationModeBD = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateTrackableImageDatabaseAsyncANDROID", &out_function)
	CreateTrackableImageDatabaseAsyncANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateTrackableImageDatabaseCompleteANDROID", &out_function)
	CreateTrackableImageDatabaseCompleteANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyTrackableImageDatabaseANDROID", &out_function)
	DestroyTrackableImageDatabaseANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrAddTrackableImageDatabaseANDROID", &out_function)
	AddTrackableImageDatabaseANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRemoveTrackableImageDatabaseANDROID", &out_function)
	RemoveTrackableImageDatabaseANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetTrackableImageANDROID", &out_function)
	GetTrackableImageANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpatialAnchorAttachableComponentsANDROID", &out_function)
	EnumerateSpatialAnchorAttachableComponentsANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorSpaceANDROID", &out_function)
	CreateSpatialAnchorSpaceANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorSpaceFromIdANDROID", &out_function)
	CreateSpatialAnchorSpaceFromIdANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetTilePropertiesHintMETA", &out_function)
	SetTilePropertiesHintMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateEnvironmentRaycasterAsyncMETA", &out_function)
	CreateEnvironmentRaycasterAsyncMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateEnvironmentRaycasterCompleteMETA", &out_function)
	CreateEnvironmentRaycasterCompleteMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyEnvironmentRaycasterMETA", &out_function)
	DestroyEnvironmentRaycasterMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPerformEnvironmentRaycastMETA", &out_function)
	PerformEnvironmentRaycastMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialRaycastSnapshotANDROID", &out_function)
	CreateSpatialRaycastSnapshotANDROID = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetHandGestureQCOM", &out_function)
	GetHandGestureQCOM = auto_cast out_function
	GetInstanceProcAddr(instance, "xrHapticParametricGetPropertiesEXT", &out_function)
	HapticParametricGetPropertiesEXT = auto_cast out_function
}

