package openxr


import "core:c"
import "core:c/libc"
import win32 "core:sys/windows"

// Vulkan Types
import vk "vendor:vulkan"

timespec :: libc.timespec
wchar_t :: libc.wchar_t
jobject :: rawptr

when ODIN_OS == .Windows {
	LARGE_INTEGER :: win32.LARGE_INTEGER
} else {
	LARGE_INTEGER :: distinct distinct c.longlong
}

ProcNegotiateLoaderRuntimeInterface :: #type proc "system" (
	loaderInfo: ^NegotiateLoaderInfo,
	runtimeRequest: ^NegotiateRuntimeRequest,
) -> Result

ProcNegotiateLoaderApiLayerInterface :: #type proc "system" (
	loaderInfo: ^NegotiateLoaderInfo,
	layerName: cstring,
	apiLayerRequest: ^NegotiateApiLayerRequest,
) -> Result

ProcCreateApiLayerInstance :: #type proc "system" (
	info: ^InstanceCreateInfo,
	layerInfo: ^ApiLayerCreateInfo,
	instance: ^Instance,
) -> Result



NegotiateLoaderRuntimeInterface: ProcNegotiateLoaderRuntimeInterface
NegotiateLoaderApiLayerInterface: ProcNegotiateLoaderApiLayerInterface
CreateApiLayerInstance: ProcCreateApiLayerInstance
ProcEnumerateApiLayerProperties :: #type proc "system" (
	propertyCapacityInput: u32,
	propertyCountOutput: ^u32,
	properties: ^ApiLayerProperties,
) -> Result

ProcEnumerateInstanceExtensionProperties :: #type proc "system" (
	layerName: cstring,
	propertyCapacityInput: u32,
	propertyCountOutput: ^u32,
	properties: ^ExtensionProperties,
) -> Result

ProcCreateInstance :: #type proc "system" (
	createInfo: ^InstanceCreateInfo,
	instance: ^Instance,
) -> Result

ProcDestroyInstance :: #type proc "system" (
	instance: Instance,
) -> Result

ProcResultToString :: #type proc "system" (
	instance: Instance,
	value: Result,
	buffer: [^]u8,
) -> Result

ProcStructureTypeToString :: #type proc "system" (
	instance: Instance,
	value: StructureType,
	buffer: [^]u8,
) -> Result

ProcStructureTypeToString2KHR :: #type proc "system" (
	instance: Instance,
	value: StructureType,
	buffer: [^]u8,
) -> Result

ProcGetInstanceProperties :: #type proc "system" (
	instance: Instance,
	instanceProperties: ^InstanceProperties,
) -> Result

ProcGetSystem :: #type proc "system" (
	instance: Instance,
	getInfo: ^SystemGetInfo,
	systemId: ^SystemId,
) -> Result

ProcGetSystemProperties :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	properties: ^SystemProperties,
) -> Result

ProcCreateSession :: #type proc "system" (
	instance: Instance,
	createInfo: ^SessionCreateInfo,
	session: ^Session,
) -> Result

ProcDestroySession :: #type proc "system" (
	session: Session,
) -> Result

ProcDestroySpace :: #type proc "system" (
	space: Space,
) -> Result

ProcEnumerateSwapchainFormats :: #type proc "system" (
	session: Session,
	formatCapacityInput: u32,
	formatCountOutput: ^u32,
	formats: ^i64,
) -> Result

ProcCreateSwapchain :: #type proc "system" (
	session: Session,
	createInfo: ^SwapchainCreateInfo,
	swapchain: ^Swapchain,
) -> Result

ProcDestroySwapchain :: #type proc "system" (
	swapchain: Swapchain,
) -> Result

ProcEnumerateSwapchainImages :: #type proc "system" (
	swapchain: Swapchain,
	imageCapacityInput: u32,
	imageCountOutput: ^u32,
	images: ^SwapchainImageBaseHeader,
) -> Result

ProcAcquireSwapchainImage :: #type proc "system" (
	swapchain: Swapchain,
	acquireInfo: ^SwapchainImageAcquireInfo,
	index: ^u32,
) -> Result

ProcWaitSwapchainImage :: #type proc "system" (
	swapchain: Swapchain,
	waitInfo: ^SwapchainImageWaitInfo,
) -> Result

ProcReleaseSwapchainImage :: #type proc "system" (
	swapchain: Swapchain,
	releaseInfo: ^SwapchainImageReleaseInfo,
) -> Result

ProcBeginSession :: #type proc "system" (
	session: Session,
	beginInfo: ^SessionBeginInfo,
) -> Result

ProcEndSession :: #type proc "system" (
	session: Session,
) -> Result

ProcRequestExitSession :: #type proc "system" (
	session: Session,
) -> Result

ProcEnumerateReferenceSpaces :: #type proc "system" (
	session: Session,
	spaceCapacityInput: u32,
	spaceCountOutput: ^u32,
	spaces: ^ReferenceSpaceType,
) -> Result

ProcCreateReferenceSpace :: #type proc "system" (
	session: Session,
	createInfo: ^ReferenceSpaceCreateInfo,
	space: ^Space,
) -> Result

ProcCreateActionSpace :: #type proc "system" (
	session: Session,
	createInfo: ^ActionSpaceCreateInfo,
	space: ^Space,
) -> Result

ProcLocateSpace :: #type proc "system" (
	space: Space,
	baseSpace: Space,
	time: Time,
	location: ^SpaceLocation,
) -> Result

ProcEnumerateViewConfigurations :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationTypeCapacityInput: u32,
	viewConfigurationTypeCountOutput: ^u32,
	viewConfigurationTypes: ^ViewConfigurationType,
) -> Result

ProcEnumerateEnvironmentBlendModes :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	environmentBlendModeCapacityInput: u32,
	environmentBlendModeCountOutput: ^u32,
	environmentBlendModes: ^EnvironmentBlendMode,
) -> Result

ProcGetViewConfigurationProperties :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	configurationProperties: ^ViewConfigurationProperties,
) -> Result

ProcEnumerateViewConfigurationViews :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	viewCapacityInput: u32,
	viewCountOutput: ^u32,
	views: ^ViewConfigurationView,
) -> Result

ProcBeginFrame :: #type proc "system" (
	session: Session,
	frameBeginInfo: ^FrameBeginInfo,
) -> Result

ProcLocateViews :: #type proc "system" (
	session: Session,
	viewLocateInfo: ^ViewLocateInfo,
	viewState: ^ViewState,
	viewCapacityInput: u32,
	viewCountOutput: ^u32,
	views: ^View,
) -> Result

ProcEndFrame :: #type proc "system" (
	session: Session,
	frameEndInfo: ^FrameEndInfo,
) -> Result

ProcWaitFrame :: #type proc "system" (
	session: Session,
	frameWaitInfo: ^FrameWaitInfo,
	frameState: ^FrameState,
) -> Result

ProcApplyHapticFeedback :: #type proc "system" (
	session: Session,
	hapticActionInfo: ^HapticActionInfo,
	hapticFeedback: ^HapticBaseHeader,
) -> Result

ProcStopHapticFeedback :: #type proc "system" (
	session: Session,
	hapticActionInfo: ^HapticActionInfo,
) -> Result

ProcPollEvent :: #type proc "system" (
	instance: Instance,
	eventData: ^EventDataBuffer,
) -> Result

ProcStringToPath :: #type proc "system" (
	instance: Instance,
	pathString: cstring,
	path: ^Path,
) -> Result

ProcPathToString :: #type proc "system" (
	instance: Instance,
	path: Path,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetReferenceSpaceBoundsRect :: #type proc "system" (
	session: Session,
	referenceSpaceType: ReferenceSpaceType,
	bounds: ^Extent2Df,
) -> Result

ProcSetAndroidApplicationThreadKHR :: #type proc "system" (
	session: Session,
	threadType: AndroidThreadTypeKHR,
	threadId: u32,
) -> Result

ProcCreateSwapchainAndroidSurfaceKHR :: #type proc "system" (
	session: Session,
	info: ^SwapchainCreateInfo,
	swapchain: ^Swapchain,
	surface: ^jobject,
) -> Result

ProcGetActionStateBoolean :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStateBoolean,
) -> Result

ProcGetActionStateFloat :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStateFloat,
) -> Result

ProcGetActionStateVector2f :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStateVector2f,
) -> Result

ProcGetActionStatePose :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStatePose,
) -> Result

ProcCreateActionSet :: #type proc "system" (
	instance: Instance,
	createInfo: ^ActionSetCreateInfo,
	actionSet: ^ActionSet,
) -> Result

ProcDestroyActionSet :: #type proc "system" (
	actionSet: ActionSet,
) -> Result

ProcCreateAction :: #type proc "system" (
	actionSet: ActionSet,
	createInfo: ^ActionCreateInfo,
	action: ^Action,
) -> Result

ProcDestroyAction :: #type proc "system" (
	action: Action,
) -> Result

ProcSuggestInteractionProfileBindings :: #type proc "system" (
	instance: Instance,
	suggestedBindings: ^InteractionProfileSuggestedBinding,
) -> Result

ProcAttachSessionActionSets :: #type proc "system" (
	session: Session,
	attachInfo: ^SessionActionSetsAttachInfo,
) -> Result

ProcGetCurrentInteractionProfile :: #type proc "system" (
	session: Session,
	topLevelUserPath: Path,
	interactionProfile: ^InteractionProfileState,
) -> Result

ProcSyncActions :: #type proc "system" (
	session: Session,
	syncInfo: ^ActionsSyncInfo,
) -> Result

ProcEnumerateBoundSourcesForAction :: #type proc "system" (
	session: Session,
	enumerateInfo: ^BoundSourcesForActionEnumerateInfo,
	sourceCapacityInput: u32,
	sourceCountOutput: ^u32,
	sources: ^Path,
) -> Result

ProcGetInputSourceLocalizedName :: #type proc "system" (
	session: Session,
	getInfo: ^InputSourceLocalizedNameGetInfo,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetVulkanInstanceExtensionsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetVulkanDeviceExtensionsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetVulkanGraphicsDeviceKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	vkInstance: vk.Instance,
	vkPhysicalDevice: ^vk.PhysicalDevice,
) -> Result

ProcGetOpenGLGraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsOpenGLKHR,
) -> Result

ProcGetOpenGLESGraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsOpenGLESKHR,
) -> Result

ProcGetVulkanGraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsVulkanKHR,
) -> Result

ProcGetD3D11GraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsD3D11KHR,
) -> Result

ProcGetD3D12GraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsD3D12KHR,
) -> Result

ProcGetMetalGraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsMetalKHR,
) -> Result

ProcPerfSettingsSetPerformanceLevelEXT :: #type proc "system" (
	session: Session,
	domain: PerfSettingsDomainEXT,
	level: PerfSettingsLevelEXT,
) -> Result

ProcThermalGetTemperatureTrendEXT :: #type proc "system" (
	session: Session,
	domain: PerfSettingsDomainEXT,
	notificationLevel: ^PerfSettingsNotificationLevelEXT,
	tempHeadroom: ^f32,
	tempSlope: ^f32,
) -> Result

ProcSetDebugUtilsObjectNameEXT :: #type proc "system" (
	instance: Instance,
	nameInfo: ^DebugUtilsObjectNameInfoEXT,
) -> Result

ProcCreateDebugUtilsMessengerEXT :: #type proc "system" (
	instance: Instance,
	createInfo: ^DebugUtilsMessengerCreateInfoEXT,
	messenger: ^DebugUtilsMessengerEXT,
) -> Result

ProcDestroyDebugUtilsMessengerEXT :: #type proc "system" (
	messenger: DebugUtilsMessengerEXT,
) -> Result

ProcSubmitDebugUtilsMessageEXT :: #type proc "system" (
	instance: Instance,
	messageSeverity: DebugUtilsMessageSeverityFlagsEXT,
	messageTypes: DebugUtilsMessageTypeFlagsEXT,
	callbackData: ^DebugUtilsMessengerCallbackDataEXT,
) -> Result

ProcSessionBeginDebugUtilsLabelRegionEXT :: #type proc "system" (
	session: Session,
	labelInfo: ^DebugUtilsLabelEXT,
) -> Result

ProcSessionEndDebugUtilsLabelRegionEXT :: #type proc "system" (
	session: Session,
) -> Result

ProcSessionInsertDebugUtilsLabelEXT :: #type proc "system" (
	session: Session,
	labelInfo: ^DebugUtilsLabelEXT,
) -> Result

ProcConvertTimeToWin32PerformanceCounterKHR :: #type proc "system" (
	instance: Instance,
	time: Time,
	performanceCounter: ^LARGE_INTEGER,
) -> Result

ProcConvertWin32PerformanceCounterToTimeKHR :: #type proc "system" (
	instance: Instance,
	performanceCounter: ^LARGE_INTEGER,
	time: ^Time,
) -> Result

ProcCreateVulkanInstanceKHR :: #type proc "system" (
	instance: Instance,
	createInfo: ^VulkanInstanceCreateInfoKHR,
	vulkanInstance: ^vk.Instance,
	vulkanResult: ^vk.Result,
) -> Result

ProcCreateVulkanDeviceKHR :: #type proc "system" (
	instance: Instance,
	createInfo: ^VulkanDeviceCreateInfoKHR,
	vulkanDevice: ^vk.Device,
	vulkanResult: ^vk.Result,
) -> Result

ProcGetVulkanGraphicsDevice2KHR :: #type proc "system" (
	instance: Instance,
	getInfo: ^VulkanGraphicsDeviceGetInfoKHR,
	vulkanPhysicalDevice: ^vk.PhysicalDevice,
) -> Result

ProcConvertTimeToTimespecTimeKHR :: #type proc "system" (
	instance: Instance,
	time: Time,
	timespecTime: ^timespec,
) -> Result

ProcConvertTimespecTimeToTimeKHR :: #type proc "system" (
	instance: Instance,
	timespecTime: ^timespec,
	time: ^Time,
) -> Result

ProcGetVisibilityMaskKHR :: #type proc "system" (
	session: Session,
	viewConfigurationType: ViewConfigurationType,
	viewIndex: u32,
	visibilityMaskType: VisibilityMaskTypeKHR,
	visibilityMask: ^VisibilityMaskKHR,
) -> Result

ProcCreateSpatialAnchorMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAnchorCreateInfoMSFT,
	anchor: ^SpatialAnchorMSFT,
) -> Result

ProcCreateSpatialAnchorSpaceMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAnchorSpaceCreateInfoMSFT,
	space: ^Space,
) -> Result

ProcDestroySpatialAnchorMSFT :: #type proc "system" (
	anchor: SpatialAnchorMSFT,
) -> Result

ProcSetInputDeviceActiveEXT :: #type proc "system" (
	session: Session,
	interactionProfile: Path,
	topLevelPath: Path,
	isActive: b32,
) -> Result

ProcSetInputDeviceStateBoolEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	state: b32,
) -> Result

ProcSetInputDeviceStateFloatEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	state: f32,
) -> Result

ProcSetInputDeviceStateVector2fEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	state: Vector2f,
) -> Result

ProcSetInputDeviceLocationEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	space: Space,
	pose: Posef,
) -> Result

ProcInitializeLoaderKHR :: #type proc "system" (
	loaderInitInfo: ^LoaderInitInfoBaseHeaderKHR,
) -> Result

ProcCreateSpatialGraphNodeSpaceMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialGraphNodeSpaceCreateInfoMSFT,
	space: ^Space,
) -> Result

ProcTryCreateSpatialGraphStaticNodeBindingMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialGraphStaticNodeBindingCreateInfoMSFT,
	nodeBinding: ^SpatialGraphNodeBindingMSFT,
) -> Result

ProcDestroySpatialGraphNodeBindingMSFT :: #type proc "system" (
	nodeBinding: SpatialGraphNodeBindingMSFT,
) -> Result

ProcGetSpatialGraphNodeBindingPropertiesMSFT :: #type proc "system" (
	nodeBinding: SpatialGraphNodeBindingMSFT,
	getInfo: ^SpatialGraphNodeBindingPropertiesGetInfoMSFT,
	properties: ^SpatialGraphNodeBindingPropertiesMSFT,
) -> Result

ProcCreateHandTrackerEXT :: #type proc "system" (
	session: Session,
	createInfo: ^HandTrackerCreateInfoEXT,
	handTracker: ^HandTrackerEXT,
) -> Result

ProcDestroyHandTrackerEXT :: #type proc "system" (
	handTracker: HandTrackerEXT,
) -> Result

ProcLocateHandJointsEXT :: #type proc "system" (
	handTracker: HandTrackerEXT,
	locateInfo: ^HandJointsLocateInfoEXT,
	locations: ^HandJointLocationsEXT,
) -> Result

ProcCreateFaceTrackerFB :: #type proc "system" (
	session: Session,
	createInfo: ^FaceTrackerCreateInfoFB,
	faceTracker: ^FaceTrackerFB,
) -> Result

ProcDestroyFaceTrackerFB :: #type proc "system" (
	faceTracker: FaceTrackerFB,
) -> Result

ProcGetFaceExpressionWeightsFB :: #type proc "system" (
	faceTracker: FaceTrackerFB,
	expressionInfo: ^FaceExpressionInfoFB,
	expressionWeights: ^FaceExpressionWeightsFB,
) -> Result

ProcCreateFaceTracker2FB :: #type proc "system" (
	session: Session,
	createInfo: ^FaceTrackerCreateInfo2FB,
	faceTracker: ^FaceTracker2FB,
) -> Result

ProcDestroyFaceTracker2FB :: #type proc "system" (
	faceTracker: FaceTracker2FB,
) -> Result

ProcGetFaceExpressionWeights2FB :: #type proc "system" (
	faceTracker: FaceTracker2FB,
	expressionInfo: ^FaceExpressionInfo2FB,
	expressionWeights: ^FaceExpressionWeights2FB,
) -> Result

ProcCreateBodyTrackerFB :: #type proc "system" (
	session: Session,
	createInfo: ^BodyTrackerCreateInfoFB,
	bodyTracker: ^BodyTrackerFB,
) -> Result

ProcDestroyBodyTrackerFB :: #type proc "system" (
	bodyTracker: BodyTrackerFB,
) -> Result

ProcLocateBodyJointsFB :: #type proc "system" (
	bodyTracker: BodyTrackerFB,
	locateInfo: ^BodyJointsLocateInfoFB,
	locations: ^BodyJointLocationsFB,
) -> Result

ProcGetBodySkeletonFB :: #type proc "system" (
	bodyTracker: BodyTrackerFB,
	skeleton: ^BodySkeletonFB,
) -> Result

ProcSuggestBodyTrackingCalibrationOverrideMETA :: #type proc "system" (
	bodyTracker: BodyTrackerFB,
	calibrationInfo: ^BodyTrackingCalibrationInfoMETA,
) -> Result

ProcResetBodyTrackingCalibrationMETA :: #type proc "system" (
	bodyTracker: BodyTrackerFB,
) -> Result

ProcCreateEyeTrackerFB :: #type proc "system" (
	session: Session,
	createInfo: ^EyeTrackerCreateInfoFB,
	eyeTracker: ^EyeTrackerFB,
) -> Result

ProcDestroyEyeTrackerFB :: #type proc "system" (
	eyeTracker: EyeTrackerFB,
) -> Result

ProcGetEyeGazesFB :: #type proc "system" (
	eyeTracker: EyeTrackerFB,
	gazeInfo: ^EyeGazesInfoFB,
	eyeGazes: ^EyeGazesFB,
) -> Result

ProcCreateHandMeshSpaceMSFT :: #type proc "system" (
	handTracker: HandTrackerEXT,
	createInfo: ^HandMeshSpaceCreateInfoMSFT,
	space: ^Space,
) -> Result

ProcUpdateHandMeshMSFT :: #type proc "system" (
	handTracker: HandTrackerEXT,
	updateInfo: ^HandMeshUpdateInfoMSFT,
	handMesh: ^HandMeshMSFT,
) -> Result

ProcGetControllerModelKeyMSFT :: #type proc "system" (
	session: Session,
	topLevelUserPath: Path,
	controllerModelKeyState: ^ControllerModelKeyStateMSFT,
) -> Result

ProcLoadControllerModelMSFT :: #type proc "system" (
	session: Session,
	modelKey: ControllerModelKeyMSFT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^u8,
) -> Result

ProcGetControllerModelPropertiesMSFT :: #type proc "system" (
	session: Session,
	modelKey: ControllerModelKeyMSFT,
	properties: ^ControllerModelPropertiesMSFT,
) -> Result

ProcGetControllerModelStateMSFT :: #type proc "system" (
	session: Session,
	modelKey: ControllerModelKeyMSFT,
	state: ^ControllerModelStateMSFT,
) -> Result

ProcEnumerateSceneComputeFeaturesMSFT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	featureCapacityInput: u32,
	featureCountOutput: ^u32,
	features: ^SceneComputeFeatureMSFT,
) -> Result

ProcCreateSceneObserverMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SceneObserverCreateInfoMSFT,
	sceneObserver: ^SceneObserverMSFT,
) -> Result

ProcDestroySceneObserverMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
) -> Result

ProcCreateSceneMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	createInfo: ^SceneCreateInfoMSFT,
	scene: ^SceneMSFT,
) -> Result

ProcDestroySceneMSFT :: #type proc "system" (
	scene: SceneMSFT,
) -> Result

ProcComputeNewSceneMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	computeInfo: ^NewSceneComputeInfoMSFT,
) -> Result

ProcGetSceneComputeStateMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	state: ^SceneComputeStateMSFT,
) -> Result

ProcGetSceneComponentsMSFT :: #type proc "system" (
	scene: SceneMSFT,
	getInfo: ^SceneComponentsGetInfoMSFT,
	components: ^SceneComponentsMSFT,
) -> Result

ProcLocateSceneComponentsMSFT :: #type proc "system" (
	scene: SceneMSFT,
	locateInfo: ^SceneComponentsLocateInfoMSFT,
	locations: ^SceneComponentLocationsMSFT,
) -> Result

ProcGetSceneMeshBuffersMSFT :: #type proc "system" (
	scene: SceneMSFT,
	getInfo: ^SceneMeshBuffersGetInfoMSFT,
	buffers: ^SceneMeshBuffersMSFT,
) -> Result

ProcDeserializeSceneMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	deserializeInfo: ^SceneDeserializeInfoMSFT,
) -> Result

ProcGetSerializedSceneFragmentDataMSFT :: #type proc "system" (
	scene: SceneMSFT,
	getInfo: ^SerializedSceneFragmentDataGetInfoMSFT,
	countInput: u32,
	readOutput: ^u32,
	buffer: ^u8,
) -> Result

ProcGetSceneMarkerRawDataMSFT :: #type proc "system" (
	scene: SceneMSFT,
	markerId: ^UuidMSFT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^u8,
) -> Result

ProcGetSceneMarkerDecodedStringMSFT :: #type proc "system" (
	scene: SceneMSFT,
	markerId: ^UuidMSFT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcEnumerateDisplayRefreshRatesFB :: #type proc "system" (
	session: Session,
	displayRefreshRateCapacityInput: u32,
	displayRefreshRateCountOutput: ^u32,
	displayRefreshRates: ^f32,
) -> Result

ProcGetDisplayRefreshRateFB :: #type proc "system" (
	session: Session,
	displayRefreshRate: ^f32,
) -> Result

ProcRequestDisplayRefreshRateFB :: #type proc "system" (
	session: Session,
	displayRefreshRate: f32,
) -> Result

ProcCreateSpatialAnchorFromPerceptionAnchorMSFT :: #type proc "system" (
	session: Session,
	perceptionAnchor: ^IUnknown,
	anchor: ^SpatialAnchorMSFT,
) -> Result

ProcTryGetPerceptionAnchorFromSpatialAnchorMSFT :: #type proc "system" (
	session: Session,
	anchor: SpatialAnchorMSFT,
	perceptionAnchor: ^^IUnknown,
) -> Result

ProcUpdateSwapchainFB :: #type proc "system" (
	swapchain: Swapchain,
	state: ^SwapchainStateBaseHeaderFB,
) -> Result

ProcGetSwapchainStateFB :: #type proc "system" (
	swapchain: Swapchain,
	state: ^SwapchainStateBaseHeaderFB,
) -> Result

ProcEnumerateColorSpacesFB :: #type proc "system" (
	session: Session,
	colorSpaceCapacityInput: u32,
	colorSpaceCountOutput: ^u32,
	colorSpaces: ^ColorSpaceFB,
) -> Result

ProcSetColorSpaceFB :: #type proc "system" (
	session: Session,
	colorSpace: ColorSpaceFB,
) -> Result

ProcCreateFoveationProfileFB :: #type proc "system" (
	session: Session,
	createInfo: ^FoveationProfileCreateInfoFB,
	profile: ^FoveationProfileFB,
) -> Result

ProcDestroyFoveationProfileFB :: #type proc "system" (
	profile: FoveationProfileFB,
) -> Result

ProcGetFoveationEyeTrackedStateMETA :: #type proc "system" (
	session: Session,
	foveationState: ^FoveationEyeTrackedStateMETA,
) -> Result

ProcGetHandMeshFB :: #type proc "system" (
	handTracker: HandTrackerEXT,
	mesh: ^HandTrackingMeshFB,
) -> Result

ProcEnumerateRenderModelPathsFB :: #type proc "system" (
	session: Session,
	pathCapacityInput: u32,
	pathCountOutput: ^u32,
	paths: ^RenderModelPathInfoFB,
) -> Result

ProcGetRenderModelPropertiesFB :: #type proc "system" (
	session: Session,
	path: Path,
	properties: ^RenderModelPropertiesFB,
) -> Result

ProcLoadRenderModelFB :: #type proc "system" (
	session: Session,
	info: ^RenderModelLoadInfoFB,
	buffer: ^RenderModelBufferFB,
) -> Result

ProcQuerySystemTrackedKeyboardFB :: #type proc "system" (
	session: Session,
	queryInfo: ^KeyboardTrackingQueryFB,
	keyboard: ^KeyboardTrackingDescriptionFB,
) -> Result

ProcCreateKeyboardSpaceFB :: #type proc "system" (
	session: Session,
	createInfo: ^KeyboardSpaceCreateInfoFB,
	keyboardSpace: ^Space,
) -> Result

ProcSetEnvironmentDepthEstimationVARJO :: #type proc "system" (
	session: Session,
	enabled: b32,
) -> Result

ProcEnumerateReprojectionModesMSFT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	modeCapacityInput: u32,
	modeCountOutput: ^u32,
	modes: ^ReprojectionModeMSFT,
) -> Result

ProcGetAudioOutputDeviceGuidOculus :: #type proc "system" (
	instance: Instance,
	buffer: [^]wchar_t,
) -> Result

ProcGetAudioInputDeviceGuidOculus :: #type proc "system" (
	instance: Instance,
	buffer: [^]wchar_t,
) -> Result

ProcCreateSpatialAnchorFB :: #type proc "system" (
	session: Session,
	info: ^SpatialAnchorCreateInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcGetSpaceUuidFB :: #type proc "system" (
	space: Space,
	uuid: ^UuidEXT,
) -> Result

ProcEnumerateSpaceSupportedComponentsFB :: #type proc "system" (
	space: Space,
	componentTypeCapacityInput: u32,
	componentTypeCountOutput: ^u32,
	componentTypes: ^SpaceComponentTypeFB,
) -> Result

ProcSetSpaceComponentStatusFB :: #type proc "system" (
	space: Space,
	info: ^SpaceComponentStatusSetInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcGetSpaceComponentStatusFB :: #type proc "system" (
	space: Space,
	componentType: SpaceComponentTypeFB,
	status: ^SpaceComponentStatusFB,
) -> Result

ProcCreateTriangleMeshFB :: #type proc "system" (
	session: Session,
	createInfo: ^TriangleMeshCreateInfoFB,
	outTriangleMesh: ^TriangleMeshFB,
) -> Result

ProcDestroyTriangleMeshFB :: #type proc "system" (
	mesh: TriangleMeshFB,
) -> Result

ProcTriangleMeshGetVertexBufferFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	outVertexBuffer: ^^Vector3f,
) -> Result

ProcTriangleMeshGetIndexBufferFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	outIndexBuffer: ^^u32,
) -> Result

ProcTriangleMeshBeginUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
) -> Result

ProcTriangleMeshEndUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	vertexCount: u32,
	triangleCount: u32,
) -> Result

ProcTriangleMeshBeginVertexBufferUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	outVertexCount: ^u32,
) -> Result

ProcTriangleMeshEndVertexBufferUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
) -> Result

ProcCreatePassthroughFB :: #type proc "system" (
	session: Session,
	createInfo: ^PassthroughCreateInfoFB,
	outPassthrough: ^PassthroughFB,
) -> Result

ProcDestroyPassthroughFB :: #type proc "system" (
	passthrough: PassthroughFB,
) -> Result

ProcPassthroughStartFB :: #type proc "system" (
	passthrough: PassthroughFB,
) -> Result

ProcPassthroughPauseFB :: #type proc "system" (
	passthrough: PassthroughFB,
) -> Result

ProcCreatePassthroughLayerFB :: #type proc "system" (
	session: Session,
	createInfo: ^PassthroughLayerCreateInfoFB,
	outLayer: ^PassthroughLayerFB,
) -> Result

ProcDestroyPassthroughLayerFB :: #type proc "system" (
	layer: PassthroughLayerFB,
) -> Result

ProcPassthroughLayerPauseFB :: #type proc "system" (
	layer: PassthroughLayerFB,
) -> Result

ProcPassthroughLayerResumeFB :: #type proc "system" (
	layer: PassthroughLayerFB,
) -> Result

ProcPassthroughLayerSetStyleFB :: #type proc "system" (
	layer: PassthroughLayerFB,
	style: ^PassthroughStyleFB,
) -> Result

ProcCreateGeometryInstanceFB :: #type proc "system" (
	session: Session,
	createInfo: ^GeometryInstanceCreateInfoFB,
	outGeometryInstance: ^GeometryInstanceFB,
) -> Result

ProcDestroyGeometryInstanceFB :: #type proc "system" (
	instance: GeometryInstanceFB,
) -> Result

ProcGeometryInstanceSetTransformFB :: #type proc "system" (
	instance: GeometryInstanceFB,
	transformation: ^GeometryInstanceTransformFB,
) -> Result

ProcQuerySpacesFB :: #type proc "system" (
	session: Session,
	info: ^SpaceQueryInfoBaseHeaderFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcRetrieveSpaceQueryResultsFB :: #type proc "system" (
	session: Session,
	requestId: AsyncRequestIdFB,
	results: ^SpaceQueryResultsFB,
) -> Result

ProcSaveSpaceFB :: #type proc "system" (
	session: Session,
	info: ^SpaceSaveInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcEraseSpaceFB :: #type proc "system" (
	session: Session,
	info: ^SpaceEraseInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcSaveSpaceListFB :: #type proc "system" (
	session: Session,
	info: ^SpaceListSaveInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcShareSpacesFB :: #type proc "system" (
	session: Session,
	info: ^SpaceShareInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcGetSpaceContainerFB :: #type proc "system" (
	session: Session,
	space: Space,
	spaceContainerOutput: ^SpaceContainerFB,
) -> Result

ProcGetSpaceTriangleMeshMETA :: #type proc "system" (
	space: Space,
	getInfo: ^SpaceTriangleMeshGetInfoMETA,
	triangleMeshOutput: ^SpaceTriangleMeshMETA,
) -> Result

ProcGetSpaceRoomMeshMETA :: #type proc "system" (
	space: Space,
	getInfo: ^SpaceRoomMeshGetInfoMETA,
	roomMeshOutput: ^RoomMeshMETA,
) -> Result

ProcGetSpaceRoomMeshFaceIndicesMETA :: #type proc "system" (
	space: Space,
	faceUuid: ^Uuid,
	roomMeshFaceIndicesOutput: ^RoomMeshFaceIndicesMETA,
) -> Result

ProcRequestBoundaryVisibilityMETA :: #type proc "system" (
	session: Session,
	boundaryVisibility: BoundaryVisibilityMETA,
) -> Result

ProcGetSpaceBoundingBox2DFB :: #type proc "system" (
	session: Session,
	space: Space,
	boundingBox2DOutput: ^Rect2Df,
) -> Result

ProcGetSpaceBoundingBox3DFB :: #type proc "system" (
	session: Session,
	space: Space,
	boundingBox3DOutput: ^Rect3DfFB,
) -> Result

ProcGetSpaceSemanticLabelsFB :: #type proc "system" (
	session: Session,
	space: Space,
	semanticLabelsOutput: ^SemanticLabelsFB,
) -> Result

ProcGetSpaceBoundary2DFB :: #type proc "system" (
	session: Session,
	space: Space,
	boundary2DOutput: ^Boundary2DFB,
) -> Result

ProcGetSpaceRoomLayoutFB :: #type proc "system" (
	session: Session,
	space: Space,
	roomLayoutOutput: ^RoomLayoutFB,
) -> Result

ProcRequestSceneCaptureFB :: #type proc "system" (
	session: Session,
	info: ^SceneCaptureRequestInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcPassthroughLayerSetKeyboardHandsIntensityFB :: #type proc "system" (
	layer: PassthroughLayerFB,
	intensity: ^PassthroughKeyboardHandsIntensityFB,
) -> Result

ProcStartColocationDiscoveryMETA :: #type proc "system" (
	session: Session,
	info: ^ColocationDiscoveryStartInfoMETA,
	discoveryRequestId: ^AsyncRequestIdFB,
) -> Result

ProcStopColocationDiscoveryMETA :: #type proc "system" (
	session: Session,
	info: ^ColocationDiscoveryStopInfoMETA,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcStartColocationAdvertisementMETA :: #type proc "system" (
	session: Session,
	info: ^ColocationAdvertisementStartInfoMETA,
	advertisementRequestId: ^AsyncRequestIdFB,
) -> Result

ProcStopColocationAdvertisementMETA :: #type proc "system" (
	session: Session,
	info: ^ColocationAdvertisementStopInfoMETA,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcShareSpacesMETA :: #type proc "system" (
	session: Session,
	info: ^ShareSpacesInfoMETA,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcCreateSpatialAnchorStoreConnectionMSFT :: #type proc "system" (
	session: Session,
	spatialAnchorStore: ^SpatialAnchorStoreConnectionMSFT,
) -> Result

ProcDestroySpatialAnchorStoreConnectionMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
) -> Result

ProcPersistSpatialAnchorMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorPersistenceInfo: ^SpatialAnchorPersistenceInfoMSFT,
) -> Result

ProcEnumeratePersistedSpatialAnchorNamesMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorNameCapacityInput: u32,
	spatialAnchorNameCountOutput: ^u32,
	spatialAnchorNames: ^SpatialAnchorPersistenceNameMSFT,
) -> Result

ProcCreateSpatialAnchorFromPersistedNameMSFT :: #type proc "system" (
	session: Session,
	spatialAnchorCreateInfo: ^SpatialAnchorFromPersistedAnchorCreateInfoMSFT,
	spatialAnchor: ^SpatialAnchorMSFT,
) -> Result

ProcUnpersistSpatialAnchorMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorPersistenceName: ^SpatialAnchorPersistenceNameMSFT,
) -> Result

ProcClearSpatialAnchorStoreMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
) -> Result

ProcCreateBodyTrackerBD :: #type proc "system" (
	session: Session,
	createInfo: ^BodyTrackerCreateInfoBD,
	bodyTracker: ^BodyTrackerBD,
) -> Result

ProcDestroyBodyTrackerBD :: #type proc "system" (
	bodyTracker: BodyTrackerBD,
) -> Result

ProcLocateBodyJointsBD :: #type proc "system" (
	bodyTracker: BodyTrackerBD,
	locateInfo: ^BodyJointsLocateInfoBD,
	locations: ^BodyJointLocationsBD,
) -> Result

ProcCreateFacialTrackerHTC :: #type proc "system" (
	session: Session,
	createInfo: ^FacialTrackerCreateInfoHTC,
	facialTracker: ^FacialTrackerHTC,
) -> Result

ProcDestroyFacialTrackerHTC :: #type proc "system" (
	facialTracker: FacialTrackerHTC,
) -> Result

ProcGetFacialExpressionsHTC :: #type proc "system" (
	facialTracker: FacialTrackerHTC,
	facialExpressions: ^FacialExpressionsHTC,
) -> Result

ProcCreatePassthroughHTC :: #type proc "system" (
	session: Session,
	createInfo: ^PassthroughCreateInfoHTC,
	passthrough: ^PassthroughHTC,
) -> Result

ProcDestroyPassthroughHTC :: #type proc "system" (
	passthrough: PassthroughHTC,
) -> Result

ProcCreateSpatialAnchorHTC :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAnchorCreateInfoHTC,
	anchor: ^Space,
) -> Result

ProcGetSpatialAnchorNameHTC :: #type proc "system" (
	anchor: Space,
	name: ^SpatialAnchorNameHTC,
) -> Result

ProcEnumerateViveTrackerPathsHTCX :: #type proc "system" (
	instance: Instance,
	pathCapacityInput: u32,
	pathCountOutput: ^u32,
	paths: ^ViveTrackerPathsHTCX,
) -> Result

ProcCreateBodyTrackerHTC :: #type proc "system" (
	session: Session,
	createInfo: ^BodyTrackerCreateInfoHTC,
	bodyTracker: ^BodyTrackerHTC,
) -> Result

ProcDestroyBodyTrackerHTC :: #type proc "system" (
	bodyTracker: BodyTrackerHTC,
) -> Result

ProcLocateBodyJointsHTC :: #type proc "system" (
	bodyTracker: BodyTrackerHTC,
	locateInfo: ^BodyJointsLocateInfoHTC,
	locations: ^BodyJointLocationsHTC,
) -> Result

ProcGetBodySkeletonHTC :: #type proc "system" (
	bodyTracker: BodyTrackerHTC,
	baseSpace: Space,
	skeletonGenerationId: u32,
	skeleton: ^BodySkeletonHTC,
) -> Result

ProcSetMarkerTrackingVARJO :: #type proc "system" (
	session: Session,
	enabled: b32,
) -> Result

ProcSetMarkerTrackingTimeoutVARJO :: #type proc "system" (
	session: Session,
	markerId: u64,
	timeout: Duration,
) -> Result

ProcSetMarkerTrackingPredictionVARJO :: #type proc "system" (
	session: Session,
	markerId: u64,
	enable: b32,
) -> Result

ProcGetMarkerSizeVARJO :: #type proc "system" (
	session: Session,
	markerId: u64,
	size: ^Extent2Df,
) -> Result

ProcCreateMarkerSpaceVARJO :: #type proc "system" (
	session: Session,
	createInfo: ^MarkerSpaceCreateInfoVARJO,
	space: ^Space,
) -> Result

ProcRequestBodyTrackingFidelityMETA :: #type proc "system" (
	bodyTracker: BodyTrackerFB,
	fidelity: BodyTrackingFidelityMETA,
) -> Result

ProcSetDigitalLensControlALMALENCE :: #type proc "system" (
	session: Session,
	digitalLensControl: ^DigitalLensControlALMALENCE,
) -> Result

ProcSetViewOffsetVARJO :: #type proc "system" (
	session: Session,
	offset: f32,
) -> Result

ProcEnumerateExternalCamerasOCULUS :: #type proc "system" (
	session: Session,
	cameraCapacityInput: u32,
	cameraCountOutput: ^u32,
	cameras: ^ExternalCameraOCULUS,
) -> Result

ProcCreatePassthroughColorLutMETA :: #type proc "system" (
	passthrough: PassthroughFB,
	createInfo: ^PassthroughColorLutCreateInfoMETA,
	colorLut: ^PassthroughColorLutMETA,
) -> Result

ProcDestroyPassthroughColorLutMETA :: #type proc "system" (
	colorLut: PassthroughColorLutMETA,
) -> Result

ProcUpdatePassthroughColorLutMETA :: #type proc "system" (
	colorLut: PassthroughColorLutMETA,
	updateInfo: ^PassthroughColorLutUpdateInfoMETA,
) -> Result

ProcEnumeratePerformanceMetricsCounterPathsMETA :: #type proc "system" (
	instance: Instance,
	counterPathCapacityInput: u32,
	counterPathCountOutput: ^u32,
	counterPaths: ^Path,
) -> Result

ProcSetPerformanceMetricsStateMETA :: #type proc "system" (
	session: Session,
	state: ^PerformanceMetricsStateMETA,
) -> Result

ProcGetPerformanceMetricsStateMETA :: #type proc "system" (
	session: Session,
	state: ^PerformanceMetricsStateMETA,
) -> Result

ProcQueryPerformanceMetricsCounterMETA :: #type proc "system" (
	session: Session,
	counterPath: Path,
	counter: ^PerformanceMetricsCounterMETA,
) -> Result

ProcGetPassthroughPreferencesMETA :: #type proc "system" (
	session: Session,
	preferences: ^PassthroughPreferencesMETA,
) -> Result

ProcApplyFoveationHTC :: #type proc "system" (
	session: Session,
	applyInfo: ^FoveationApplyInfoHTC,
) -> Result

ProcCreateSpaceFromCoordinateFrameUIDML :: #type proc "system" (
	session: Session,
	createInfo: ^CoordinateSpaceCreateInfoML,
	space: ^Space,
) -> Result

ProcGetDeviceSampleRateFB :: #type proc "system" (
	session: Session,
	hapticActionInfo: ^HapticActionInfo,
	deviceSampleRate: ^DevicePcmSampleRateGetInfoFB,
) -> Result

ProcSetTrackingOptimizationSettingsHintQCOM :: #type proc "system" (
	session: Session,
	domain: TrackingOptimizationSettingsDomainQCOM,
	hint: TrackingOptimizationSettingsHintQCOM,
) -> Result

ProcCreateSpaceUserFB :: #type proc "system" (
	session: Session,
	info: ^SpaceUserCreateInfoFB,
	user: ^SpaceUserFB,
) -> Result

ProcGetSpaceUserIdFB :: #type proc "system" (
	user: SpaceUserFB,
	userId: ^SpaceUserIdFB,
) -> Result

ProcDestroySpaceUserFB :: #type proc "system" (
	user: SpaceUserFB,
) -> Result

ProcGetRecommendedLayerResolutionMETA :: #type proc "system" (
	session: Session,
	info: ^RecommendedLayerResolutionGetInfoMETA,
	resolution: ^RecommendedLayerResolutionMETA,
) -> Result

ProcSaveSpacesMETA :: #type proc "system" (
	session: Session,
	info: ^SpacesSaveInfoMETA,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcEraseSpacesMETA :: #type proc "system" (
	session: Session,
	info: ^SpacesEraseInfoMETA,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcDiscoverSpacesMETA :: #type proc "system" (
	session: Session,
	info: ^SpaceDiscoveryInfoMETA,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcRetrieveSpaceDiscoveryResultsMETA :: #type proc "system" (
	session: Session,
	requestId: AsyncRequestIdFB,
	results: ^SpaceDiscoveryResultsMETA,
) -> Result

ProcApplyForceFeedbackCurlMNDX :: #type proc "system" (
	handTracker: HandTrackerEXT,
	locations: ^ForceFeedbackCurlApplyLocationsMNDX,
) -> Result

ProcCreateFaceTrackerANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^FaceTrackerCreateInfoANDROID,
	faceTracker: ^FaceTrackerANDROID,
) -> Result

ProcDestroyFaceTrackerANDROID :: #type proc "system" (
	faceTracker: FaceTrackerANDROID,
) -> Result

ProcGetFaceStateANDROID :: #type proc "system" (
	faceTracker: FaceTrackerANDROID,
	getInfo: ^FaceStateGetInfoANDROID,
	faceStateOutput: ^FaceStateANDROID,
) -> Result

ProcGetFaceCalibrationStateANDROID :: #type proc "system" (
	faceTracker: FaceTrackerANDROID,
	faceIsCalibratedOutput: ^b32,
) -> Result

ProcGetPassthroughCameraStateANDROID :: #type proc "system" (
	session: Session,
	getInfo: ^PassthroughCameraStateGetInfoANDROID,
	cameraStateOutput: ^PassthroughCameraStateANDROID,
) -> Result

ProcEnumerateSupportedTrackableTypesANDROID :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	trackableTypeCapacityInput: u32,
	trackableTypeCountOutput: ^u32,
	trackableTypes: ^TrackableTypeANDROID,
) -> Result

ProcEnumerateSupportedAnchorTrackableTypesANDROID :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	trackableTypeCapacityInput: u32,
	trackableTypeCountOutput: ^u32,
	trackableTypes: ^TrackableTypeANDROID,
) -> Result

ProcCreateTrackableTrackerANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^TrackableTrackerCreateInfoANDROID,
	trackableTracker: ^TrackableTrackerANDROID,
) -> Result

ProcDestroyTrackableTrackerANDROID :: #type proc "system" (
	trackableTracker: TrackableTrackerANDROID,
) -> Result

ProcGetAllTrackablesANDROID :: #type proc "system" (
	trackableTracker: TrackableTrackerANDROID,
	trackableCapacityInput: u32,
	trackableCountOutput: ^u32,
	trackables: ^TrackableANDROID,
) -> Result

ProcGetTrackablePlaneANDROID :: #type proc "system" (
	trackableTracker: TrackableTrackerANDROID,
	getInfo: ^TrackableGetInfoANDROID,
	planeOutput: ^TrackablePlaneANDROID,
) -> Result

ProcCreateAnchorSpaceANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^AnchorSpaceCreateInfoANDROID,
	anchorOutput: ^Space,
) -> Result

ProcShareAnchorANDROID :: #type proc "system" (
	session: Session,
	sharingInfo: ^AnchorSharingInfoANDROID,
	anchorToken: ^AnchorSharingTokenANDROID,
) -> Result

ProcUnshareAnchorANDROID :: #type proc "system" (
	session: Session,
	anchor: Space,
) -> Result

ProcGetTrackableObjectANDROID :: #type proc "system" (
	tracker: TrackableTrackerANDROID,
	getInfo: ^TrackableGetInfoANDROID,
	objectOutput: ^TrackableObjectANDROID,
) -> Result

ProcEnumerateRaycastSupportedTrackableTypesANDROID :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	trackableTypeCapacityInput: u32,
	trackableTypeCountOutput: ^u32,
	trackableTypes: ^TrackableTypeANDROID,
) -> Result

ProcRaycastANDROID :: #type proc "system" (
	session: Session,
	rayInfo: ^RaycastInfoANDROID,
	results: ^RaycastHitResultsANDROID,
) -> Result

ProcGetTrackableMarkerANDROID :: #type proc "system" (
	tracker: TrackableTrackerANDROID,
	getInfo: ^TrackableGetInfoANDROID,
	markerOutput: ^TrackableMarkerANDROID,
) -> Result

ProcEnumerateSupportedPersistenceAnchorTypesANDROID :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	trackableTypeCapacityInput: u32,
	trackableTypeCountOutput: ^u32,
	trackableTypes: ^TrackableTypeANDROID,
) -> Result

ProcCreateDeviceAnchorPersistenceANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^DeviceAnchorPersistenceCreateInfoANDROID,
	outHandle: ^DeviceAnchorPersistenceANDROID,
) -> Result

ProcDestroyDeviceAnchorPersistenceANDROID :: #type proc "system" (
	handle: DeviceAnchorPersistenceANDROID,
) -> Result

ProcPersistAnchorANDROID :: #type proc "system" (
	handle: DeviceAnchorPersistenceANDROID,
	persistedInfo: ^PersistedAnchorSpaceInfoANDROID,
	anchorIdOutput: ^UuidEXT,
) -> Result

ProcGetAnchorPersistStateANDROID :: #type proc "system" (
	handle: DeviceAnchorPersistenceANDROID,
	anchorId: ^UuidEXT,
	persistState: ^AnchorPersistStateANDROID,
) -> Result

ProcCreatePersistedAnchorSpaceANDROID :: #type proc "system" (
	handle: DeviceAnchorPersistenceANDROID,
	createInfo: ^PersistedAnchorSpaceCreateInfoANDROID,
	anchorOutput: ^Space,
) -> Result

ProcEnumeratePersistedAnchorsANDROID :: #type proc "system" (
	handle: DeviceAnchorPersistenceANDROID,
	anchorIdCapacityInput: u32,
	anchorIdCountOutput: ^u32,
	anchorIds: ^UuidEXT,
) -> Result

ProcUnpersistAnchorANDROID :: #type proc "system" (
	handle: DeviceAnchorPersistenceANDROID,
	anchorId: ^UuidEXT,
) -> Result

ProcEnumeratePerformanceMetricsCounterPathsANDROID :: #type proc "system" (
	instance: Instance,
	counterPathCapacityInput: u32,
	counterPathCountOutput: ^u32,
	counterPaths: ^Path,
) -> Result

ProcSetPerformanceMetricsStateANDROID :: #type proc "system" (
	session: Session,
	state: ^PerformanceMetricsStateANDROID,
) -> Result

ProcGetPerformanceMetricsStateANDROID :: #type proc "system" (
	session: Session,
	state: ^PerformanceMetricsStateANDROID,
) -> Result

ProcQueryPerformanceMetricsCounterANDROID :: #type proc "system" (
	session: Session,
	counterPath: Path,
	counter: ^PerformanceMetricsCounterANDROID,
) -> Result

ProcGetTrackableQrCodeANDROID :: #type proc "system" (
	tracker: TrackableTrackerANDROID,
	getInfo: ^TrackableGetInfoANDROID,
	qrCodeOutput: ^TrackableQrCodeANDROID,
) -> Result

ProcCreatePassthroughLayerANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^PassthroughLayerCreateInfoANDROID,
	layer: ^PassthroughLayerANDROID,
) -> Result

ProcDestroyPassthroughLayerANDROID :: #type proc "system" (
	layer: PassthroughLayerANDROID,
) -> Result

ProcSetPassthroughLayerMeshANDROID :: #type proc "system" (
	layer: PassthroughLayerANDROID,
	mesh: ^PassthroughLayerMeshANDROID,
) -> Result

ProcEnumerateSupportedSemanticLabelSetsANDROID :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	supportedSemanticLabelSetsInputCapacity: u32,
	supportedSemanticLabelSetsOutputCount: ^u32,
	supportedSemanticLabelSets: ^SceneMeshSemanticLabelSetANDROID,
) -> Result

ProcCreateSceneMeshingTrackerANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^SceneMeshingTrackerCreateInfoANDROID,
	tracker: ^SceneMeshingTrackerANDROID,
) -> Result

ProcDestroySceneMeshingTrackerANDROID :: #type proc "system" (
	tracker: SceneMeshingTrackerANDROID,
) -> Result

ProcCreateSceneMeshSnapshotANDROID :: #type proc "system" (
	tracker: SceneMeshingTrackerANDROID,
	createInfo: ^SceneMeshSnapshotCreateInfoANDROID,
	outSnapshotCreationResult: ^SceneMeshSnapshotCreationResultANDROID,
) -> Result

ProcDestroySceneMeshSnapshotANDROID :: #type proc "system" (
	snapshot: SceneMeshSnapshotANDROID,
) -> Result

ProcGetAllSubmeshStatesANDROID :: #type proc "system" (
	snapshot: SceneMeshSnapshotANDROID,
	submeshStateCapacityInput: u32,
	submeshStateCountOutput: ^u32,
	submeshStates: ^SceneSubmeshStateANDROID,
) -> Result

ProcGetSubmeshDataANDROID :: #type proc "system" (
	snapshot: SceneMeshSnapshotANDROID,
	submeshDataCount: u32,
	inoutSubmeshData: ^SceneSubmeshDataANDROID,
) -> Result

ProcCreateEyeTrackerANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^EyeTrackerCreateInfoANDROID,
	eyeTracker: ^EyeTrackerANDROID,
) -> Result

ProcDestroyEyeTrackerANDROID :: #type proc "system" (
	eyeTracker: EyeTrackerANDROID,
) -> Result

ProcGetCoarseTrackingEyesInfoANDROID :: #type proc "system" (
	eyeTracker: EyeTrackerANDROID,
	getInfo: ^EyesGetInfoANDROID,
	eyesOutput: ^EyesANDROID,
) -> Result

ProcGetFineTrackingEyesInfoANDROID :: #type proc "system" (
	eyeTracker: EyeTrackerANDROID,
	getInfo: ^EyesGetInfoANDROID,
	eyesOutput: ^EyesANDROID,
) -> Result

ProcCreateLightEstimatorANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^LightEstimatorCreateInfoANDROID,
	outHandle: ^LightEstimatorANDROID,
) -> Result

ProcDestroyLightEstimatorANDROID :: #type proc "system" (
	estimator: LightEstimatorANDROID,
) -> Result

ProcGetLightEstimateANDROID :: #type proc "system" (
	estimator: LightEstimatorANDROID,
	input: ^LightEstimateGetInfoANDROID,
	output: ^LightEstimateANDROID,
) -> Result

ProcCreatePlaneDetectorEXT :: #type proc "system" (
	session: Session,
	createInfo: ^PlaneDetectorCreateInfoEXT,
	planeDetector: ^PlaneDetectorEXT,
) -> Result

ProcDestroyPlaneDetectorEXT :: #type proc "system" (
	planeDetector: PlaneDetectorEXT,
) -> Result

ProcBeginPlaneDetectionEXT :: #type proc "system" (
	planeDetector: PlaneDetectorEXT,
	beginInfo: ^PlaneDetectorBeginInfoEXT,
) -> Result

ProcGetPlaneDetectionStateEXT :: #type proc "system" (
	planeDetector: PlaneDetectorEXT,
	state: ^PlaneDetectionStateEXT,
) -> Result

ProcGetPlaneDetectionsEXT :: #type proc "system" (
	planeDetector: PlaneDetectorEXT,
	info: ^PlaneDetectorGetInfoEXT,
	locations: ^PlaneDetectorLocationsEXT,
) -> Result

ProcGetPlanePolygonBufferEXT :: #type proc "system" (
	planeDetector: PlaneDetectorEXT,
	planeId: u64,
	polygonBufferIndex: u32,
	polygonBuffer: ^PlaneDetectorPolygonBufferEXT,
) -> Result

ProcCreateVirtualKeyboardMETA :: #type proc "system" (
	session: Session,
	createInfo: ^VirtualKeyboardCreateInfoMETA,
	keyboard: ^VirtualKeyboardMETA,
) -> Result

ProcDestroyVirtualKeyboardMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
) -> Result

ProcCreateVirtualKeyboardSpaceMETA :: #type proc "system" (
	session: Session,
	keyboard: VirtualKeyboardMETA,
	createInfo: ^VirtualKeyboardSpaceCreateInfoMETA,
	keyboardSpace: ^Space,
) -> Result

ProcSuggestVirtualKeyboardLocationMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	locationInfo: ^VirtualKeyboardLocationInfoMETA,
) -> Result

ProcGetVirtualKeyboardScaleMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	scale: ^f32,
) -> Result

ProcSetVirtualKeyboardModelVisibilityMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	modelVisibility: ^VirtualKeyboardModelVisibilitySetInfoMETA,
) -> Result

ProcGetVirtualKeyboardModelAnimationStatesMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	animationStates: ^VirtualKeyboardModelAnimationStatesMETA,
) -> Result

ProcGetVirtualKeyboardDirtyTexturesMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	textureIdCapacityInput: u32,
	textureIdCountOutput: ^u32,
	textureIds: ^u64,
) -> Result

ProcGetVirtualKeyboardTextureDataMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	textureId: u64,
	textureData: ^VirtualKeyboardTextureDataMETA,
) -> Result

ProcSendVirtualKeyboardInputMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	info: ^VirtualKeyboardInputInfoMETA,
	interactorRootPose: ^Posef,
) -> Result

ProcChangeVirtualKeyboardTextContextMETA :: #type proc "system" (
	keyboard: VirtualKeyboardMETA,
	changeInfo: ^VirtualKeyboardTextContextChangeInfoMETA,
) -> Result

ProcEnableUserCalibrationEventsML :: #type proc "system" (
	instance: Instance,
	enableInfo: ^UserCalibrationEnableEventsInfoML,
) -> Result

ProcEnableLocalizationEventsML :: #type proc "system" (
	session: Session,
	info: ^LocalizationEnableEventsInfoML,
) -> Result

ProcQueryLocalizationMapsML :: #type proc "system" (
	session: Session,
	queryInfo: ^LocalizationMapQueryInfoBaseHeaderML,
	mapCapacityInput: u32,
	mapCountOutput: ^u32,
	maps: ^LocalizationMapML,
) -> Result

ProcRequestMapLocalizationML :: #type proc "system" (
	session: Session,
	requestInfo: ^MapLocalizationRequestInfoML,
) -> Result

ProcImportLocalizationMapML :: #type proc "system" (
	session: Session,
	importInfo: ^LocalizationMapImportInfoML,
	mapUuid: ^UuidEXT,
) -> Result

ProcCreateExportedLocalizationMapML :: #type proc "system" (
	session: Session,
	mapUuid: ^UuidEXT,
	_map: ^ExportedLocalizationMapML,
) -> Result

ProcDestroyExportedLocalizationMapML :: #type proc "system" (
	_map: ExportedLocalizationMapML,
) -> Result

ProcGetExportedLocalizationMapDataML :: #type proc "system" (
	_map: ExportedLocalizationMapML,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcCreateMarkerDetectorML :: #type proc "system" (
	session: Session,
	createInfo: ^MarkerDetectorCreateInfoML,
	markerDetector: ^MarkerDetectorML,
) -> Result

ProcDestroyMarkerDetectorML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
) -> Result

ProcSnapshotMarkerDetectorML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
	snapshotInfo: ^MarkerDetectorSnapshotInfoML,
) -> Result

ProcGetMarkerDetectorStateML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
	state: ^MarkerDetectorStateML,
) -> Result

ProcGetMarkersML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
	markerCapacityInput: u32,
	markerCountOutput: ^u32,
	markers: ^MarkerML,
) -> Result

ProcGetMarkerReprojectionErrorML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
	marker: MarkerML,
	reprojectionErrorMeters: ^f32,
) -> Result

ProcGetMarkerLengthML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
	marker: MarkerML,
	meters: ^f32,
) -> Result

ProcGetMarkerNumberML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
	marker: MarkerML,
	number: ^u64,
) -> Result

ProcGetMarkerStringML :: #type proc "system" (
	markerDetector: MarkerDetectorML,
	marker: MarkerML,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcCreateMarkerSpaceML :: #type proc "system" (
	session: Session,
	createInfo: ^MarkerSpaceCreateInfoML,
	space: ^Space,
) -> Result

ProcPollFutureEXT :: #type proc "system" (
	instance: Instance,
	pollInfo: ^FuturePollInfoEXT,
	pollResult: ^FuturePollResultEXT,
) -> Result

ProcCancelFutureEXT :: #type proc "system" (
	instance: Instance,
	cancelInfo: ^FutureCancelInfoEXT,
) -> Result

ProcCreateEnvironmentDepthProviderMETA :: #type proc "system" (
	session: Session,
	createInfo: ^EnvironmentDepthProviderCreateInfoMETA,
	environmentDepthProvider: ^EnvironmentDepthProviderMETA,
) -> Result

ProcDestroyEnvironmentDepthProviderMETA :: #type proc "system" (
	environmentDepthProvider: EnvironmentDepthProviderMETA,
) -> Result

ProcStartEnvironmentDepthProviderMETA :: #type proc "system" (
	environmentDepthProvider: EnvironmentDepthProviderMETA,
) -> Result

ProcStopEnvironmentDepthProviderMETA :: #type proc "system" (
	environmentDepthProvider: EnvironmentDepthProviderMETA,
) -> Result

ProcCreateEnvironmentDepthSwapchainMETA :: #type proc "system" (
	environmentDepthProvider: EnvironmentDepthProviderMETA,
	createInfo: ^EnvironmentDepthSwapchainCreateInfoMETA,
	swapchain: ^EnvironmentDepthSwapchainMETA,
) -> Result

ProcDestroyEnvironmentDepthSwapchainMETA :: #type proc "system" (
	swapchain: EnvironmentDepthSwapchainMETA,
) -> Result

ProcEnumerateEnvironmentDepthSwapchainImagesMETA :: #type proc "system" (
	swapchain: EnvironmentDepthSwapchainMETA,
	imageCapacityInput: u32,
	imageCountOutput: ^u32,
	images: ^SwapchainImageBaseHeader,
) -> Result

ProcGetEnvironmentDepthSwapchainStateMETA :: #type proc "system" (
	swapchain: EnvironmentDepthSwapchainMETA,
	state: ^EnvironmentDepthSwapchainStateMETA,
) -> Result

ProcAcquireEnvironmentDepthImageMETA :: #type proc "system" (
	environmentDepthProvider: EnvironmentDepthProviderMETA,
	acquireInfo: ^EnvironmentDepthImageAcquireInfoMETA,
	environmentDepthImage: ^EnvironmentDepthImageMETA,
) -> Result

ProcSetEnvironmentDepthHandRemovalMETA :: #type proc "system" (
	environmentDepthProvider: EnvironmentDepthProviderMETA,
	setInfo: ^EnvironmentDepthHandRemovalSetInfoMETA,
) -> Result

ProcGetStationaryReferenceSpaceGenerationIdEXT :: #type proc "system" (
	session: Session,
	getInfo: ^StationaryReferenceSpaceGenerationIdGetInfoEXT,
	generationIdResult: ^StationaryReferenceSpaceGenerationIdResultEXT,
) -> Result

ProcCreateFacialExpressionClientML :: #type proc "system" (
	session: Session,
	createInfo: ^FacialExpressionClientCreateInfoML,
	facialExpressionClient: ^FacialExpressionClientML,
) -> Result

ProcDestroyFacialExpressionClientML :: #type proc "system" (
	facialExpressionClient: FacialExpressionClientML,
) -> Result

ProcGetFacialExpressionBlendShapePropertiesML :: #type proc "system" (
	facialExpressionClient: FacialExpressionClientML,
	blendShapeGetInfo: ^FacialExpressionBlendShapeGetInfoML,
	blendShapeCount: u32,
	blendShapes: ^FacialExpressionBlendShapePropertiesML,
) -> Result

ProcLocateSpaces :: #type proc "system" (
	session: Session,
	locateInfo: ^SpacesLocateInfo,
	spaceLocations: ^SpaceLocations,
) -> Result

ProcEnumerateSpatialCapabilitiesEXT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	capabilityCapacityInput: u32,
	capabilityCountOutput: ^u32,
	capabilities: ^SpatialCapabilityEXT,
) -> Result

ProcEnumerateSpatialCapabilityComponentTypesEXT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	capability: SpatialCapabilityEXT,
	capabilityComponents: ^SpatialCapabilityComponentTypesEXT,
) -> Result

ProcEnumerateSpatialCapabilityFeaturesEXT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	capability: SpatialCapabilityEXT,
	capabilityFeatureCapacityInput: u32,
	capabilityFeatureCountOutput: ^u32,
	capabilityFeatures: ^SpatialCapabilityFeatureEXT,
) -> Result

ProcCreateSpatialContextAsyncEXT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialContextCreateInfoEXT,
	future: ^FutureEXT,
) -> Result

ProcCreateSpatialContextCompleteEXT :: #type proc "system" (
	session: Session,
	future: FutureEXT,
	completion: ^CreateSpatialContextCompletionEXT,
) -> Result

ProcDestroySpatialContextEXT :: #type proc "system" (
	spatialContext: SpatialContextEXT,
) -> Result

ProcCreateSpatialDiscoverySnapshotAsyncEXT :: #type proc "system" (
	spatialContext: SpatialContextEXT,
	createInfo: ^SpatialDiscoverySnapshotCreateInfoEXT,
	future: ^FutureEXT,
) -> Result

ProcCreateSpatialDiscoverySnapshotCompleteEXT :: #type proc "system" (
	spatialContext: SpatialContextEXT,
	createSnapshotCompletionInfo: ^CreateSpatialDiscoverySnapshotCompletionInfoEXT,
	completion: ^CreateSpatialDiscoverySnapshotCompletionEXT,
) -> Result

ProcQuerySpatialComponentDataEXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	queryCondition: ^SpatialComponentDataQueryConditionEXT,
	queryResult: ^SpatialComponentDataQueryResultEXT,
) -> Result

ProcDestroySpatialSnapshotEXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
) -> Result

ProcCreateSpatialEntityFromIdEXT :: #type proc "system" (
	spatialContext: SpatialContextEXT,
	createInfo: ^SpatialEntityFromIdCreateInfoEXT,
	spatialEntity: ^SpatialEntityEXT,
) -> Result

ProcDestroySpatialEntityEXT :: #type proc "system" (
	spatialEntity: SpatialEntityEXT,
) -> Result

ProcCreateSpatialUpdateSnapshotEXT :: #type proc "system" (
	spatialContext: SpatialContextEXT,
	createInfo: ^SpatialUpdateSnapshotCreateInfoEXT,
	snapshot: ^SpatialSnapshotEXT,
) -> Result

ProcGetSpatialBufferStringEXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	info: ^SpatialBufferGetInfoEXT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetSpatialBufferUint8EXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	info: ^SpatialBufferGetInfoEXT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^u8,
) -> Result

ProcGetSpatialBufferUint16EXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	info: ^SpatialBufferGetInfoEXT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^u16,
) -> Result

ProcGetSpatialBufferUint32EXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	info: ^SpatialBufferGetInfoEXT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^u32,
) -> Result

ProcGetSpatialBufferFloatEXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	info: ^SpatialBufferGetInfoEXT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^f32,
) -> Result

ProcGetSpatialBufferVector2fEXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	info: ^SpatialBufferGetInfoEXT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^Vector2f,
) -> Result

ProcGetSpatialBufferVector3fEXT :: #type proc "system" (
	snapshot: SpatialSnapshotEXT,
	info: ^SpatialBufferGetInfoEXT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^Vector3f,
) -> Result

ProcCreateSpatialAnchorEXT :: #type proc "system" (
	spatialContext: SpatialContextEXT,
	createInfo: ^SpatialAnchorCreateInfoEXT,
	anchorEntityId: ^SpatialEntityIdEXT,
	anchorEntity: ^SpatialEntityEXT,
) -> Result

ProcEnumerateSpatialPersistenceScopesEXT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	persistenceScopeCapacityInput: u32,
	persistenceScopeCountOutput: ^u32,
	persistenceScopes: ^SpatialPersistenceScopeEXT,
) -> Result

ProcCreateSpatialPersistenceContextAsyncEXT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialPersistenceContextCreateInfoEXT,
	future: ^FutureEXT,
) -> Result

ProcCreateSpatialPersistenceContextCompleteEXT :: #type proc "system" (
	session: Session,
	future: FutureEXT,
	completion: ^CreateSpatialPersistenceContextCompletionEXT,
) -> Result

ProcDestroySpatialPersistenceContextEXT :: #type proc "system" (
	persistenceContext: SpatialPersistenceContextEXT,
) -> Result

ProcPersistSpatialEntityAsyncEXT :: #type proc "system" (
	persistenceContext: SpatialPersistenceContextEXT,
	persistInfo: ^SpatialEntityPersistInfoEXT,
	future: ^FutureEXT,
) -> Result

ProcPersistSpatialEntityCompleteEXT :: #type proc "system" (
	persistenceContext: SpatialPersistenceContextEXT,
	future: FutureEXT,
	completion: ^PersistSpatialEntityCompletionEXT,
) -> Result

ProcUnpersistSpatialEntityAsyncEXT :: #type proc "system" (
	persistenceContext: SpatialPersistenceContextEXT,
	unpersistInfo: ^SpatialEntityUnpersistInfoEXT,
	future: ^FutureEXT,
) -> Result

ProcUnpersistSpatialEntityCompleteEXT :: #type proc "system" (
	persistenceContext: SpatialPersistenceContextEXT,
	future: FutureEXT,
	completion: ^UnpersistSpatialEntityCompletionEXT,
) -> Result

ProcSetSystemNotificationsML :: #type proc "system" (
	instance: Instance,
	info: ^SystemNotificationsSetInfoML,
) -> Result

ProcCreateSpatialAnchorsAsyncML :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAnchorsCreateInfoBaseHeaderML,
	future: ^FutureEXT,
) -> Result

ProcCreateSpatialAnchorsCompleteML :: #type proc "system" (
	session: Session,
	future: FutureEXT,
	completion: ^CreateSpatialAnchorsCompletionML,
) -> Result

ProcGetSpatialAnchorStateML :: #type proc "system" (
	anchor: Space,
	state: ^SpatialAnchorStateML,
) -> Result

ProcCreateSpatialAnchorsStorageML :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAnchorsCreateStorageInfoML,
	storage: ^SpatialAnchorsStorageML,
) -> Result

ProcDestroySpatialAnchorsStorageML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
) -> Result

ProcQuerySpatialAnchorsAsyncML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	queryInfo: ^SpatialAnchorsQueryInfoBaseHeaderML,
	future: ^FutureEXT,
) -> Result

ProcQuerySpatialAnchorsCompleteML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	future: FutureEXT,
	completion: ^SpatialAnchorsQueryCompletionML,
) -> Result

ProcPublishSpatialAnchorsAsyncML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	publishInfo: ^SpatialAnchorsPublishInfoML,
	future: ^FutureEXT,
) -> Result

ProcPublishSpatialAnchorsCompleteML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	future: FutureEXT,
	completion: ^SpatialAnchorsPublishCompletionML,
) -> Result

ProcDeleteSpatialAnchorsAsyncML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	deleteInfo: ^SpatialAnchorsDeleteInfoML,
	future: ^FutureEXT,
) -> Result

ProcDeleteSpatialAnchorsCompleteML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	future: FutureEXT,
	completion: ^SpatialAnchorsDeleteCompletionML,
) -> Result

ProcUpdateSpatialAnchorsExpirationAsyncML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	updateInfo: ^SpatialAnchorsUpdateExpirationInfoML,
	future: ^FutureEXT,
) -> Result

ProcUpdateSpatialAnchorsExpirationCompleteML :: #type proc "system" (
	storage: SpatialAnchorsStorageML,
	future: FutureEXT,
	completion: ^SpatialAnchorsUpdateExpirationCompletionML,
) -> Result

ProcCreateWorldMeshDetectorML :: #type proc "system" (
	session: Session,
	createInfo: ^WorldMeshDetectorCreateInfoML,
	detector: ^WorldMeshDetectorML,
) -> Result

ProcDestroyWorldMeshDetectorML :: #type proc "system" (
	detector: WorldMeshDetectorML,
) -> Result

ProcRequestWorldMeshStateAsyncML :: #type proc "system" (
	detector: WorldMeshDetectorML,
	stateRequest: ^WorldMeshStateRequestInfoML,
	future: ^FutureEXT,
) -> Result

ProcRequestWorldMeshStateCompleteML :: #type proc "system" (
	detector: WorldMeshDetectorML,
	future: FutureEXT,
	completion: ^WorldMeshStateRequestCompletionML,
) -> Result

ProcGetWorldMeshBufferRecommendSizeML :: #type proc "system" (
	detector: WorldMeshDetectorML,
	sizeInfo: ^WorldMeshBufferRecommendedSizeInfoML,
	size: ^WorldMeshBufferSizeML,
) -> Result

ProcAllocateWorldMeshBufferML :: #type proc "system" (
	detector: WorldMeshDetectorML,
	size: ^WorldMeshBufferSizeML,
	buffer: ^WorldMeshBufferML,
) -> Result

ProcFreeWorldMeshBufferML :: #type proc "system" (
	detector: WorldMeshDetectorML,
	buffer: ^WorldMeshBufferML,
) -> Result

ProcRequestWorldMeshAsyncML :: #type proc "system" (
	detector: WorldMeshDetectorML,
	getInfo: ^WorldMeshGetInfoML,
	buffer: ^WorldMeshBufferML,
	future: ^FutureEXT,
) -> Result

ProcRequestWorldMeshCompleteML :: #type proc "system" (
	detector: WorldMeshDetectorML,
	completionInfo: ^WorldMeshRequestCompletionInfoML,
	future: FutureEXT,
	completion: ^WorldMeshRequestCompletionML,
) -> Result

ProcCreateRenderModelEXT :: #type proc "system" (
	session: Session,
	createInfo: ^RenderModelCreateInfoEXT,
	renderModel: ^RenderModelEXT,
) -> Result

ProcDestroyRenderModelEXT :: #type proc "system" (
	renderModel: RenderModelEXT,
) -> Result

ProcGetRenderModelPropertiesEXT :: #type proc "system" (
	renderModel: RenderModelEXT,
	getInfo: ^RenderModelPropertiesGetInfoEXT,
	properties: ^RenderModelPropertiesEXT,
) -> Result

ProcCreateRenderModelSpaceEXT :: #type proc "system" (
	session: Session,
	createInfo: ^RenderModelSpaceCreateInfoEXT,
	space: ^Space,
) -> Result

ProcCreateRenderModelAssetEXT :: #type proc "system" (
	session: Session,
	createInfo: ^RenderModelAssetCreateInfoEXT,
	asset: ^RenderModelAssetEXT,
) -> Result

ProcDestroyRenderModelAssetEXT :: #type proc "system" (
	asset: RenderModelAssetEXT,
) -> Result

ProcGetRenderModelAssetDataEXT :: #type proc "system" (
	asset: RenderModelAssetEXT,
	getInfo: ^RenderModelAssetDataGetInfoEXT,
	buffer: ^RenderModelAssetDataEXT,
) -> Result

ProcGetRenderModelAssetPropertiesEXT :: #type proc "system" (
	asset: RenderModelAssetEXT,
	getInfo: ^RenderModelAssetPropertiesGetInfoEXT,
	properties: ^RenderModelAssetPropertiesEXT,
) -> Result

ProcGetRenderModelStateEXT :: #type proc "system" (
	renderModel: RenderModelEXT,
	getInfo: ^RenderModelStateGetInfoEXT,
	state: ^RenderModelStateEXT,
) -> Result

ProcEnumerateInteractionRenderModelIdsEXT :: #type proc "system" (
	session: Session,
	getInfo: ^InteractionRenderModelIdsEnumerateInfoEXT,
	renderModelIdCapacityInput: u32,
	renderModelIdCountOutput: ^u32,
	renderModelIds: ^RenderModelIdEXT,
) -> Result

ProcEnumerateRenderModelSubactionPathsEXT :: #type proc "system" (
	renderModel: RenderModelEXT,
	info: ^InteractionRenderModelSubactionPathInfoEXT,
	pathCapacityInput: u32,
	pathCountOutput: ^u32,
	paths: ^Path,
) -> Result

ProcGetRenderModelPoseTopLevelUserPathEXT :: #type proc "system" (
	renderModel: RenderModelEXT,
	info: ^InteractionRenderModelTopLevelUserPathGetInfoEXT,
	topLevelUserPath: ^Path,
) -> Result

ProcEnumerateSupportedAudioSampleRateBD :: #type proc "system" (
	session: Session,
	sampleRateCapacityInput: u32,
	sampleRateCountOutput: ^u32,
	sampleRates: ^AudioSampleRateBD,
) -> Result

ProcQueryFramesPerBufferRangeBD :: #type proc "system" (
	session: Session,
	sampleRate: AudioSampleRateBD,
	min: ^u32,
	max: ^u32,
) -> Result

ProcCreateSpatialAudioRendererBD :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAudioRendererCreateInfoBD,
	renderer: ^SpatialAudioRendererBD,
) -> Result

ProcDestroySpatialAudioRendererBD :: #type proc "system" (
	renderer: SpatialAudioRendererBD,
) -> Result

ProcCreateSoundObstacleMaterialBD :: #type proc "system" (
	renderer: SpatialAudioRendererBD,
	config: ^SoundObstacleMaterialConfigBD,
	material: ^SoundObstacleMaterialBD,
) -> Result

ProcUpdateSoundObstacleMaterialConfigBD :: #type proc "system" (
	material: SoundObstacleMaterialBD,
	config: ^SoundObstacleMaterialConfigBD,
) -> Result

ProcDestroySoundObstacleMaterialBD :: #type proc "system" (
	material: SoundObstacleMaterialBD,
) -> Result

ProcCreateSoundObstacleBD :: #type proc "system" (
	renderer: SpatialAudioRendererBD,
	config: ^SoundObstacleConfigBD,
	mesh: ^SoundTriangleMeshBD,
	soundObstacle: ^SoundObstacleBD,
) -> Result

ProcUpdateSoundObstacleConfigBD :: #type proc "system" (
	soundObstacle: SoundObstacleBD,
	config: ^SoundObstacleConfigBD,
	mesh: ^SoundTriangleMeshBD,
	flags: SoundObstacleFlagsBD,
) -> Result

ProcDestroySoundObstacleBD :: #type proc "system" (
	soundObstacle: SoundObstacleBD,
) -> Result

ProcCreateSoundObjectBD :: #type proc "system" (
	renderer: SpatialAudioRendererBD,
	config: ^SoundObjectConfigBD,
	soundObject: ^SoundObjectBD,
) -> Result

ProcUpdateSoundObjectConfigBD :: #type proc "system" (
	soundObject: SoundObjectBD,
	config: ^SoundObjectConfigBD,
	flags: SoundObjectFlagsBD,
) -> Result

ProcSubmitSoundObjectBufferBD :: #type proc "system" (
	soundObject: SoundObjectBD,
	buffer: ^AudioBufferBD,
) -> Result

ProcDestroySoundObjectBD :: #type proc "system" (
	soundObject: SoundObjectBD,
) -> Result

ProcCreateSoundFieldBD :: #type proc "system" (
	renderer: SpatialAudioRendererBD,
	config: ^SoundFieldConfigBD,
	soundField: ^SoundFieldBD,
) -> Result

ProcUpdateSoundFieldConfigBD :: #type proc "system" (
	soundField: SoundFieldBD,
	config: ^SoundFieldConfigBD,
	flags: SoundFieldFlagsBD,
) -> Result

ProcSubmitSoundFieldBufferBD :: #type proc "system" (
	soundField: SoundFieldBD,
	buffer: ^AudioBufferBD,
) -> Result

ProcDestroySoundFieldBD :: #type proc "system" (
	soundField: SoundFieldBD,
) -> Result

ProcWaitAudioPeriodBD :: #type proc "system" (
	renderer: SpatialAudioRendererBD,
	timeout: Duration,
) -> Result

ProcEndAudioPeriodBD :: #type proc "system" (
	renderer: SpatialAudioRendererBD,
) -> Result

ProcGetSpatialEntityUuidBD :: #type proc "system" (
	snapshot: SenseDataSnapshotBD,
	entityId: SpatialEntityIdBD,
	uuid: ^UuidEXT,
) -> Result

ProcEnumerateSpatialEntityComponentTypesBD :: #type proc "system" (
	snapshot: SenseDataSnapshotBD,
	entityId: SpatialEntityIdBD,
	componentTypeCapacityInput: u32,
	componentTypeCountOutput: ^u32,
	componentTypes: ^SpatialEntityComponentTypeBD,
) -> Result

ProcGetSpatialEntityComponentDataBD :: #type proc "system" (
	snapshot: SenseDataSnapshotBD,
	getInfo: ^SpatialEntityComponentGetInfoBD,
	componentData: ^SpatialEntityComponentDataBaseHeaderBD,
) -> Result

ProcCreateSenseDataProviderBD :: #type proc "system" (
	session: Session,
	createInfo: ^SenseDataProviderCreateInfoBD,
	provider: ^SenseDataProviderBD,
) -> Result

ProcStartSenseDataProviderAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	startInfo: ^SenseDataProviderStartInfoBD,
	future: ^FutureEXT,
) -> Result

ProcStartSenseDataProviderCompleteBD :: #type proc "system" (
	session: Session,
	future: FutureEXT,
	completion: ^FutureCompletionEXT,
) -> Result

ProcGetSenseDataProviderStateBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	state: ^SenseDataProviderStateBD,
) -> Result

ProcQuerySenseDataAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	queryInfo: ^SenseDataQueryInfoBD,
	future: ^FutureEXT,
) -> Result

ProcQuerySenseDataCompleteBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	future: FutureEXT,
	completion: ^SenseDataQueryCompletionBD,
) -> Result

ProcDestroySenseDataSnapshotBD :: #type proc "system" (
	snapshot: SenseDataSnapshotBD,
) -> Result

ProcGetQueriedSenseDataBD :: #type proc "system" (
	snapshot: SenseDataSnapshotBD,
	getInfo: ^QueriedSenseDataGetInfoBD,
	queriedSenseData: ^QueriedSenseDataBD,
) -> Result

ProcStopSenseDataProviderBD :: #type proc "system" (
	provider: SenseDataProviderBD,
) -> Result

ProcDestroySenseDataProviderBD :: #type proc "system" (
	provider: SenseDataProviderBD,
) -> Result

ProcCreateSpatialEntityAnchorBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	createInfo: ^SpatialEntityAnchorCreateInfoBD,
	anchor: ^AnchorBD,
) -> Result

ProcDestroyAnchorBD :: #type proc "system" (
	anchor: AnchorBD,
) -> Result

ProcGetAnchorUuidBD :: #type proc "system" (
	anchor: AnchorBD,
	uuid: ^UuidEXT,
) -> Result

ProcCreateAnchorSpaceBD :: #type proc "system" (
	session: Session,
	createInfo: ^AnchorSpaceCreateInfoBD,
	space: ^Space,
) -> Result

ProcCreateSpatialAnchorAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	info: ^SpatialAnchorCreateInfoBD,
	future: ^FutureEXT,
) -> Result

ProcCreateSpatialAnchorCompleteBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	future: FutureEXT,
	completion: ^SpatialAnchorCreateCompletionBD,
) -> Result

ProcPersistSpatialAnchorAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	info: ^SpatialAnchorPersistInfoBD,
	future: ^FutureEXT,
) -> Result

ProcPersistSpatialAnchorCompleteBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	future: FutureEXT,
	completion: ^FutureCompletionEXT,
) -> Result

ProcUnpersistSpatialAnchorAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	info: ^SpatialAnchorUnpersistInfoBD,
	future: ^FutureEXT,
) -> Result

ProcUnpersistSpatialAnchorCompleteBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	future: FutureEXT,
	completion: ^FutureCompletionEXT,
) -> Result

ProcShareSpatialAnchorAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	info: ^SpatialAnchorShareInfoBD,
	future: ^FutureEXT,
) -> Result

ProcShareSpatialAnchorCompleteBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	future: FutureEXT,
	completion: ^FutureCompletionEXT,
) -> Result

ProcDownloadSharedSpatialAnchorAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	info: ^SharedSpatialAnchorDownloadInfoBD,
	future: ^FutureEXT,
) -> Result

ProcDownloadSharedSpatialAnchorCompleteBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	future: FutureEXT,
	completion: ^FutureCompletionEXT,
) -> Result

ProcCaptureSceneAsyncBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	info: ^SceneCaptureInfoBD,
	future: ^FutureEXT,
) -> Result

ProcCaptureSceneCompleteBD :: #type proc "system" (
	provider: SenseDataProviderBD,
	future: FutureEXT,
	completion: ^FutureCompletionEXT,
) -> Result

ProcResumeSimultaneousHandsAndControllersTrackingMETA :: #type proc "system" (
	session: Session,
	resumeInfo: ^SimultaneousHandsAndControllersTrackingResumeInfoMETA,
) -> Result

ProcPauseSimultaneousHandsAndControllersTrackingMETA :: #type proc "system" (
	session: Session,
	pauseInfo: ^SimultaneousHandsAndControllersTrackingPauseInfoMETA,
) -> Result

ProcEnumerateFacialSimulationModesBD :: #type proc "system" (
	session: Session,
	modeCapacityInput: u32,
	modeCountOutput: ^u32,
	modes: ^FacialSimulationModeBD,
) -> Result

ProcCreateFaceTrackerBD :: #type proc "system" (
	session: Session,
	createInfo: ^FaceTrackerCreateInfoBD,
	tracker: ^FaceTrackerBD,
) -> Result

ProcDestroyFaceTrackerBD :: #type proc "system" (
	tracker: FaceTrackerBD,
) -> Result

ProcGetFacialSimulationDataBD :: #type proc "system" (
	tracker: FaceTrackerBD,
	info: ^FacialSimulationDataGetInfoBD,
	facialData: ^FacialSimulationDataBD,
) -> Result

ProcSetFacialSimulationModeBD :: #type proc "system" (
	tracker: FaceTrackerBD,
	mode: FacialSimulationModeBD,
) -> Result

ProcGetFacialSimulationModeBD :: #type proc "system" (
	tracker: FaceTrackerBD,
	mode: ^FacialSimulationModeBD,
) -> Result

ProcCreateTrackableImageDatabaseAsyncANDROID :: #type proc "system" (
	session: Session,
	createInfo: ^TrackableImageDatabaseCreateInfoANDROID,
	future: ^FutureEXT,
) -> Result

ProcCreateTrackableImageDatabaseCompleteANDROID :: #type proc "system" (
	session: Session,
	future: FutureEXT,
	completion: ^CreateTrackableImageDatabaseCompletionANDROID,
) -> Result

ProcDestroyTrackableImageDatabaseANDROID :: #type proc "system" (
	database: TrackableImageDatabaseANDROID,
) -> Result

ProcAddTrackableImageDatabaseANDROID :: #type proc "system" (
	tracker: TrackableTrackerANDROID,
	database: TrackableImageDatabaseANDROID,
) -> Result

ProcRemoveTrackableImageDatabaseANDROID :: #type proc "system" (
	tracker: TrackableTrackerANDROID,
	database: TrackableImageDatabaseANDROID,
) -> Result

ProcGetTrackableImageANDROID :: #type proc "system" (
	tracker: TrackableTrackerANDROID,
	getInfo: ^TrackableGetInfoANDROID,
	trackable: ^TrackableImageANDROID,
) -> Result

ProcEnumerateSpatialAnchorAttachableComponentsANDROID :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	attachableComponentCapacityInput: u32,
	attachableComponentCountOutput: ^u32,
	attachableComponents: ^SpatialComponentTypeEXT,
) -> Result

ProcCreateSpatialAnchorSpaceANDROID :: #type proc "system" (
	session: Session,
	spatialContext: SpatialContextEXT,
	createInfo: ^SpatialAnchorCreateInfoEXT,
	anchorEntityId: ^SpatialEntityIdEXT,
	anchorSpace: ^Space,
) -> Result

ProcCreateSpatialAnchorSpaceFromIdANDROID :: #type proc "system" (
	session: Session,
	spatialContext: SpatialContextEXT,
	createInfo: ^SpatialAnchorSpaceFromIdCreateInfoANDROID,
	anchorSpace: ^Space,
) -> Result

ProcSetTilePropertiesHintMETA :: #type proc "system" (
	session: Session,
	properties: ^TilePropertiesHintMETA,
) -> Result

ProcCreateEnvironmentRaycasterAsyncMETA :: #type proc "system" (
	session: Session,
	info: ^EnvironmentRaycasterCreateInfoMETA,
	future: ^FutureEXT,
) -> Result

ProcCreateEnvironmentRaycasterCompleteMETA :: #type proc "system" (
	session: Session,
	future: FutureEXT,
	completion: ^EnvironmentRaycasterCreateCompletionMETA,
) -> Result

ProcDestroyEnvironmentRaycasterMETA :: #type proc "system" (
	environmentRaycaster: EnvironmentRaycasterMETA,
) -> Result

ProcPerformEnvironmentRaycastMETA :: #type proc "system" (
	environmentRaycaster: EnvironmentRaycasterMETA,
	info: ^EnvironmentRaycastHitGetInfoMETA,
	hitPoint: ^EnvironmentRaycastHitMETA,
) -> Result

ProcCreateSpatialRaycastSnapshotANDROID :: #type proc "system" (
	spatialContext: SpatialContextEXT,
	createInfo: ^SpatialRaycastSnapshotCreateInfoANDROID,
	snapshot: ^SpatialSnapshotEXT,
) -> Result

ProcGetHandGestureQCOM :: #type proc "system" (
	handTracker: HandTrackerEXT,
	time: Time,
	handGesture: ^HandGestureQCOM,
) -> Result

ProcHapticParametricGetPropertiesEXT :: #type proc "system" (
	session: Session,
	hapticActionInfo: ^HapticActionInfo,
	parametricProperties: ^HapticParametricPropertiesEXT,
) -> Result



EnumerateApiLayerProperties: ProcEnumerateApiLayerProperties
EnumerateInstanceExtensionProperties: ProcEnumerateInstanceExtensionProperties
CreateInstance: ProcCreateInstance
DestroyInstance: ProcDestroyInstance
ResultToString: ProcResultToString
StructureTypeToString: ProcStructureTypeToString
StructureTypeToString2KHR: ProcStructureTypeToString2KHR
GetInstanceProperties: ProcGetInstanceProperties
GetSystem: ProcGetSystem
GetSystemProperties: ProcGetSystemProperties
CreateSession: ProcCreateSession
DestroySession: ProcDestroySession
DestroySpace: ProcDestroySpace
EnumerateSwapchainFormats: ProcEnumerateSwapchainFormats
CreateSwapchain: ProcCreateSwapchain
DestroySwapchain: ProcDestroySwapchain
EnumerateSwapchainImages: ProcEnumerateSwapchainImages
AcquireSwapchainImage: ProcAcquireSwapchainImage
WaitSwapchainImage: ProcWaitSwapchainImage
ReleaseSwapchainImage: ProcReleaseSwapchainImage
BeginSession: ProcBeginSession
EndSession: ProcEndSession
RequestExitSession: ProcRequestExitSession
EnumerateReferenceSpaces: ProcEnumerateReferenceSpaces
CreateReferenceSpace: ProcCreateReferenceSpace
CreateActionSpace: ProcCreateActionSpace
LocateSpace: ProcLocateSpace
EnumerateViewConfigurations: ProcEnumerateViewConfigurations
EnumerateEnvironmentBlendModes: ProcEnumerateEnvironmentBlendModes
GetViewConfigurationProperties: ProcGetViewConfigurationProperties
EnumerateViewConfigurationViews: ProcEnumerateViewConfigurationViews
BeginFrame: ProcBeginFrame
LocateViews: ProcLocateViews
EndFrame: ProcEndFrame
WaitFrame: ProcWaitFrame
ApplyHapticFeedback: ProcApplyHapticFeedback
StopHapticFeedback: ProcStopHapticFeedback
PollEvent: ProcPollEvent
StringToPath: ProcStringToPath
PathToString: ProcPathToString
GetReferenceSpaceBoundsRect: ProcGetReferenceSpaceBoundsRect
SetAndroidApplicationThreadKHR: ProcSetAndroidApplicationThreadKHR
CreateSwapchainAndroidSurfaceKHR: ProcCreateSwapchainAndroidSurfaceKHR
GetActionStateBoolean: ProcGetActionStateBoolean
GetActionStateFloat: ProcGetActionStateFloat
GetActionStateVector2f: ProcGetActionStateVector2f
GetActionStatePose: ProcGetActionStatePose
CreateActionSet: ProcCreateActionSet
DestroyActionSet: ProcDestroyActionSet
CreateAction: ProcCreateAction
DestroyAction: ProcDestroyAction
SuggestInteractionProfileBindings: ProcSuggestInteractionProfileBindings
AttachSessionActionSets: ProcAttachSessionActionSets
GetCurrentInteractionProfile: ProcGetCurrentInteractionProfile
SyncActions: ProcSyncActions
EnumerateBoundSourcesForAction: ProcEnumerateBoundSourcesForAction
GetInputSourceLocalizedName: ProcGetInputSourceLocalizedName
GetVulkanInstanceExtensionsKHR: ProcGetVulkanInstanceExtensionsKHR
GetVulkanDeviceExtensionsKHR: ProcGetVulkanDeviceExtensionsKHR
GetVulkanGraphicsDeviceKHR: ProcGetVulkanGraphicsDeviceKHR
GetOpenGLGraphicsRequirementsKHR: ProcGetOpenGLGraphicsRequirementsKHR
GetOpenGLESGraphicsRequirementsKHR: ProcGetOpenGLESGraphicsRequirementsKHR
GetVulkanGraphicsRequirementsKHR: ProcGetVulkanGraphicsRequirementsKHR
GetD3D11GraphicsRequirementsKHR: ProcGetD3D11GraphicsRequirementsKHR
GetD3D12GraphicsRequirementsKHR: ProcGetD3D12GraphicsRequirementsKHR
GetMetalGraphicsRequirementsKHR: ProcGetMetalGraphicsRequirementsKHR
PerfSettingsSetPerformanceLevelEXT: ProcPerfSettingsSetPerformanceLevelEXT
ThermalGetTemperatureTrendEXT: ProcThermalGetTemperatureTrendEXT
SetDebugUtilsObjectNameEXT: ProcSetDebugUtilsObjectNameEXT
CreateDebugUtilsMessengerEXT: ProcCreateDebugUtilsMessengerEXT
DestroyDebugUtilsMessengerEXT: ProcDestroyDebugUtilsMessengerEXT
SubmitDebugUtilsMessageEXT: ProcSubmitDebugUtilsMessageEXT
SessionBeginDebugUtilsLabelRegionEXT: ProcSessionBeginDebugUtilsLabelRegionEXT
SessionEndDebugUtilsLabelRegionEXT: ProcSessionEndDebugUtilsLabelRegionEXT
SessionInsertDebugUtilsLabelEXT: ProcSessionInsertDebugUtilsLabelEXT
ConvertTimeToWin32PerformanceCounterKHR: ProcConvertTimeToWin32PerformanceCounterKHR
ConvertWin32PerformanceCounterToTimeKHR: ProcConvertWin32PerformanceCounterToTimeKHR
CreateVulkanInstanceKHR: ProcCreateVulkanInstanceKHR
CreateVulkanDeviceKHR: ProcCreateVulkanDeviceKHR
GetVulkanGraphicsDevice2KHR: ProcGetVulkanGraphicsDevice2KHR
GetVulkanGraphicsRequirements2KHR: ProcGetVulkanGraphicsRequirementsKHR
ConvertTimeToTimespecTimeKHR: ProcConvertTimeToTimespecTimeKHR
ConvertTimespecTimeToTimeKHR: ProcConvertTimespecTimeToTimeKHR
GetVisibilityMaskKHR: ProcGetVisibilityMaskKHR
CreateSpatialAnchorMSFT: ProcCreateSpatialAnchorMSFT
CreateSpatialAnchorSpaceMSFT: ProcCreateSpatialAnchorSpaceMSFT
DestroySpatialAnchorMSFT: ProcDestroySpatialAnchorMSFT
SetInputDeviceActiveEXT: ProcSetInputDeviceActiveEXT
SetInputDeviceStateBoolEXT: ProcSetInputDeviceStateBoolEXT
SetInputDeviceStateFloatEXT: ProcSetInputDeviceStateFloatEXT
SetInputDeviceStateVector2fEXT: ProcSetInputDeviceStateVector2fEXT
SetInputDeviceLocationEXT: ProcSetInputDeviceLocationEXT
InitializeLoaderKHR: ProcInitializeLoaderKHR
CreateSpatialGraphNodeSpaceMSFT: ProcCreateSpatialGraphNodeSpaceMSFT
TryCreateSpatialGraphStaticNodeBindingMSFT: ProcTryCreateSpatialGraphStaticNodeBindingMSFT
DestroySpatialGraphNodeBindingMSFT: ProcDestroySpatialGraphNodeBindingMSFT
GetSpatialGraphNodeBindingPropertiesMSFT: ProcGetSpatialGraphNodeBindingPropertiesMSFT
CreateHandTrackerEXT: ProcCreateHandTrackerEXT
DestroyHandTrackerEXT: ProcDestroyHandTrackerEXT
LocateHandJointsEXT: ProcLocateHandJointsEXT
CreateFaceTrackerFB: ProcCreateFaceTrackerFB
DestroyFaceTrackerFB: ProcDestroyFaceTrackerFB
GetFaceExpressionWeightsFB: ProcGetFaceExpressionWeightsFB
CreateFaceTracker2FB: ProcCreateFaceTracker2FB
DestroyFaceTracker2FB: ProcDestroyFaceTracker2FB
GetFaceExpressionWeights2FB: ProcGetFaceExpressionWeights2FB
CreateBodyTrackerFB: ProcCreateBodyTrackerFB
DestroyBodyTrackerFB: ProcDestroyBodyTrackerFB
LocateBodyJointsFB: ProcLocateBodyJointsFB
GetBodySkeletonFB: ProcGetBodySkeletonFB
SuggestBodyTrackingCalibrationOverrideMETA: ProcSuggestBodyTrackingCalibrationOverrideMETA
ResetBodyTrackingCalibrationMETA: ProcResetBodyTrackingCalibrationMETA
CreateEyeTrackerFB: ProcCreateEyeTrackerFB
DestroyEyeTrackerFB: ProcDestroyEyeTrackerFB
GetEyeGazesFB: ProcGetEyeGazesFB
CreateHandMeshSpaceMSFT: ProcCreateHandMeshSpaceMSFT
UpdateHandMeshMSFT: ProcUpdateHandMeshMSFT
GetControllerModelKeyMSFT: ProcGetControllerModelKeyMSFT
LoadControllerModelMSFT: ProcLoadControllerModelMSFT
GetControllerModelPropertiesMSFT: ProcGetControllerModelPropertiesMSFT
GetControllerModelStateMSFT: ProcGetControllerModelStateMSFT
EnumerateSceneComputeFeaturesMSFT: ProcEnumerateSceneComputeFeaturesMSFT
CreateSceneObserverMSFT: ProcCreateSceneObserverMSFT
DestroySceneObserverMSFT: ProcDestroySceneObserverMSFT
CreateSceneMSFT: ProcCreateSceneMSFT
DestroySceneMSFT: ProcDestroySceneMSFT
ComputeNewSceneMSFT: ProcComputeNewSceneMSFT
GetSceneComputeStateMSFT: ProcGetSceneComputeStateMSFT
GetSceneComponentsMSFT: ProcGetSceneComponentsMSFT
LocateSceneComponentsMSFT: ProcLocateSceneComponentsMSFT
GetSceneMeshBuffersMSFT: ProcGetSceneMeshBuffersMSFT
DeserializeSceneMSFT: ProcDeserializeSceneMSFT
GetSerializedSceneFragmentDataMSFT: ProcGetSerializedSceneFragmentDataMSFT
GetSceneMarkerRawDataMSFT: ProcGetSceneMarkerRawDataMSFT
GetSceneMarkerDecodedStringMSFT: ProcGetSceneMarkerDecodedStringMSFT
EnumerateDisplayRefreshRatesFB: ProcEnumerateDisplayRefreshRatesFB
GetDisplayRefreshRateFB: ProcGetDisplayRefreshRateFB
RequestDisplayRefreshRateFB: ProcRequestDisplayRefreshRateFB
CreateSpatialAnchorFromPerceptionAnchorMSFT: ProcCreateSpatialAnchorFromPerceptionAnchorMSFT
TryGetPerceptionAnchorFromSpatialAnchorMSFT: ProcTryGetPerceptionAnchorFromSpatialAnchorMSFT
UpdateSwapchainFB: ProcUpdateSwapchainFB
GetSwapchainStateFB: ProcGetSwapchainStateFB
EnumerateColorSpacesFB: ProcEnumerateColorSpacesFB
SetColorSpaceFB: ProcSetColorSpaceFB
CreateFoveationProfileFB: ProcCreateFoveationProfileFB
DestroyFoveationProfileFB: ProcDestroyFoveationProfileFB
GetFoveationEyeTrackedStateMETA: ProcGetFoveationEyeTrackedStateMETA
GetHandMeshFB: ProcGetHandMeshFB
EnumerateRenderModelPathsFB: ProcEnumerateRenderModelPathsFB
GetRenderModelPropertiesFB: ProcGetRenderModelPropertiesFB
LoadRenderModelFB: ProcLoadRenderModelFB
QuerySystemTrackedKeyboardFB: ProcQuerySystemTrackedKeyboardFB
CreateKeyboardSpaceFB: ProcCreateKeyboardSpaceFB
SetEnvironmentDepthEstimationVARJO: ProcSetEnvironmentDepthEstimationVARJO
EnumerateReprojectionModesMSFT: ProcEnumerateReprojectionModesMSFT
GetAudioOutputDeviceGuidOculus: ProcGetAudioOutputDeviceGuidOculus
GetAudioInputDeviceGuidOculus: ProcGetAudioInputDeviceGuidOculus
CreateSpatialAnchorFB: ProcCreateSpatialAnchorFB
GetSpaceUuidFB: ProcGetSpaceUuidFB
EnumerateSpaceSupportedComponentsFB: ProcEnumerateSpaceSupportedComponentsFB
SetSpaceComponentStatusFB: ProcSetSpaceComponentStatusFB
GetSpaceComponentStatusFB: ProcGetSpaceComponentStatusFB
CreateTriangleMeshFB: ProcCreateTriangleMeshFB
DestroyTriangleMeshFB: ProcDestroyTriangleMeshFB
TriangleMeshGetVertexBufferFB: ProcTriangleMeshGetVertexBufferFB
TriangleMeshGetIndexBufferFB: ProcTriangleMeshGetIndexBufferFB
TriangleMeshBeginUpdateFB: ProcTriangleMeshBeginUpdateFB
TriangleMeshEndUpdateFB: ProcTriangleMeshEndUpdateFB
TriangleMeshBeginVertexBufferUpdateFB: ProcTriangleMeshBeginVertexBufferUpdateFB
TriangleMeshEndVertexBufferUpdateFB: ProcTriangleMeshEndVertexBufferUpdateFB
CreatePassthroughFB: ProcCreatePassthroughFB
DestroyPassthroughFB: ProcDestroyPassthroughFB
PassthroughStartFB: ProcPassthroughStartFB
PassthroughPauseFB: ProcPassthroughPauseFB
CreatePassthroughLayerFB: ProcCreatePassthroughLayerFB
DestroyPassthroughLayerFB: ProcDestroyPassthroughLayerFB
PassthroughLayerPauseFB: ProcPassthroughLayerPauseFB
PassthroughLayerResumeFB: ProcPassthroughLayerResumeFB
PassthroughLayerSetStyleFB: ProcPassthroughLayerSetStyleFB
CreateGeometryInstanceFB: ProcCreateGeometryInstanceFB
DestroyGeometryInstanceFB: ProcDestroyGeometryInstanceFB
GeometryInstanceSetTransformFB: ProcGeometryInstanceSetTransformFB
QuerySpacesFB: ProcQuerySpacesFB
RetrieveSpaceQueryResultsFB: ProcRetrieveSpaceQueryResultsFB
SaveSpaceFB: ProcSaveSpaceFB
EraseSpaceFB: ProcEraseSpaceFB
SaveSpaceListFB: ProcSaveSpaceListFB
ShareSpacesFB: ProcShareSpacesFB
GetSpaceContainerFB: ProcGetSpaceContainerFB
GetSpaceTriangleMeshMETA: ProcGetSpaceTriangleMeshMETA
GetSpaceRoomMeshMETA: ProcGetSpaceRoomMeshMETA
GetSpaceRoomMeshFaceIndicesMETA: ProcGetSpaceRoomMeshFaceIndicesMETA
RequestBoundaryVisibilityMETA: ProcRequestBoundaryVisibilityMETA
GetSpaceBoundingBox2DFB: ProcGetSpaceBoundingBox2DFB
GetSpaceBoundingBox3DFB: ProcGetSpaceBoundingBox3DFB
GetSpaceSemanticLabelsFB: ProcGetSpaceSemanticLabelsFB
GetSpaceBoundary2DFB: ProcGetSpaceBoundary2DFB
GetSpaceRoomLayoutFB: ProcGetSpaceRoomLayoutFB
RequestSceneCaptureFB: ProcRequestSceneCaptureFB
PassthroughLayerSetKeyboardHandsIntensityFB: ProcPassthroughLayerSetKeyboardHandsIntensityFB
StartColocationDiscoveryMETA: ProcStartColocationDiscoveryMETA
StopColocationDiscoveryMETA: ProcStopColocationDiscoveryMETA
StartColocationAdvertisementMETA: ProcStartColocationAdvertisementMETA
StopColocationAdvertisementMETA: ProcStopColocationAdvertisementMETA
ShareSpacesMETA: ProcShareSpacesMETA
CreateSpatialAnchorStoreConnectionMSFT: ProcCreateSpatialAnchorStoreConnectionMSFT
DestroySpatialAnchorStoreConnectionMSFT: ProcDestroySpatialAnchorStoreConnectionMSFT
PersistSpatialAnchorMSFT: ProcPersistSpatialAnchorMSFT
EnumeratePersistedSpatialAnchorNamesMSFT: ProcEnumeratePersistedSpatialAnchorNamesMSFT
CreateSpatialAnchorFromPersistedNameMSFT: ProcCreateSpatialAnchorFromPersistedNameMSFT
UnpersistSpatialAnchorMSFT: ProcUnpersistSpatialAnchorMSFT
ClearSpatialAnchorStoreMSFT: ProcClearSpatialAnchorStoreMSFT
CreateBodyTrackerBD: ProcCreateBodyTrackerBD
DestroyBodyTrackerBD: ProcDestroyBodyTrackerBD
LocateBodyJointsBD: ProcLocateBodyJointsBD
CreateFacialTrackerHTC: ProcCreateFacialTrackerHTC
DestroyFacialTrackerHTC: ProcDestroyFacialTrackerHTC
GetFacialExpressionsHTC: ProcGetFacialExpressionsHTC
CreatePassthroughHTC: ProcCreatePassthroughHTC
DestroyPassthroughHTC: ProcDestroyPassthroughHTC
CreateSpatialAnchorHTC: ProcCreateSpatialAnchorHTC
GetSpatialAnchorNameHTC: ProcGetSpatialAnchorNameHTC
EnumerateViveTrackerPathsHTCX: ProcEnumerateViveTrackerPathsHTCX
CreateBodyTrackerHTC: ProcCreateBodyTrackerHTC
DestroyBodyTrackerHTC: ProcDestroyBodyTrackerHTC
LocateBodyJointsHTC: ProcLocateBodyJointsHTC
GetBodySkeletonHTC: ProcGetBodySkeletonHTC
SetMarkerTrackingVARJO: ProcSetMarkerTrackingVARJO
SetMarkerTrackingTimeoutVARJO: ProcSetMarkerTrackingTimeoutVARJO
SetMarkerTrackingPredictionVARJO: ProcSetMarkerTrackingPredictionVARJO
GetMarkerSizeVARJO: ProcGetMarkerSizeVARJO
CreateMarkerSpaceVARJO: ProcCreateMarkerSpaceVARJO
RequestBodyTrackingFidelityMETA: ProcRequestBodyTrackingFidelityMETA
SetDigitalLensControlALMALENCE: ProcSetDigitalLensControlALMALENCE
SetViewOffsetVARJO: ProcSetViewOffsetVARJO
EnumerateExternalCamerasOCULUS: ProcEnumerateExternalCamerasOCULUS
CreatePassthroughColorLutMETA: ProcCreatePassthroughColorLutMETA
DestroyPassthroughColorLutMETA: ProcDestroyPassthroughColorLutMETA
UpdatePassthroughColorLutMETA: ProcUpdatePassthroughColorLutMETA
EnumeratePerformanceMetricsCounterPathsMETA: ProcEnumeratePerformanceMetricsCounterPathsMETA
SetPerformanceMetricsStateMETA: ProcSetPerformanceMetricsStateMETA
GetPerformanceMetricsStateMETA: ProcGetPerformanceMetricsStateMETA
QueryPerformanceMetricsCounterMETA: ProcQueryPerformanceMetricsCounterMETA
GetPassthroughPreferencesMETA: ProcGetPassthroughPreferencesMETA
ApplyFoveationHTC: ProcApplyFoveationHTC
CreateSpaceFromCoordinateFrameUIDML: ProcCreateSpaceFromCoordinateFrameUIDML
GetDeviceSampleRateFB: ProcGetDeviceSampleRateFB
SetTrackingOptimizationSettingsHintQCOM: ProcSetTrackingOptimizationSettingsHintQCOM
CreateSpaceUserFB: ProcCreateSpaceUserFB
GetSpaceUserIdFB: ProcGetSpaceUserIdFB
DestroySpaceUserFB: ProcDestroySpaceUserFB
GetRecommendedLayerResolutionMETA: ProcGetRecommendedLayerResolutionMETA
SaveSpacesMETA: ProcSaveSpacesMETA
EraseSpacesMETA: ProcEraseSpacesMETA
DiscoverSpacesMETA: ProcDiscoverSpacesMETA
RetrieveSpaceDiscoveryResultsMETA: ProcRetrieveSpaceDiscoveryResultsMETA
ApplyForceFeedbackCurlMNDX: ProcApplyForceFeedbackCurlMNDX
CreateFaceTrackerANDROID: ProcCreateFaceTrackerANDROID
DestroyFaceTrackerANDROID: ProcDestroyFaceTrackerANDROID
GetFaceStateANDROID: ProcGetFaceStateANDROID
GetFaceCalibrationStateANDROID: ProcGetFaceCalibrationStateANDROID
GetPassthroughCameraStateANDROID: ProcGetPassthroughCameraStateANDROID
EnumerateSupportedTrackableTypesANDROID: ProcEnumerateSupportedTrackableTypesANDROID
EnumerateSupportedAnchorTrackableTypesANDROID: ProcEnumerateSupportedAnchorTrackableTypesANDROID
CreateTrackableTrackerANDROID: ProcCreateTrackableTrackerANDROID
DestroyTrackableTrackerANDROID: ProcDestroyTrackableTrackerANDROID
GetAllTrackablesANDROID: ProcGetAllTrackablesANDROID
GetTrackablePlaneANDROID: ProcGetTrackablePlaneANDROID
CreateAnchorSpaceANDROID: ProcCreateAnchorSpaceANDROID
ShareAnchorANDROID: ProcShareAnchorANDROID
UnshareAnchorANDROID: ProcUnshareAnchorANDROID
GetTrackableObjectANDROID: ProcGetTrackableObjectANDROID
EnumerateRaycastSupportedTrackableTypesANDROID: ProcEnumerateRaycastSupportedTrackableTypesANDROID
RaycastANDROID: ProcRaycastANDROID
GetTrackableMarkerANDROID: ProcGetTrackableMarkerANDROID
EnumerateSupportedPersistenceAnchorTypesANDROID: ProcEnumerateSupportedPersistenceAnchorTypesANDROID
CreateDeviceAnchorPersistenceANDROID: ProcCreateDeviceAnchorPersistenceANDROID
DestroyDeviceAnchorPersistenceANDROID: ProcDestroyDeviceAnchorPersistenceANDROID
PersistAnchorANDROID: ProcPersistAnchorANDROID
GetAnchorPersistStateANDROID: ProcGetAnchorPersistStateANDROID
CreatePersistedAnchorSpaceANDROID: ProcCreatePersistedAnchorSpaceANDROID
EnumeratePersistedAnchorsANDROID: ProcEnumeratePersistedAnchorsANDROID
UnpersistAnchorANDROID: ProcUnpersistAnchorANDROID
EnumeratePerformanceMetricsCounterPathsANDROID: ProcEnumeratePerformanceMetricsCounterPathsANDROID
SetPerformanceMetricsStateANDROID: ProcSetPerformanceMetricsStateANDROID
GetPerformanceMetricsStateANDROID: ProcGetPerformanceMetricsStateANDROID
QueryPerformanceMetricsCounterANDROID: ProcQueryPerformanceMetricsCounterANDROID
GetTrackableQrCodeANDROID: ProcGetTrackableQrCodeANDROID
CreatePassthroughLayerANDROID: ProcCreatePassthroughLayerANDROID
DestroyPassthroughLayerANDROID: ProcDestroyPassthroughLayerANDROID
SetPassthroughLayerMeshANDROID: ProcSetPassthroughLayerMeshANDROID
EnumerateSupportedSemanticLabelSetsANDROID: ProcEnumerateSupportedSemanticLabelSetsANDROID
CreateSceneMeshingTrackerANDROID: ProcCreateSceneMeshingTrackerANDROID
DestroySceneMeshingTrackerANDROID: ProcDestroySceneMeshingTrackerANDROID
CreateSceneMeshSnapshotANDROID: ProcCreateSceneMeshSnapshotANDROID
DestroySceneMeshSnapshotANDROID: ProcDestroySceneMeshSnapshotANDROID
GetAllSubmeshStatesANDROID: ProcGetAllSubmeshStatesANDROID
GetSubmeshDataANDROID: ProcGetSubmeshDataANDROID
CreateEyeTrackerANDROID: ProcCreateEyeTrackerANDROID
DestroyEyeTrackerANDROID: ProcDestroyEyeTrackerANDROID
GetCoarseTrackingEyesInfoANDROID: ProcGetCoarseTrackingEyesInfoANDROID
GetFineTrackingEyesInfoANDROID: ProcGetFineTrackingEyesInfoANDROID
CreateLightEstimatorANDROID: ProcCreateLightEstimatorANDROID
DestroyLightEstimatorANDROID: ProcDestroyLightEstimatorANDROID
GetLightEstimateANDROID: ProcGetLightEstimateANDROID
CreatePlaneDetectorEXT: ProcCreatePlaneDetectorEXT
DestroyPlaneDetectorEXT: ProcDestroyPlaneDetectorEXT
BeginPlaneDetectionEXT: ProcBeginPlaneDetectionEXT
GetPlaneDetectionStateEXT: ProcGetPlaneDetectionStateEXT
GetPlaneDetectionsEXT: ProcGetPlaneDetectionsEXT
GetPlanePolygonBufferEXT: ProcGetPlanePolygonBufferEXT
CreateVirtualKeyboardMETA: ProcCreateVirtualKeyboardMETA
DestroyVirtualKeyboardMETA: ProcDestroyVirtualKeyboardMETA
CreateVirtualKeyboardSpaceMETA: ProcCreateVirtualKeyboardSpaceMETA
SuggestVirtualKeyboardLocationMETA: ProcSuggestVirtualKeyboardLocationMETA
GetVirtualKeyboardScaleMETA: ProcGetVirtualKeyboardScaleMETA
SetVirtualKeyboardModelVisibilityMETA: ProcSetVirtualKeyboardModelVisibilityMETA
GetVirtualKeyboardModelAnimationStatesMETA: ProcGetVirtualKeyboardModelAnimationStatesMETA
GetVirtualKeyboardDirtyTexturesMETA: ProcGetVirtualKeyboardDirtyTexturesMETA
GetVirtualKeyboardTextureDataMETA: ProcGetVirtualKeyboardTextureDataMETA
SendVirtualKeyboardInputMETA: ProcSendVirtualKeyboardInputMETA
ChangeVirtualKeyboardTextContextMETA: ProcChangeVirtualKeyboardTextContextMETA
EnableUserCalibrationEventsML: ProcEnableUserCalibrationEventsML
EnableLocalizationEventsML: ProcEnableLocalizationEventsML
QueryLocalizationMapsML: ProcQueryLocalizationMapsML
RequestMapLocalizationML: ProcRequestMapLocalizationML
ImportLocalizationMapML: ProcImportLocalizationMapML
CreateExportedLocalizationMapML: ProcCreateExportedLocalizationMapML
DestroyExportedLocalizationMapML: ProcDestroyExportedLocalizationMapML
GetExportedLocalizationMapDataML: ProcGetExportedLocalizationMapDataML
CreateMarkerDetectorML: ProcCreateMarkerDetectorML
DestroyMarkerDetectorML: ProcDestroyMarkerDetectorML
SnapshotMarkerDetectorML: ProcSnapshotMarkerDetectorML
GetMarkerDetectorStateML: ProcGetMarkerDetectorStateML
GetMarkersML: ProcGetMarkersML
GetMarkerReprojectionErrorML: ProcGetMarkerReprojectionErrorML
GetMarkerLengthML: ProcGetMarkerLengthML
GetMarkerNumberML: ProcGetMarkerNumberML
GetMarkerStringML: ProcGetMarkerStringML
CreateMarkerSpaceML: ProcCreateMarkerSpaceML
PollFutureEXT: ProcPollFutureEXT
CancelFutureEXT: ProcCancelFutureEXT
CreateEnvironmentDepthProviderMETA: ProcCreateEnvironmentDepthProviderMETA
DestroyEnvironmentDepthProviderMETA: ProcDestroyEnvironmentDepthProviderMETA
StartEnvironmentDepthProviderMETA: ProcStartEnvironmentDepthProviderMETA
StopEnvironmentDepthProviderMETA: ProcStopEnvironmentDepthProviderMETA
CreateEnvironmentDepthSwapchainMETA: ProcCreateEnvironmentDepthSwapchainMETA
DestroyEnvironmentDepthSwapchainMETA: ProcDestroyEnvironmentDepthSwapchainMETA
EnumerateEnvironmentDepthSwapchainImagesMETA: ProcEnumerateEnvironmentDepthSwapchainImagesMETA
GetEnvironmentDepthSwapchainStateMETA: ProcGetEnvironmentDepthSwapchainStateMETA
AcquireEnvironmentDepthImageMETA: ProcAcquireEnvironmentDepthImageMETA
SetEnvironmentDepthHandRemovalMETA: ProcSetEnvironmentDepthHandRemovalMETA
GetStationaryReferenceSpaceGenerationIdEXT: ProcGetStationaryReferenceSpaceGenerationIdEXT
CreateFacialExpressionClientML: ProcCreateFacialExpressionClientML
DestroyFacialExpressionClientML: ProcDestroyFacialExpressionClientML
GetFacialExpressionBlendShapePropertiesML: ProcGetFacialExpressionBlendShapePropertiesML
LocateSpacesKHR: ProcLocateSpaces
LocateSpaces: ProcLocateSpaces
EnumerateSpatialCapabilitiesEXT: ProcEnumerateSpatialCapabilitiesEXT
EnumerateSpatialCapabilityComponentTypesEXT: ProcEnumerateSpatialCapabilityComponentTypesEXT
EnumerateSpatialCapabilityFeaturesEXT: ProcEnumerateSpatialCapabilityFeaturesEXT
CreateSpatialContextAsyncEXT: ProcCreateSpatialContextAsyncEXT
CreateSpatialContextCompleteEXT: ProcCreateSpatialContextCompleteEXT
DestroySpatialContextEXT: ProcDestroySpatialContextEXT
CreateSpatialDiscoverySnapshotAsyncEXT: ProcCreateSpatialDiscoverySnapshotAsyncEXT
CreateSpatialDiscoverySnapshotCompleteEXT: ProcCreateSpatialDiscoverySnapshotCompleteEXT
QuerySpatialComponentDataEXT: ProcQuerySpatialComponentDataEXT
DestroySpatialSnapshotEXT: ProcDestroySpatialSnapshotEXT
CreateSpatialEntityFromIdEXT: ProcCreateSpatialEntityFromIdEXT
DestroySpatialEntityEXT: ProcDestroySpatialEntityEXT
CreateSpatialUpdateSnapshotEXT: ProcCreateSpatialUpdateSnapshotEXT
GetSpatialBufferStringEXT: ProcGetSpatialBufferStringEXT
GetSpatialBufferUint8EXT: ProcGetSpatialBufferUint8EXT
GetSpatialBufferUint16EXT: ProcGetSpatialBufferUint16EXT
GetSpatialBufferUint32EXT: ProcGetSpatialBufferUint32EXT
GetSpatialBufferFloatEXT: ProcGetSpatialBufferFloatEXT
GetSpatialBufferVector2fEXT: ProcGetSpatialBufferVector2fEXT
GetSpatialBufferVector3fEXT: ProcGetSpatialBufferVector3fEXT
CreateSpatialAnchorEXT: ProcCreateSpatialAnchorEXT
EnumerateSpatialPersistenceScopesEXT: ProcEnumerateSpatialPersistenceScopesEXT
CreateSpatialPersistenceContextAsyncEXT: ProcCreateSpatialPersistenceContextAsyncEXT
CreateSpatialPersistenceContextCompleteEXT: ProcCreateSpatialPersistenceContextCompleteEXT
DestroySpatialPersistenceContextEXT: ProcDestroySpatialPersistenceContextEXT
PersistSpatialEntityAsyncEXT: ProcPersistSpatialEntityAsyncEXT
PersistSpatialEntityCompleteEXT: ProcPersistSpatialEntityCompleteEXT
UnpersistSpatialEntityAsyncEXT: ProcUnpersistSpatialEntityAsyncEXT
UnpersistSpatialEntityCompleteEXT: ProcUnpersistSpatialEntityCompleteEXT
SetSystemNotificationsML: ProcSetSystemNotificationsML
CreateSpatialAnchorsAsyncML: ProcCreateSpatialAnchorsAsyncML
CreateSpatialAnchorsCompleteML: ProcCreateSpatialAnchorsCompleteML
GetSpatialAnchorStateML: ProcGetSpatialAnchorStateML
CreateSpatialAnchorsStorageML: ProcCreateSpatialAnchorsStorageML
DestroySpatialAnchorsStorageML: ProcDestroySpatialAnchorsStorageML
QuerySpatialAnchorsAsyncML: ProcQuerySpatialAnchorsAsyncML
QuerySpatialAnchorsCompleteML: ProcQuerySpatialAnchorsCompleteML
PublishSpatialAnchorsAsyncML: ProcPublishSpatialAnchorsAsyncML
PublishSpatialAnchorsCompleteML: ProcPublishSpatialAnchorsCompleteML
DeleteSpatialAnchorsAsyncML: ProcDeleteSpatialAnchorsAsyncML
DeleteSpatialAnchorsCompleteML: ProcDeleteSpatialAnchorsCompleteML
UpdateSpatialAnchorsExpirationAsyncML: ProcUpdateSpatialAnchorsExpirationAsyncML
UpdateSpatialAnchorsExpirationCompleteML: ProcUpdateSpatialAnchorsExpirationCompleteML
CreateWorldMeshDetectorML: ProcCreateWorldMeshDetectorML
DestroyWorldMeshDetectorML: ProcDestroyWorldMeshDetectorML
RequestWorldMeshStateAsyncML: ProcRequestWorldMeshStateAsyncML
RequestWorldMeshStateCompleteML: ProcRequestWorldMeshStateCompleteML
GetWorldMeshBufferRecommendSizeML: ProcGetWorldMeshBufferRecommendSizeML
AllocateWorldMeshBufferML: ProcAllocateWorldMeshBufferML
FreeWorldMeshBufferML: ProcFreeWorldMeshBufferML
RequestWorldMeshAsyncML: ProcRequestWorldMeshAsyncML
RequestWorldMeshCompleteML: ProcRequestWorldMeshCompleteML
CreateRenderModelEXT: ProcCreateRenderModelEXT
DestroyRenderModelEXT: ProcDestroyRenderModelEXT
GetRenderModelPropertiesEXT: ProcGetRenderModelPropertiesEXT
CreateRenderModelSpaceEXT: ProcCreateRenderModelSpaceEXT
CreateRenderModelAssetEXT: ProcCreateRenderModelAssetEXT
DestroyRenderModelAssetEXT: ProcDestroyRenderModelAssetEXT
GetRenderModelAssetDataEXT: ProcGetRenderModelAssetDataEXT
GetRenderModelAssetPropertiesEXT: ProcGetRenderModelAssetPropertiesEXT
GetRenderModelStateEXT: ProcGetRenderModelStateEXT
EnumerateInteractionRenderModelIdsEXT: ProcEnumerateInteractionRenderModelIdsEXT
EnumerateRenderModelSubactionPathsEXT: ProcEnumerateRenderModelSubactionPathsEXT
GetRenderModelPoseTopLevelUserPathEXT: ProcGetRenderModelPoseTopLevelUserPathEXT
EnumerateSupportedAudioSampleRateBD: ProcEnumerateSupportedAudioSampleRateBD
QueryFramesPerBufferRangeBD: ProcQueryFramesPerBufferRangeBD
CreateSpatialAudioRendererBD: ProcCreateSpatialAudioRendererBD
DestroySpatialAudioRendererBD: ProcDestroySpatialAudioRendererBD
CreateSoundObstacleMaterialBD: ProcCreateSoundObstacleMaterialBD
UpdateSoundObstacleMaterialConfigBD: ProcUpdateSoundObstacleMaterialConfigBD
DestroySoundObstacleMaterialBD: ProcDestroySoundObstacleMaterialBD
CreateSoundObstacleBD: ProcCreateSoundObstacleBD
UpdateSoundObstacleConfigBD: ProcUpdateSoundObstacleConfigBD
DestroySoundObstacleBD: ProcDestroySoundObstacleBD
CreateSoundObjectBD: ProcCreateSoundObjectBD
UpdateSoundObjectConfigBD: ProcUpdateSoundObjectConfigBD
SubmitSoundObjectBufferBD: ProcSubmitSoundObjectBufferBD
DestroySoundObjectBD: ProcDestroySoundObjectBD
CreateSoundFieldBD: ProcCreateSoundFieldBD
UpdateSoundFieldConfigBD: ProcUpdateSoundFieldConfigBD
SubmitSoundFieldBufferBD: ProcSubmitSoundFieldBufferBD
DestroySoundFieldBD: ProcDestroySoundFieldBD
WaitAudioPeriodBD: ProcWaitAudioPeriodBD
EndAudioPeriodBD: ProcEndAudioPeriodBD
GetSpatialEntityUuidBD: ProcGetSpatialEntityUuidBD
EnumerateSpatialEntityComponentTypesBD: ProcEnumerateSpatialEntityComponentTypesBD
GetSpatialEntityComponentDataBD: ProcGetSpatialEntityComponentDataBD
CreateSenseDataProviderBD: ProcCreateSenseDataProviderBD
StartSenseDataProviderAsyncBD: ProcStartSenseDataProviderAsyncBD
StartSenseDataProviderCompleteBD: ProcStartSenseDataProviderCompleteBD
GetSenseDataProviderStateBD: ProcGetSenseDataProviderStateBD
QuerySenseDataAsyncBD: ProcQuerySenseDataAsyncBD
QuerySenseDataCompleteBD: ProcQuerySenseDataCompleteBD
DestroySenseDataSnapshotBD: ProcDestroySenseDataSnapshotBD
GetQueriedSenseDataBD: ProcGetQueriedSenseDataBD
StopSenseDataProviderBD: ProcStopSenseDataProviderBD
DestroySenseDataProviderBD: ProcDestroySenseDataProviderBD
CreateSpatialEntityAnchorBD: ProcCreateSpatialEntityAnchorBD
DestroyAnchorBD: ProcDestroyAnchorBD
GetAnchorUuidBD: ProcGetAnchorUuidBD
CreateAnchorSpaceBD: ProcCreateAnchorSpaceBD
CreateSpatialAnchorAsyncBD: ProcCreateSpatialAnchorAsyncBD
CreateSpatialAnchorCompleteBD: ProcCreateSpatialAnchorCompleteBD
PersistSpatialAnchorAsyncBD: ProcPersistSpatialAnchorAsyncBD
PersistSpatialAnchorCompleteBD: ProcPersistSpatialAnchorCompleteBD
UnpersistSpatialAnchorAsyncBD: ProcUnpersistSpatialAnchorAsyncBD
UnpersistSpatialAnchorCompleteBD: ProcUnpersistSpatialAnchorCompleteBD
ShareSpatialAnchorAsyncBD: ProcShareSpatialAnchorAsyncBD
ShareSpatialAnchorCompleteBD: ProcShareSpatialAnchorCompleteBD
DownloadSharedSpatialAnchorAsyncBD: ProcDownloadSharedSpatialAnchorAsyncBD
DownloadSharedSpatialAnchorCompleteBD: ProcDownloadSharedSpatialAnchorCompleteBD
CaptureSceneAsyncBD: ProcCaptureSceneAsyncBD
CaptureSceneCompleteBD: ProcCaptureSceneCompleteBD
ResumeSimultaneousHandsAndControllersTrackingMETA: ProcResumeSimultaneousHandsAndControllersTrackingMETA
PauseSimultaneousHandsAndControllersTrackingMETA: ProcPauseSimultaneousHandsAndControllersTrackingMETA
EnumerateFacialSimulationModesBD: ProcEnumerateFacialSimulationModesBD
CreateFaceTrackerBD: ProcCreateFaceTrackerBD
DestroyFaceTrackerBD: ProcDestroyFaceTrackerBD
GetFacialSimulationDataBD: ProcGetFacialSimulationDataBD
SetFacialSimulationModeBD: ProcSetFacialSimulationModeBD
GetFacialSimulationModeBD: ProcGetFacialSimulationModeBD
CreateTrackableImageDatabaseAsyncANDROID: ProcCreateTrackableImageDatabaseAsyncANDROID
CreateTrackableImageDatabaseCompleteANDROID: ProcCreateTrackableImageDatabaseCompleteANDROID
DestroyTrackableImageDatabaseANDROID: ProcDestroyTrackableImageDatabaseANDROID
AddTrackableImageDatabaseANDROID: ProcAddTrackableImageDatabaseANDROID
RemoveTrackableImageDatabaseANDROID: ProcRemoveTrackableImageDatabaseANDROID
GetTrackableImageANDROID: ProcGetTrackableImageANDROID
EnumerateSpatialAnchorAttachableComponentsANDROID: ProcEnumerateSpatialAnchorAttachableComponentsANDROID
CreateSpatialAnchorSpaceANDROID: ProcCreateSpatialAnchorSpaceANDROID
CreateSpatialAnchorSpaceFromIdANDROID: ProcCreateSpatialAnchorSpaceFromIdANDROID
SetTilePropertiesHintMETA: ProcSetTilePropertiesHintMETA
CreateEnvironmentRaycasterAsyncMETA: ProcCreateEnvironmentRaycasterAsyncMETA
CreateEnvironmentRaycasterCompleteMETA: ProcCreateEnvironmentRaycasterCompleteMETA
DestroyEnvironmentRaycasterMETA: ProcDestroyEnvironmentRaycasterMETA
PerformEnvironmentRaycastMETA: ProcPerformEnvironmentRaycastMETA
CreateSpatialRaycastSnapshotANDROID: ProcCreateSpatialRaycastSnapshotANDROID
GetHandGestureQCOM: ProcGetHandGestureQCOM
HapticParametricGetPropertiesEXT: ProcHapticParametricGetPropertiesEXT
