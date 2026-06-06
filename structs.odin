package openxr


import "core:c"

// Vulkan Types
import vk "vendor:vulkan"
import win32 "core:sys/windows"
import D3D11 "vendor:directx/d3d11"
import D3D12 "vendor:directx/d3d12"

// OpenGL Types
EGLenum :: c.int

// Windows specific OS / API types
when ODIN_OS == .Windows {
	HDC :: win32.HDC
	HGLRC :: win32.HGLRC
	LUID  :: win32.LUID
	IUnknown :: win32.IUnknown

	D3D_FEATURE_LEVEL :: c.int

	ID3D11Device :: D3D11.IDevice
	ID3D11Texture2D :: D3D11.ITexture2D

	ID3D12Device :: D3D12.IDevice
	ID3D12CommandQueue :: D3D12.ICommandQueue
	ID3D12Resource :: D3D12.IResource
} else {
	HDC :: distinct rawptr
	HGLRC :: distinct rawptr
	LUID   :: struct {
		LowPart:  DWORD,
		HighPart: LONG,
	}
	IUnknown :: distinct rawptr

	D3D_FEATURE_LEVEL :: c.int

	ID3D11Device :: distinct rawptr
	ID3D11Texture2D :: distinct rawptr

	ID3D12Device :: distinct rawptr
	ID3D12CommandQueue :: distinct rawptr
	ID3D12Resource :: distinct rawptr
}

Vector2f :: struct {
	x: f32,
	y: f32,
}

Vector3f :: struct {
	x: f32,
	y: f32,
	z: f32,
}

Vector4f :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
}

Color4f :: struct {
	r: f32,
	g: f32,
	b: f32,
	a: f32,
}

Quaternionf :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
}

Posef :: struct {
	orientation: Quaternionf,
	position: Vector3f,
}

Offset2Df :: struct {
	x: f32,
	y: f32,
}

Extent2Df :: struct {
	width: f32,
	height: f32,
}

Extent3DfEXT :: struct {
}

Rect2Df :: struct {
	offset: Offset2Df,
	extent: Extent2Df,
}

Offset2Di :: struct {
	x: i32,
	y: i32,
}

Extent2Di :: struct {
	width: i32,
	height: i32,
}

Rect2Di :: struct {
	offset: Offset2Di,
	extent: Extent2Di,
}

NegotiateLoaderInfo :: struct {
	structType: LoaderInterfaceStructs,
	structVersion: u32,
	structSize: c.size_t,
	minInterfaceVersion: u32,
	maxInterfaceVersion: u32,
	minApiVersion: Version,
	maxApiVersion: Version,
}

NegotiateApiLayerRequest :: struct {
	structType: LoaderInterfaceStructs,
	structVersion: u32,
	structSize: c.size_t,
	layerInterfaceVersion: u32,
	layerApiVersion: Version,
	getInstanceProcAddr: ProcGetInstanceProcAddr,
	createApiLayerInstance: ProcCreateApiLayerInstance,
}

NegotiateRuntimeRequest :: struct {
	structType: LoaderInterfaceStructs,
	structVersion: u32,
	structSize: c.size_t,
	runtimeInterfaceVersion: u32,
	runtimeApiVersion: Version,
	getInstanceProcAddr: ProcGetInstanceProcAddr,
}

ApiLayerNextInfo :: struct {
	structType: LoaderInterfaceStructs,
	structVersion: u32,
	structSize: c.size_t,
	layerName: [MAX_API_LAYER_NAME_SIZE]u8,
	nextGetInstanceProcAddr: ProcGetInstanceProcAddr,
	nextCreateApiLayerInstance: ProcCreateApiLayerInstance,
	next: ^ApiLayerNextInfo,
}

ApiLayerCreateInfo :: struct {
	structType: LoaderInterfaceStructs,
	structVersion: u32,
	structSize: c.size_t,
	loaderInstance: rawptr,
	settings_file_location: [API_LAYER_MAX_SETTINGS_PATH_SIZE]u8,
	nextInfo: ^ApiLayerNextInfo,
}

BaseInStructure :: struct {
	sType: StructureType,
	next: ^BaseInStructure,
}

BaseOutStructure :: struct {
	sType: StructureType,
	next: ^BaseOutStructure,
}

ApiLayerProperties :: struct {
	sType: StructureType,
	next: rawptr,
	layerName: [MAX_API_LAYER_NAME_SIZE]u8,
	specVersion: Version,
	layerVersion: u32,
	description: [MAX_API_LAYER_DESCRIPTION_SIZE]u8,
}

ExtensionProperties :: struct {
	sType: StructureType,
	next: rawptr,
	extensionName: [MAX_EXTENSION_NAME_SIZE]u8,
	extensionVersion: u32,
}

ApplicationInfo :: struct {
	applicationName: [MAX_APPLICATION_NAME_SIZE]u8,
	applicationVersion: u32,
	engineName: [MAX_ENGINE_NAME_SIZE]u8,
	engineVersion: u32,
	apiVersion: Version,
}

InstanceCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: InstanceCreateFlags,
	applicationInfo: ApplicationInfo,
	enabledApiLayerCount: u32,
	enabledApiLayerNames: [^]cstring,
	enabledExtensionCount: u32,
	enabledExtensionNames: [^]cstring,
}

InstanceProperties :: struct {
	sType: StructureType,
	next: rawptr,
	runtimeVersion: Version,
	runtimeName: [MAX_RUNTIME_NAME_SIZE]u8,
}

SystemGetInfo :: struct {
	sType: StructureType,
	next: rawptr,
	formFactor: FormFactor,
}

SystemProperties :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	vendorId: u32,
	systemName: [MAX_SYSTEM_NAME_SIZE]u8,
	graphicsProperties: SystemGraphicsProperties,
	trackingProperties: SystemTrackingProperties,
}

SystemGraphicsProperties :: struct {
	maxSwapchainImageHeight: u32,
	maxSwapchainImageWidth: u32,
	maxLayerCount: u32,
}

SystemTrackingProperties :: struct {
	orientationTracking: b32,
	positionTracking: b32,
}

GraphicsBindingOpenGLWin32KHR :: struct {
	sType: StructureType,
	next: rawptr,
	hDC: HDC,
	hGLRC: HGLRC,
}

GraphicsBindingD3D11KHR :: struct {
	sType: StructureType,
	next: rawptr,
	device: ^ID3D11Device,
}

GraphicsBindingD3D12KHR :: struct {
	sType: StructureType,
	next: rawptr,
	device: ^ID3D12Device,
	queue: ^ID3D12CommandQueue,
}

GraphicsBindingVulkanKHR :: struct {
	sType: StructureType,
	next: rawptr,
	instance: vk.Instance,
	physicalDevice: vk.PhysicalDevice,
	device: vk.Device,
	queueFamilyIndex: u32,
	queueIndex: u32,
}

GraphicsBindingMetalKHR :: struct {
	sType: StructureType,
	next: rawptr,
	commandQueue: rawptr,
}

SessionCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: SessionCreateFlags,
	systemId: SystemId,
}

SessionBeginInfo :: struct {
	sType: StructureType,
	next: rawptr,
	primaryViewConfigurationType: ViewConfigurationType,
}

SwapchainCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: SwapchainCreateFlags,
	usageFlags: SwapchainUsageFlags,
	format: i64,
	sampleCount: u32,
	width: u32,
	height: u32,
	faceCount: u32,
	arraySize: u32,
	mipCount: u32,
}

SwapchainImageBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainImageOpenGLKHR :: struct {
	sType: StructureType,
	next: rawptr,
	image: u32,
}

SwapchainImageOpenGLESKHR :: struct {
	sType: StructureType,
	next: rawptr,
	image: u32,
}

SwapchainImageVulkanKHR :: struct {
	sType: StructureType,
	next: rawptr,
	image: vk.Image,
}

SwapchainImageD3D11KHR :: struct {
	sType: StructureType,
	next: rawptr,
	texture: ^ID3D11Texture2D,
}

SwapchainImageD3D12KHR :: struct {
	sType: StructureType,
	next: rawptr,
	texture: ^ID3D12Resource,
}

SwapchainImageMetalKHR :: struct {
	sType: StructureType,
	next: rawptr,
	texture: rawptr,
}

SwapchainImageAcquireInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainImageWaitInfo :: struct {
	sType: StructureType,
	next: rawptr,
	timeout: Duration,
}

SwapchainImageReleaseInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

ReferenceSpaceCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	referenceSpaceType: ReferenceSpaceType,
	poseInReferenceSpace: Posef,
}

ActionSpaceCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	subactionPath: Path,
	poseInActionSpace: Posef,
}

SpaceLocation :: struct {
	sType: StructureType,
	next: rawptr,
	locationFlags: SpaceLocationFlags,
	pose: Posef,
}

SpaceVelocity :: struct {
	sType: StructureType,
	next: rawptr,
	velocityFlags: SpaceVelocityFlags,
	linearVelocity: Vector3f,
	angularVelocity: Vector3f,
}

Fovf :: struct {
	angleLeft: f32,
	angleRight: f32,
	angleUp: f32,
	angleDown: f32,
}

View :: struct {
	sType: StructureType,
	next: rawptr,
	pose: Posef,
	fov: Fovf,
}

ViewLocateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	displayTime: Time,
	space: Space,
}

ViewState :: struct {
	sType: StructureType,
	next: rawptr,
	viewStateFlags: ViewStateFlags,
}

ViewConfigurationView :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedImageRectWidth: u32,
	maxImageRectWidth: u32,
	recommendedImageRectHeight: u32,
	maxImageRectHeight: u32,
	recommendedSwapchainSampleCount: u32,
	maxSwapchainSampleCount: u32,
}

SwapchainSubImage :: struct {
	swapchain: Swapchain,
	imageRect: Rect2Di,
	imageArrayIndex: u32,
}

CompositionLayerBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
}

CompositionLayerProjectionView :: struct {
	sType: StructureType,
	next: rawptr,
	pose: Posef,
	fov: Fovf,
	subImage: SwapchainSubImage,
}

CompositionLayerProjection :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	viewCount: u32,
	views: ^CompositionLayerProjectionView,
}

CompositionLayerQuad :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	size: Extent2Df,
}

CompositionLayerCylinderKHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	radius: f32,
	centralAngle: f32,
	aspectRatio: f32,
}

CompositionLayerCubeKHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	swapchain: Swapchain,
	imageArrayIndex: u32,
	orientation: Quaternionf,
}

CompositionLayerEquirectKHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	radius: f32,
	scale: Vector2f,
	bias: Vector2f,
}

CompositionLayerDepthInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	subImage: SwapchainSubImage,
	minDepth: f32,
	maxDepth: f32,
	nearZ: f32,
	farZ: f32,
}

FrameBeginInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

FrameEndInfo :: struct {
	sType: StructureType,
	next: rawptr,
	displayTime: Time,
	environmentBlendMode: EnvironmentBlendMode,
	layerCount: u32,
	layers: ^^CompositionLayerBaseHeader,
}

FrameWaitInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

FrameState :: struct {
	sType: StructureType,
	next: rawptr,
	predictedDisplayTime: Time,
	predictedDisplayPeriod: Duration,
	shouldRender: b32,
}

HapticBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
}

HapticVibration :: struct {
	sType: StructureType,
	next: rawptr,
	duration: Duration,
	frequency: f32,
	amplitude: f32,
}

EventDataBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
}

EventDataBuffer :: struct {
	sType: StructureType,
	next: rawptr,
	varying: [4000]u8,
}

EventDataEventsLost :: struct {
	sType: StructureType,
	next: rawptr,
	lostEventCount: u32,
}

EventDataInstanceLossPending :: struct {
	sType: StructureType,
	next: rawptr,
	lossTime: Time,
}

EventDataSessionStateChanged :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	state: SessionState,
	time: Time,
}

EventDataReferenceSpaceChangePending :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	referenceSpaceType: ReferenceSpaceType,
	changeTime: Time,
	poseValid: b32,
	poseInPreviousSpace: Posef,
}

EventDataPerfSettingsEXT :: struct {
	sType: StructureType,
	next: rawptr,
	domain: PerfSettingsDomainEXT,
	subDomain: PerfSettingsSubDomainEXT,
	fromLevel: PerfSettingsNotificationLevelEXT,
	toLevel: PerfSettingsNotificationLevelEXT,
}

EventDataVisibilityMaskChangedKHR :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	viewConfigurationType: ViewConfigurationType,
	viewIndex: u32,
}

ViewConfigurationProperties :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	fovMutable: b32,
}

ActionStateBoolean :: struct {
	sType: StructureType,
	next: rawptr,
	currentState: b32,
	changedSinceLastSync: b32,
	lastChangeTime: Time,
	isActive: b32,
}

ActionStateFloat :: struct {
	sType: StructureType,
	next: rawptr,
	currentState: f32,
	changedSinceLastSync: b32,
	lastChangeTime: Time,
	isActive: b32,
}

ActionStateVector2f :: struct {
	sType: StructureType,
	next: rawptr,
	currentState: Vector2f,
	changedSinceLastSync: b32,
	lastChangeTime: Time,
	isActive: b32,
}

ActionStatePose :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
}

ActionStateGetInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	subactionPath: Path,
}

HapticActionInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	subactionPath: Path,
}

ActionSetCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	actionSetName: [MAX_ACTION_SET_NAME_SIZE]u8,
	localizedActionSetName: [MAX_LOCALIZED_ACTION_SET_NAME_SIZE]u8,
	priority: u32,
}

ActionSuggestedBinding :: struct {
	action: Action,
	binding: Path,
}

InteractionProfileSuggestedBinding :: struct {
	sType: StructureType,
	next: rawptr,
	interactionProfile: Path,
	countSuggestedBindings: u32,
	suggestedBindings: ^ActionSuggestedBinding,
}

ActiveActionSet :: struct {
	actionSet: ActionSet,
	subactionPath: Path,
}

SessionActionSetsAttachInfo :: struct {
	sType: StructureType,
	next: rawptr,
	countActionSets: u32,
	actionSets: ^ActionSet,
}

ActionsSyncInfo :: struct {
	sType: StructureType,
	next: rawptr,
	countActiveActionSets: u32,
	activeActionSets: ^ActiveActionSet,
}

BoundSourcesForActionEnumerateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
}

InputSourceLocalizedNameGetInfo :: struct {
	sType: StructureType,
	next: rawptr,
	sourcePath: Path,
	whichComponents: InputSourceLocalizedNameFlags,
}

EventDataInteractionProfileChanged :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
}

InteractionProfileState :: struct {
	sType: StructureType,
	next: rawptr,
	interactionProfile: Path,
}

ActionCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	actionName: [MAX_ACTION_NAME_SIZE]u8,
	actionType: ActionType,
	countSubactionPaths: u32,
	subactionPaths: ^Path,
	localizedActionName: [MAX_LOCALIZED_ACTION_NAME_SIZE]u8,
}

InstanceCreateInfoAndroidKHR :: struct {
	sType: StructureType,
	next: rawptr,
	applicationVM: rawptr,
	applicationActivity: rawptr,
}

VulkanSwapchainFormatListCreateInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	viewFormatCount: u32,
	viewFormats: ^vk.Format,
}

DebugUtilsObjectNameInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	objectType: ObjectType,
	objectHandle: u64,
	objectName: cstring,
}

DebugUtilsLabelEXT :: struct {
	sType: StructureType,
	next: rawptr,
	labelName: cstring,
}

DebugUtilsMessengerCallbackDataEXT :: struct {
	sType: StructureType,
	next: rawptr,
	messageId: cstring,
	functionName: cstring,
	message: cstring,
	objectCount: u32,
	objects: ^DebugUtilsObjectNameInfoEXT,
	sessionLabelCount: u32,
	sessionLabels: ^DebugUtilsLabelEXT,
}

DebugUtilsMessengerCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	messageSeverities: DebugUtilsMessageSeverityFlagsEXT,
	messageTypes: DebugUtilsMessageTypeFlagsEXT,
	userCallback: ProcDebugUtilsMessengerCallbackEXT,
	userData: rawptr,
}

VisibilityMaskKHR :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector2f,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

GraphicsRequirementsOpenGLKHR :: struct {
	sType: StructureType,
	next: rawptr,
	minApiVersionSupported: Version,
	maxApiVersionSupported: Version,
}

GraphicsRequirementsOpenGLESKHR :: struct {
	sType: StructureType,
	next: rawptr,
	minApiVersionSupported: Version,
	maxApiVersionSupported: Version,
}

GraphicsRequirementsVulkanKHR :: struct {
	sType: StructureType,
	next: rawptr,
	minApiVersionSupported: Version,
	maxApiVersionSupported: Version,
}

GraphicsRequirementsD3D11KHR :: struct {
	sType: StructureType,
	next: rawptr,
	adapterLuid: LUID,
	minFeatureLevel: D3D_FEATURE_LEVEL,
}

GraphicsRequirementsD3D12KHR :: struct {
	sType: StructureType,
	next: rawptr,
	adapterLuid: LUID,
	minFeatureLevel: D3D_FEATURE_LEVEL,
}

GraphicsRequirementsMetalKHR :: struct {
	sType: StructureType,
	next: rawptr,
	metalDevice: rawptr,
}

VulkanInstanceCreateInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	createFlags: VulkanInstanceCreateFlagsKHR,
	pfnGetInstanceProcAddr: vk.ProcGetInstanceProcAddr,
	vulkanCreateInfo: ^vk.InstanceCreateInfo,
	vulkanAllocator: ^vk.AllocationCallbacks,
}

VulkanDeviceCreateInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	createFlags: VulkanDeviceCreateFlagsKHR,
	pfnGetInstanceProcAddr: vk.ProcGetInstanceProcAddr,
	vulkanPhysicalDevice: vk.PhysicalDevice,
	vulkanCreateInfo: ^vk.DeviceCreateInfo,
	vulkanAllocator: ^vk.AllocationCallbacks,
}

GraphicsBindingVulkan2KHR :: struct {
}

VulkanGraphicsDeviceGetInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	vulkanInstance: vk.Instance,
}

SwapchainImageVulkan2KHR :: struct {
}

GraphicsRequirementsVulkan2KHR :: struct {
}

VulkanSwapchainCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	additionalCreateFlags: vk.ImageCreateFlags,
	additionalUsageFlags: vk.ImageUsageFlags,
}

SessionCreateInfoOverlayEXTX :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: OverlaySessionCreateFlagsEXTX,
	sessionLayersPlacement: u32,
}

EventDataMainSessionVisibilityChangedEXTX :: struct {
	sType: StructureType,
	next: rawptr,
	visible: b32,
	flags: OverlayMainSessionFlagsEXTX,
}

EventDataDisplayRefreshRateChangedFB :: struct {
	sType: StructureType,
	next: rawptr,
	fromDisplayRefreshRate: f32,
	toDisplayRefreshRate: f32,
}

ViewConfigurationDepthRangeEXT :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedNearZ: f32,
	minNearZ: f32,
	recommendedFarZ: f32,
	maxFarZ: f32,
}

ViewConfigurationViewFovEPIC :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedFov: Fovf,
	maxMutableFov: Fovf,
}

InteractionProfileDpadBindingEXT :: struct {
	sType: StructureType,
	next: rawptr,
	binding: Path,
	actionSet: ActionSet,
	forceThreshold: f32,
	forceThresholdReleased: f32,
	centerRegion: f32,
	wedgeAngle: f32,
	isSticky: b32,
	onHaptic: ^HapticBaseHeader,
	offHaptic: ^HapticBaseHeader,
}

InteractionProfileAnalogThresholdVALVE :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	binding: Path,
	onThreshold: f32,
	offThreshold: f32,
	onHaptic: ^HapticBaseHeader,
	offHaptic: ^HapticBaseHeader,
}

BindingModificationsKHR :: struct {
	sType: StructureType,
	next: rawptr,
	bindingModificationCount: u32,
	bindingModifications: ^^BindingModificationBaseHeaderKHR,
}

BindingModificationBaseHeaderKHR :: struct {
	sType: StructureType,
	next: rawptr,
}

SystemEyeGazeInteractionPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsEyeGazeInteraction: b32,
}

EyeGazeSampleTimeEXT :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
}

FrameSynthesisInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: FrameSynthesisInfoFlagsEXT,
	motionVectorSubImage: SwapchainSubImage,
	motionVectorScale: Vector4f,
	motionVectorOffset: Vector4f,
	appSpaceDeltaPose: Posef,
	depthSubImage: SwapchainSubImage,
	minDepth: f32,
	maxDepth: f32,
	nearZ: f32,
	farZ: f32,
}

FrameSynthesisConfigViewEXT :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedMotionVectorImageRectWidth: u32,
	recommendedMotionVectorImageRectHeight: u32,
}

SpatialAnchorCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	pose: Posef,
	time: Time,
}

SpatialAnchorSpaceCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	anchor: SpatialAnchorMSFT,
	poseInAnchorSpace: Posef,
}

CompositionLayerImageLayoutFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: CompositionLayerImageLayoutFlagsFB,
}

CompositionLayerAlphaBlendFB :: struct {
	sType: StructureType,
	next: rawptr,
	srcFactorColor: BlendFactorFB,
	dstFactorColor: BlendFactorFB,
	srcFactorAlpha: BlendFactorFB,
	dstFactorAlpha: BlendFactorFB,
}

SpatialGraphNodeSpaceCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeType: SpatialGraphNodeTypeMSFT,
	nodeId: [GUID_SIZE_MSFT]u8,
	pose: Posef,
}

SpatialGraphStaticNodeBindingCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	poseInSpace: Posef,
	time: Time,
}

SpatialGraphNodeBindingPropertiesGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

SpatialGraphNodeBindingPropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeId: [GUID_SIZE_MSFT]u8,
	poseInNodeSpace: Posef,
}

SystemHandTrackingPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsHandTracking: b32,
}

HandTrackerCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	hand: HandEXT,
	handJointSet: HandJointSetEXT,
}

HandJointsLocateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
}

HandJointLocationEXT :: struct {
	locationFlags: SpaceLocationFlags,
	pose: Posef,
	radius: f32,
}

HandJointVelocityEXT :: struct {
	velocityFlags: SpaceVelocityFlags,
	linearVelocity: Vector3f,
	angularVelocity: Vector3f,
}

HandJointLocationsEXT :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	jointCount: u32,
	jointLocations: ^HandJointLocationEXT,
}

HandJointVelocitiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	jointCount: u32,
	jointVelocities: ^HandJointVelocityEXT,
}

SystemFaceTrackingPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFaceTracking: b32,
}

FaceTrackerCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	faceExpressionSet: FaceExpressionSetFB,
}

FaceExpressionInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
}

FaceExpressionStatusFB :: struct {
	isValid: b32,
	isEyeFollowingBlendshapesValid: b32,
}

FaceExpressionWeightsFB :: struct {
	sType: StructureType,
	next: rawptr,
	weightCount: u32,
	weights: ^f32,
	confidenceCount: u32,
	confidences: ^f32,
	status: FaceExpressionStatusFB,
	time: Time,
}

SystemFaceTrackingProperties2FB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsVisualFaceTracking: b32,
	supportsAudioFaceTracking: b32,
}

FaceTrackerCreateInfo2FB :: struct {
	sType: StructureType,
	next: rawptr,
	faceExpressionSet: FaceExpressionSet2FB,
	requestedDataSourceCount: u32,
	requestedDataSources: ^FaceTrackingDataSource2FB,
}

FaceExpressionInfo2FB :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
}

FaceExpressionWeights2FB :: struct {
	sType: StructureType,
	next: rawptr,
	weightCount: u32,
	weights: ^f32,
	confidenceCount: u32,
	confidences: ^f32,
	isValid: b32,
	isEyeFollowingBlendshapesValid: b32,
	dataSource: FaceTrackingDataSource2FB,
	time: Time,
}

SystemFaceTrackingVisemesPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsVisemes: b32,
}

FaceTrackingVisemesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	isValid: b32,
	visemes: [FACE_TRACKING_VISEME_COUNT_META]f32,
}

SystemBodyTrackingPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsBodyTracking: b32,
}

BodyTrackerCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	bodyJointSet: BodyJointSetFB,
}

BodySkeletonJointFB :: struct {
	joint: i32,
	parentJoint: i32,
	pose: Posef,
}

BodySkeletonFB :: struct {
	sType: StructureType,
	next: rawptr,
	jointCount: u32,
	joints: ^BodySkeletonJointFB,
}

BodyJointsLocateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
}

BodyJointLocationFB :: struct {
	locationFlags: SpaceLocationFlags,
	pose: Posef,
}

BodyJointLocationsFB :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	confidence: f32,
	jointCount: u32,
	jointLocations: ^BodyJointLocationFB,
	skeletonChangedCount: u32,
	time: Time,
}

SystemPropertiesBodyTrackingFullBodyMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFullBodyTracking: b32,
}

BodyTrackingCalibrationInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	bodyHeight: f32,
}

BodyTrackingCalibrationStatusMETA :: struct {
	sType: StructureType,
	next: rawptr,
	status: BodyTrackingCalibrationStateMETA,
}

SystemPropertiesBodyTrackingCalibrationMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsHeightOverride: b32,
}

BodyTrackingFidelityStatusMETA :: struct {
	sType: StructureType,
	next: rawptr,
	fidelity: BodyTrackingFidelityMETA,
}

SystemPropertiesBodyTrackingFidelityMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsBodyTrackingFidelity: b32,
}

SystemEyeTrackingPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsEyeTracking: b32,
}

EyeTrackerCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
}

EyeGazesInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
}

EyeGazeFB :: struct {
	isValid: b32,
	gazePose: Posef,
	gazeConfidence: f32,
}

EyeGazesFB :: struct {
	sType: StructureType,
	next: rawptr,
	gaze: [EYE_POSITION_COUNT_FB]EyeGazeFB,
	time: Time,
}

HandJointsMotionRangeInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	handJointsMotionRange: HandJointsMotionRangeEXT,
}

HandTrackingDataSourceInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	requestedDataSourceCount: u32,
	requestedDataSources: ^HandTrackingDataSourceEXT,
}

HandTrackingDataSourceStateEXT :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	dataSource: HandTrackingDataSourceEXT,
}

HandMeshSpaceCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	handPoseType: HandPoseTypeMSFT,
	poseInHandMeshSpace: Posef,
}

HandMeshUpdateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
	handPoseType: HandPoseTypeMSFT,
}

HandMeshMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	indexBufferChanged: b32,
	vertexBufferChanged: b32,
	indexBuffer: HandMeshIndexBufferMSFT,
	vertexBuffer: HandMeshVertexBufferMSFT,
}

HandMeshIndexBufferMSFT :: struct {
	indexBufferKey: u32,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

HandMeshVertexBufferMSFT :: struct {
	vertexUpdateTime: Time,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^HandMeshVertexMSFT,
}

HandMeshVertexMSFT :: struct {
	position: Vector3f,
	normal: Vector3f,
}

SystemHandTrackingMeshPropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsHandTrackingMesh: b32,
	maxHandMeshIndexCount: u32,
	maxHandMeshVertexCount: u32,
}

HandPoseTypeInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	handPoseType: HandPoseTypeMSFT,
}

SecondaryViewConfigurationSessionBeginInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationCount: u32,
	enabledViewConfigurationTypes: ^ViewConfigurationType,
}

SecondaryViewConfigurationStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	active: b32,
}

SecondaryViewConfigurationFrameStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationCount: u32,
	viewConfigurationStates: ^SecondaryViewConfigurationStateMSFT,
}

SecondaryViewConfigurationFrameEndInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationCount: u32,
	viewConfigurationLayersInfo: ^SecondaryViewConfigurationLayerInfoMSFT,
}

SecondaryViewConfigurationLayerInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	environmentBlendMode: EnvironmentBlendMode,
	layerCount: u32,
	layers: ^^CompositionLayerBaseHeader,
}

SecondaryViewConfigurationSwapchainCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
}

HolographicWindowAttachmentMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	holographicSpace: ^IUnknown,
	coreWindow: ^IUnknown,
}

AndroidSurfaceSwapchainCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: AndroidSurfaceSwapchainFlagsFB,
}

SwapchainStateBaseHeaderFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainStateAndroidSurfaceDimensionsFB :: struct {
	sType: StructureType,
	next: rawptr,
	width: u32,
	height: u32,
}

SwapchainStateSamplerOpenGLESFB :: struct {
	sType: StructureType,
	next: rawptr,
	minFilter: EGLenum,
	magFilter: EGLenum,
	wrapModeS: EGLenum,
	wrapModeT: EGLenum,
	swizzleRed: EGLenum,
	swizzleGreen: EGLenum,
	swizzleBlue: EGLenum,
	swizzleAlpha: EGLenum,
	maxAnisotropy: f32,
	borderColor: Color4f,
}

SwapchainStateSamplerVulkanFB :: struct {
	sType: StructureType,
	next: rawptr,
	minFilter: vk.Filter,
	magFilter: vk.Filter,
	mipmapMode: vk.SamplerMipmapMode,
	wrapModeS: vk.SamplerAddressMode,
	wrapModeT: vk.SamplerAddressMode,
	swizzleRed: vk.ComponentSwizzle,
	swizzleGreen: vk.ComponentSwizzle,
	swizzleBlue: vk.ComponentSwizzle,
	swizzleAlpha: vk.ComponentSwizzle,
	maxAnisotropy: f32,
	borderColor: Color4f,
}

CompositionLayerSecureContentFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: CompositionLayerSecureContentFlagsFB,
}

LoaderInitInfoBaseHeaderKHR :: struct {
	sType: StructureType,
	next: rawptr,
}

LoaderInitInfoAndroidKHR :: struct {
	sType: StructureType,
	next: rawptr,
	applicationVM: rawptr,
	applicationContext: rawptr,
}

CompositionLayerEquirect2KHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	radius: f32,
	centralHorizontalAngle: f32,
	upperVerticalAngle: f32,
	lowerVerticalAngle: f32,
}

CompositionLayerColorScaleBiasKHR :: struct {
	sType: StructureType,
	next: rawptr,
	colorScale: Color4f,
	colorBias: Color4f,
}

ControllerModelKeyStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	modelKey: ControllerModelKeyMSFT,
}

ControllerModelNodePropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	parentNodeName: [MAX_CONTROLLER_MODEL_NODE_NAME_SIZE_MSFT]u8,
	nodeName: [MAX_CONTROLLER_MODEL_NODE_NAME_SIZE_MSFT]u8,
}

ControllerModelPropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeCapacityInput: u32,
	nodeCountOutput: u32,
	nodeProperties: ^ControllerModelNodePropertiesMSFT,
}

ControllerModelNodeStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodePose: Posef,
}

ControllerModelStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeCapacityInput: u32,
	nodeCountOutput: u32,
	nodeStates: ^ControllerModelNodeStateMSFT,
}

UuidMSFT :: struct {
	bytes: [16]u8,
}

SceneObserverCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

SceneCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

NewSceneComputeInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	requestedFeatureCount: u32,
	requestedFeatures: ^SceneComputeFeatureMSFT,
	consistency: SceneComputeConsistencyMSFT,
	bounds: SceneBoundsMSFT,
}

VisualMeshComputeLodInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	lod: MeshComputeLodMSFT,
}

SceneSphereBoundMSFT :: struct {
	center: Vector3f,
	radius: f32,
}

SceneOrientedBoxBoundMSFT :: struct {
	pose: Posef,
	extents: Vector3f,
}

SceneFrustumBoundMSFT :: struct {
	pose: Posef,
	fov: Fovf,
	farDistance: f32,
}

SceneBoundsMSFT :: struct {
	space: Space,
	time: Time,
	sphereCount: u32,
	spheres: ^SceneSphereBoundMSFT,
	boxCount: u32,
	boxes: ^SceneOrientedBoxBoundMSFT,
	frustumCount: u32,
	frustums: ^SceneFrustumBoundMSFT,
}

SceneComponentMSFT :: struct {
	componentType: SceneComponentTypeMSFT,
	id: UuidMSFT,
	parentId: UuidMSFT,
	updateTime: Time,
}

SceneComponentsMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	componentCapacityInput: u32,
	componentCountOutput: u32,
	components: ^SceneComponentMSFT,
}

SceneComponentsGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	componentType: SceneComponentTypeMSFT,
}

SceneComponentLocationMSFT :: struct {
	flags: SpaceLocationFlags,
	pose: Posef,
}

SceneComponentLocationsMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	locationCount: u32,
	locations: ^SceneComponentLocationMSFT,
}

SceneComponentsLocateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	componentIdCount: u32,
	componentIds: ^UuidMSFT,
}

SceneObjectMSFT :: struct {
	objectType: SceneObjectTypeMSFT,
}

SceneObjectsMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	sceneObjectCount: u32,
	sceneObjects: ^SceneObjectMSFT,
}

SceneComponentParentFilterInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	parentId: UuidMSFT,
}

SceneObjectTypesFilterInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	objectTypeCount: u32,
	objectTypes: ^SceneObjectTypeMSFT,
}

ScenePlaneMSFT :: struct {
	alignment: ScenePlaneAlignmentTypeMSFT,
	size: Extent2Df,
	meshBufferId: u64,
	supportsIndicesUint16: b32,
}

ScenePlanesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	scenePlaneCount: u32,
	scenePlanes: ^ScenePlaneMSFT,
}

ScenePlaneAlignmentFilterInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	alignmentCount: u32,
	alignments: ^ScenePlaneAlignmentTypeMSFT,
}

SceneMeshMSFT :: struct {
	meshBufferId: u64,
	supportsIndicesUint16: b32,
}

SceneMeshesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	sceneMeshCount: u32,
	sceneMeshes: ^SceneMeshMSFT,
}

SceneMeshBuffersGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	meshBufferId: u64,
}

SceneMeshBuffersMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

SceneMeshVertexBufferMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector3f,
}

SceneMeshIndicesUint32MSFT :: struct {
	sType: StructureType,
	next: rawptr,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

SceneMeshIndicesUint16MSFT :: struct {
	sType: StructureType,
	next: rawptr,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u16,
}

SerializedSceneFragmentDataGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	sceneFragmentId: UuidMSFT,
}

DeserializeSceneFragmentMSFT :: struct {
	bufferSize: u32,
	buffer: ^u8,
}

SceneDeserializeInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	fragmentCount: u32,
	fragments: ^DeserializeSceneFragmentMSFT,
}

SceneMarkerMSFT :: struct {
	markerType: SceneMarkerTypeMSFT,
	lastSeenTime: Time,
	center: Offset2Df,
	size: Extent2Df,
}

SceneMarkersMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	sceneMarkerCapacityInput: u32,
	sceneMarkers: ^SceneMarkerMSFT,
}

SceneMarkerTypeFilterMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	markerTypeCount: u32,
	markerTypes: ^SceneMarkerTypeMSFT,
}

SceneMarkerQRCodeMSFT :: struct {
	symbolType: SceneMarkerQRCodeSymbolTypeMSFT,
	version: u8,
}

SceneMarkerQRCodesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	qrCodeCapacityInput: u32,
	qrCodes: ^SceneMarkerQRCodeMSFT,
}

SystemColorSpacePropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	colorSpace: ColorSpaceFB,
}

SystemSpatialEntityPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialEntity: b32,
}

SpatialAnchorCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	poseInSpace: Posef,
	time: Time,
}

SpaceComponentStatusSetInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	componentType: SpaceComponentTypeFB,
	enabled: b32,
	timeout: Duration,
}

SpaceComponentStatusFB :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
	changePending: b32,
}

EventDataSpatialAnchorCreateCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
}

EventDataSpaceSetStatusCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
	componentType: SpaceComponentTypeFB,
	enabled: b32,
}

FoveationProfileCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainCreateInfoFoveationFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: SwapchainCreateFoveationFlagsFB,
}

SwapchainStateFoveationFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: SwapchainStateFoveationFlagsFB,
	profile: FoveationProfileFB,
}

SwapchainImageFoveationVulkanFB :: struct {
	sType: StructureType,
	next: rawptr,
	image: vk.Image,
	width: u32,
	height: u32,
}

FoveationLevelProfileCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	level: FoveationLevelFB,
	verticalOffset: f32,
	fovDynamic: FoveationDynamicFB,
}

FoveationEyeTrackedProfileCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	flags: FoveationEyeTrackedProfileCreateFlagsMETA,
}

FoveationEyeTrackedStateMETA :: struct {
	sType: StructureType,
	next: rawptr,
	foveationCenter: [FOVEATION_CENTER_SIZE_META]Vector2f,
	flags: FoveationEyeTrackedStateFlagsMETA,
}

SystemFoveationEyeTrackedPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFoveationEyeTracked: b32,
}

Vector4sFB :: struct {
	x: i16,
	y: i16,
	z: i16,
	w: i16,
}

HandTrackingMeshFB :: struct {
	sType: StructureType,
	next: rawptr,
	jointCapacityInput: u32,
	jointCountOutput: u32,
	jointBindPoses: ^Posef,
	jointRadii: ^f32,
	jointParents: ^HandJointEXT,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertexPositions: ^Vector3f,
	vertexNormals: ^Vector3f,
	vertexUVs: ^Vector2f,
	vertexBlendIndices: ^Vector4sFB,
	vertexBlendWeights: ^Vector4f,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^i16,
}

HandTrackingScaleFB :: struct {
	sType: StructureType,
	next: rawptr,
	sensorOutput: f32,
	currentOutput: f32,
	overrideHandScale: b32,
	overrideValueInput: f32,
}

HandTrackingAimStateFB :: struct {
	sType: StructureType,
	next: rawptr,
	status: HandTrackingAimFlagsFB,
	aimPose: Posef,
	pinchStrengthIndex: f32,
	pinchStrengthMiddle: f32,
	pinchStrengthRing: f32,
	pinchStrengthLittle: f32,
}

HandCapsuleFB :: struct {
	points: [HAND_TRACKING_CAPSULE_POINT_COUNT_FB]Vector3f,
	radius: f32,
	joint: HandJointEXT,
}

HandTrackingCapsulesStateFB :: struct {
	sType: StructureType,
	next: rawptr,
	capsules: [HAND_TRACKING_CAPSULE_COUNT_FB]HandCapsuleFB,
}

RenderModelPathInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	path: Path,
}

RenderModelPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	vendorId: u32,
	modelName: [MAX_RENDER_MODEL_NAME_SIZE_FB]u8,
	modelKey: RenderModelKeyFB,
	modelVersion: u32,
	flags: RenderModelFlagsFB,
}

RenderModelCapabilitiesRequestFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: RenderModelFlagsFB,
}

RenderModelBufferFB :: struct {
	sType: StructureType,
	next: rawptr,
	bufferCapacityInput: u32,
	bufferCountOutput: u32,
	buffer: ^u8,
}

RenderModelLoadInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	modelKey: RenderModelKeyFB,
}

SystemRenderModelPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsRenderModelLoading: b32,
}

SpaceQueryInfoBaseHeaderFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SpaceFilterInfoBaseHeaderFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SpaceQueryInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	queryAction: SpaceQueryActionFB,
	maxResultCount: u32,
	timeout: Duration,
	filter: ^SpaceFilterInfoBaseHeaderFB,
	excludeFilter: ^SpaceFilterInfoBaseHeaderFB,
}

SpaceStorageLocationFilterInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	location: SpaceStorageLocationFB,
}

SpaceUuidFilterInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

SpaceComponentFilterInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	componentType: SpaceComponentTypeFB,
}

SpaceQueryResultFB :: struct {
	space: Space,
	uuid: UuidEXT,
}

SpaceQueryResultsFB :: struct {
	sType: StructureType,
	next: rawptr,
	resultCapacityInput: u32,
	resultCountOutput: u32,
	results: ^SpaceQueryResultFB,
}

EventDataSpaceQueryResultsAvailableFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
}

EventDataSpaceQueryCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SpaceSaveInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	location: SpaceStorageLocationFB,
	persistenceMode: SpacePersistenceModeFB,
}

SpaceEraseInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	location: SpaceStorageLocationFB,
}

EventDataSpaceSaveCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
	location: SpaceStorageLocationFB,
}

EventDataSpaceEraseCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
	location: SpaceStorageLocationFB,
}

SpaceShareInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	spaceCount: u32,
	spaces: ^Space,
	userCount: u32,
	users: ^SpaceUserFB,
}

EventDataSpaceShareCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SpaceListSaveInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	spaceCount: u32,
	spaces: ^Space,
	location: SpaceStorageLocationFB,
}

EventDataSpaceListSaveCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SpaceContainerFB :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCapacityInput: u32,
	uuidCountOutput: u32,
	uuids: ^UuidEXT,
}

SpaceTriangleMeshGetInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

SpaceTriangleMeshMETA :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector3f,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

RoomMeshFaceMETA :: struct {
	uuid: Uuid,
	parentUuid: Uuid,
	semanticLabel: SemanticLabelMETA,
}

RoomMeshFaceIndicesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

SpaceRoomMeshGetInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	recognizedSemanticLabelCount: u32,
	recognizedSemanticLabels: ^SemanticLabelMETA,
}

RoomMeshMETA :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector3f,
	faceCapacityInput: u32,
	faceCountOutput: u32,
	faces: ^RoomMeshFaceMETA,
}

SystemBoundaryVisibilityPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsBoundaryVisibility: b32,
}

EventDataBoundaryVisibilityChangedMETA :: struct {
	sType: StructureType,
	next: rawptr,
	boundaryVisibility: BoundaryVisibilityMETA,
}

Extent3DfFB :: struct {
}

Offset3DfFB :: struct {
	x: f32,
	y: f32,
	z: f32,
}

Rect3DfFB :: struct {
	offset: Offset3DfFB,
	extent: Extent3DfFB,
}

SemanticLabelsFB :: struct {
	sType: StructureType,
	next: rawptr,
	bufferCapacityInput: u32,
	bufferCountOutput: u32,
	buffer: cstring,
}

RoomLayoutFB :: struct {
	sType: StructureType,
	next: rawptr,
	floorUuid: UuidEXT,
	ceilingUuid: UuidEXT,
	wallUuidCapacityInput: u32,
	wallUuidCountOutput: u32,
	wallUuids: ^UuidEXT,
}

Boundary2DFB :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector2f,
}

SemanticLabelsSupportInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: SemanticLabelsSupportFlagsFB,
	recognizedLabels: cstring,
}

SceneCaptureRequestInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestByteCount: u32,
	request: cstring,
}

EventDataSceneCaptureCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SystemKeyboardTrackingPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsKeyboardTracking: b32,
}

KeyboardTrackingDescriptionFB :: struct {
	trackedKeyboardId: u64,
	size: Vector3f,
	flags: KeyboardTrackingFlagsFB,
	name: [MAX_KEYBOARD_TRACKING_NAME_SIZE_FB]u8,
}

KeyboardSpaceCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	trackedKeyboardId: u64,
}

KeyboardTrackingQueryFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: KeyboardTrackingQueryFlagsFB,
}

SystemColocationDiscoveryPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsColocationDiscovery: b32,
}

ColocationAdvertisementStartInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	bufferSize: u32,
	buffer: ^u8,
}

ColocationAdvertisementStopInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

ColocationDiscoveryStartInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

ColocationDiscoveryStopInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

EventDataStartColocationAdvertisementCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	advertisementRequestId: AsyncRequestIdFB,
	result: Result,
	advertisementUuid: Uuid,
}

EventDataColocationAdvertisementCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	advertisementRequestId: AsyncRequestIdFB,
	result: Result,
}

EventDataStopColocationAdvertisementCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

EventDataStartColocationDiscoveryCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	discoveryRequestId: AsyncRequestIdFB,
	result: Result,
}

EventDataColocationDiscoveryResultMETA :: struct {
	sType: StructureType,
	next: rawptr,
	discoveryRequestId: AsyncRequestIdFB,
	advertisementUuid: Uuid,
	bufferSize: u32,
	buffer: [MAX_COLOCATION_DISCOVERY_BUFFER_SIZE_META]u8,
}

EventDataColocationDiscoveryCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	discoveryRequestId: AsyncRequestIdFB,
	result: Result,
}

EventDataStopColocationDiscoveryCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SystemSpatialEntitySharingPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialEntitySharing: b32,
}

ShareSpacesRecipientBaseHeaderMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

ShareSpacesInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	spaceCount: u32,
	spaces: ^Space,
	recipientInfo: ^ShareSpacesRecipientBaseHeaderMETA,
}

EventDataShareSpacesCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

ShareSpacesRecipientGroupsMETA :: struct {
	sType: StructureType,
	next: rawptr,
	groupCount: u32,
	groups: ^Uuid,
}

SpaceGroupUuidFilterInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	groupUuid: Uuid,
}

SystemSpatialEntityGroupSharingPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialEntityGroupSharing: b32,
}

CompositionLayerDepthTestVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	depthTestRangeNearZ: f32,
	depthTestRangeFarZ: f32,
}

ViewLocateFoveatedRenderingVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	foveatedRenderingActive: b32,
}

FoveatedViewConfigurationViewVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	foveatedRenderingActive: b32,
}

SystemFoveatedRenderingPropertiesVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFoveatedRendering: b32,
}

CompositionLayerReprojectionInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	reprojectionMode: ReprojectionModeMSFT,
}

CompositionLayerReprojectionPlaneOverrideMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	position: Vector3f,
	normal: Vector3f,
	velocity: Vector3f,
}

TriangleMeshCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: TriangleMeshFlagsFB,
	windingOrder: WindingOrderFB,
	vertexCount: u32,
	vertexBuffer: ^Vector3f,
	triangleCount: u32,
	indexBuffer: ^u32,
}

SystemPassthroughPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsPassthrough: b32,
}

SystemPassthroughProperties2FB :: struct {
	sType: StructureType,
	next: rawptr,
	capabilities: PassthroughCapabilityFlagsFB,
}

PassthroughCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: PassthroughFlagsFB,
}

PassthroughLayerCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	passthrough: PassthroughFB,
	flags: PassthroughFlagsFB,
	purpose: PassthroughLayerPurposeFB,
}

CompositionLayerPassthroughFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: CompositionLayerFlags,
	space: Space,
	layerHandle: PassthroughLayerFB,
}

GeometryInstanceCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	layer: PassthroughLayerFB,
	mesh: TriangleMeshFB,
	baseSpace: Space,
	pose: Posef,
	scale: Vector3f,
}

GeometryInstanceTransformFB :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	pose: Posef,
	scale: Vector3f,
}

PassthroughStyleFB :: struct {
	sType: StructureType,
	next: rawptr,
	textureOpacityFactor: f32,
	edgeColor: Color4f,
}

PassthroughColorMapMonoToRgbaFB :: struct {
	sType: StructureType,
	next: rawptr,
	textureColorMap: [PASSTHROUGH_COLOR_MAP_MONO_SIZE_FB]Color4f,
}

PassthroughColorMapMonoToMonoFB :: struct {
	sType: StructureType,
	next: rawptr,
	textureColorMap: [PASSTHROUGH_COLOR_MAP_MONO_SIZE_FB]u8,
}

PassthroughBrightnessContrastSaturationFB :: struct {
	sType: StructureType,
	next: rawptr,
	brightness: f32,
	contrast: f32,
	saturation: f32,
}

EventDataPassthroughStateChangedFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: PassthroughStateChangedFlagsFB,
}

PassthroughKeyboardHandsIntensityFB :: struct {
	sType: StructureType,
	next: rawptr,
	leftHandIntensity: f32,
	rightHandIntensity: f32,
}

LocalDimmingFrameEndInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	localDimmingMode: LocalDimmingModeMETA,
}

SpatialAnchorPersistenceNameMSFT :: struct {
	name: [MAX_SPATIAL_ANCHOR_NAME_SIZE_MSFT]u8,
}

SpatialAnchorPersistenceInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	spatialAnchorPersistenceName: SpatialAnchorPersistenceNameMSFT,
	spatialAnchor: SpatialAnchorMSFT,
}

SpatialAnchorFromPersistedAnchorCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorPersistenceName: SpatialAnchorPersistenceNameMSFT,
}

SystemBodyTrackingPropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsBodyTracking: b32,
}

BodyTrackerCreateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	jointSet: BodyJointSetBD,
}

BodyJointsLocateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
}

BodyJointLocationBD :: struct {
	locationFlags: SpaceLocationFlags,
	pose: Posef,
}

BodyJointLocationsBD :: struct {
	sType: StructureType,
	next: rawptr,
	allJointPosesTracked: b32,
	jointLocationCount: u32,
	jointLocations: ^BodyJointLocationBD,
}

FuturePollResultProgressBD :: struct {
	sType: StructureType,
	next: rawptr,
	isSupported: b32,
	progressPercentage: u32,
}

FacialTrackerCreateInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	facialTrackingType: FacialTrackingTypeHTC,
}

SystemFacialTrackingPropertiesHTC :: struct {
	sType: StructureType,
	next: rawptr,
	supportEyeFacialTracking: b32,
	supportLipFacialTracking: b32,
}

FacialExpressionsHTC :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	sampleTime: Time,
	expressionCount: u32,
	expressionWeightings: ^f32,
}

PassthroughCreateInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	form: PassthroughFormHTC,
}

PassthroughColorHTC :: struct {
	sType: StructureType,
	next: rawptr,
	alpha: f32,
}

PassthroughMeshTransformInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCount: u32,
	vertices: ^Vector3f,
	indexCount: u32,
	indices: ^u32,
	baseSpace: Space,
	time: Time,
	pose: Posef,
	scale: Vector3f,
}

CompositionLayerPassthroughHTC :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	passthrough: PassthroughHTC,
	color: PassthroughColorHTC,
}

SpatialAnchorCreateInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	poseInSpace: Posef,
	name: SpatialAnchorNameHTC,
}

SpatialAnchorNameHTC :: struct {
	name: [MAX_SPATIAL_ANCHOR_NAME_SIZE_HTC]u8,
}

SystemAnchorPropertiesHTC :: struct {
	sType: StructureType,
	next: rawptr,
	supportsAnchor: b32,
}

ViveTrackerPathsHTCX :: struct {
	sType: StructureType,
	next: rawptr,
	persistentPath: Path,
	rolePath: Path,
}

EventDataViveTrackerConnectedHTCX :: struct {
	sType: StructureType,
	next: rawptr,
	paths: ^ViveTrackerPathsHTCX,
}

SystemBodyTrackingPropertiesHTC :: struct {
	sType: StructureType,
	next: rawptr,
	supportsBodyTracking: b32,
}

BodyTrackerCreateInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	bodyJointSet: BodyJointSetHTC,
}

BodySkeletonJointHTC :: struct {
	pose: Posef,
}

BodySkeletonHTC :: struct {
	sType: StructureType,
	next: rawptr,
	jointCount: u32,
	joints: ^BodySkeletonJointHTC,
}

BodyJointsLocateInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
}

BodyJointLocationHTC :: struct {
	locationFlags: SpaceLocationFlags,
	pose: Posef,
}

BodyJointLocationsHTC :: struct {
	sType: StructureType,
	next: rawptr,
	combinedLocationFlags: SpaceLocationFlags,
	confidenceLevel: BodyJointConfidenceHTC,
	jointLocationCount: u32,
	jointLocations: ^BodyJointLocationHTC,
	skeletonGenerationId: u32,
}

CompositionLayerSpaceWarpInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerSpaceWarpInfoFlagsFB,
	motionVectorSubImage: SwapchainSubImage,
	appSpaceDeltaPose: Posef,
	depthSubImage: SwapchainSubImage,
	minDepth: f32,
	maxDepth: f32,
	nearZ: f32,
	farZ: f32,
}

SystemSpaceWarpPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedMotionVectorImageRectWidth: u32,
	recommendedMotionVectorImageRectHeight: u32,
}

SystemMarkerTrackingPropertiesVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	supportsMarkerTracking: b32,
}

EventDataMarkerTrackingUpdateVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	markerId: u64,
	isActive: b32,
	isPredicted: b32,
	time: Time,
}

MarkerSpaceCreateInfoVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	markerId: u64,
	poseInMarkerSpace: Posef,
}

UuidEXT :: struct {
}

GlobalDimmerFrameEndInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	dimmerValue: f32,
	flags: GlobalDimmerFrameEndInfoFlagsML,
}

DigitalLensControlALMALENCE :: struct {
	sType: StructureType,
	next: rawptr,
	flags: DigitalLensControlFlagsALMALENCE,
}

CompositionLayerSettingsFB :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerSettingsFlagsFB,
}

ExternalCameraIntrinsicsOCULUS :: struct {
	lastChangeTime: Time,
	fov: Fovf,
	virtualNearPlaneDistance: f32,
	virtualFarPlaneDistance: f32,
	imageSensorPixelResolution: Extent2Di,
}

ExternalCameraExtrinsicsOCULUS :: struct {
	lastChangeTime: Time,
	cameraStatusFlags: ExternalCameraStatusFlagsOCULUS,
	attachedToDevice: ExternalCameraAttachedToDeviceOCULUS,
	relativePose: Posef,
}

ExternalCameraOCULUS :: struct {
	sType: StructureType,
	next: rawptr,
	name: [MAX_EXTERNAL_CAMERA_NAME_SIZE_OCULUS]u8,
	intrinsics: ExternalCameraIntrinsicsOCULUS,
	extrinsics: ExternalCameraExtrinsicsOCULUS,
}

PerformanceMetricsStateMETA :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
}

PerformanceMetricsCounterMETA :: struct {
	sType: StructureType,
	next: rawptr,
	counterFlags: PerformanceMetricsCounterFlagsMETA,
	counterUnit: PerformanceMetricsCounterUnitMETA,
	uintValue: u32,
	floatValue: f32,
}

PassthroughPreferencesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	flags: PassthroughPreferenceFlagsMETA,
}

SystemHeadsetIdPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	id: UuidEXT,
}

SystemSpacePersistencePropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpacePersistence: b32,
}

SpacesSaveInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	spaceCount: u32,
	spaces: ^Space,
}

EventDataSpacesSaveResultMETA :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SpacesEraseInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	spaceCount: u32,
	spaces: ^Space,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

EventDataSpacesEraseResultMETA :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SystemSpaceDiscoveryPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpaceDiscovery: b32,
}

SpaceFilterBaseHeaderMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

SpaceDiscoveryInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	filterCount: u32,
	filters: ^^SpaceFilterBaseHeaderMETA,
}

SpaceFilterUuidMETA :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

SpaceFilterComponentMETA :: struct {
	sType: StructureType,
	next: rawptr,
	componentType: SpaceComponentTypeFB,
}

SpaceDiscoveryResultMETA :: struct {
	space: Space,
	uuid: UuidEXT,
}

SpaceDiscoveryResultsMETA :: struct {
	sType: StructureType,
	next: rawptr,
	resultCapacityInput: u32,
	resultCountOutput: u32,
	results: ^SpaceDiscoveryResultMETA,
}

EventDataSpaceDiscoveryResultsAvailableMETA :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
}

EventDataSpaceDiscoveryCompleteMETA :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

PassthroughColorLutDataMETA :: struct {
	bufferSize: u32,
	buffer: ^u8,
}

PassthroughColorLutCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	channels: PassthroughColorLutChannelsMETA,
	resolution: u32,
	data: PassthroughColorLutDataMETA,
}

PassthroughColorLutUpdateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	data: PassthroughColorLutDataMETA,
}

PassthroughColorMapLutMETA :: struct {
	sType: StructureType,
	next: rawptr,
	colorLut: PassthroughColorLutMETA,
	weight: f32,
}

PassthroughColorMapInterpolatedLutMETA :: struct {
	sType: StructureType,
	next: rawptr,
	sourceColorLut: PassthroughColorLutMETA,
	targetColorLut: PassthroughColorLutMETA,
	weight: f32,
}

SystemPassthroughColorLutPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	maxColorLutResolution: u32,
}

FoveationApplyInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	mode: FoveationModeHTC,
	subImageCount: u32,
	subImages: ^SwapchainSubImage,
}

FoveationConfigurationHTC :: struct {
	level: FoveationLevelHTC,
	clearFovDegree: f32,
	focalCenterOffset: Vector2f,
}

FoveationDynamicModeInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	dynamicFlags: FoveationDynamicFlagsHTC,
}

FoveationCustomModeInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	configCount: u32,
	configs: ^FoveationConfigurationHTC,
}

ActiveActionSetPrioritiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	actionSetPriorityCount: u32,
	actionSetPriorities: ^ActiveActionSetPriorityEXT,
}

ActiveActionSetPriorityEXT :: struct {
	actionSet: ActionSet,
	priorityOverride: u32,
}

CompositionLayerDepthTestFB :: struct {
	sType: StructureType,
	next: rawptr,
	depthMask: b32,
	compareOp: CompareOpFB,
}

CoordinateSpaceCreateInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	cfuid: MLCoordinateFrameUID,
	poseInCoordinateSpace: Posef,
}

FrameEndInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	focusDistance: f32,
	flags: FrameEndInfoFlagsML,
}

HapticAmplitudeEnvelopeVibrationFB :: struct {
	sType: StructureType,
	next: rawptr,
	duration: Duration,
	amplitudeCount: u32,
	amplitudes: ^f32,
}

HapticPcmVibrationFB :: struct {
	sType: StructureType,
	next: rawptr,
	bufferSize: u32,
	buffer: ^f32,
	sampleRate: f32,
	append: b32,
	samplesConsumed: ^u32,
}

DevicePcmSampleRateStateFB :: struct {
	sType: StructureType,
	next: rawptr,
	sampleRate: f32,
}

DevicePcmSampleRateGetInfoFB :: struct {
}

SpaceUserCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	userId: SpaceUserIdFB,
}

SystemForceFeedbackCurlPropertiesMNDX :: struct {
	sType: StructureType,
	next: rawptr,
	supportsForceFeedbackCurl: b32,
}

ForceFeedbackCurlApplyLocationsMNDX :: struct {
	sType: StructureType,
	next: rawptr,
	locationCount: u32,
	locations: ^ForceFeedbackCurlApplyLocationMNDX,
}

ForceFeedbackCurlApplyLocationMNDX :: struct {
	location: ForceFeedbackCurlLocationMNDX,
	value: f32,
}

FaceTrackerCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
}

FaceStateGetInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
}

FaceStateANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	parametersCapacityInput: u32,
	parametersCountOutput: u32,
	parameters: ^f32,
	faceTrackingState: FaceTrackingStateANDROID,
	sampleTime: Time,
	isValid: b32,
	regionConfidencesCapacityInput: u32,
	regionConfidencesCountOutput: u32,
	regionConfidences: ^f32,
}

SystemFaceTrackingPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFaceTracking: b32,
}

SystemPassthroughCameraStatePropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsPassthroughCameraState: b32,
}

PassthroughCameraStateGetInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
}

TrackableTrackerCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackableType: TrackableTypeANDROID,
}

TrackableGetInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackable: TrackableANDROID,
	baseSpace: Space,
	time: Time,
}

TrackablePlaneANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingState: TrackingStateANDROID,
	centerPose: Posef,
	extents: Extent2Df,
	planeType: PlaneTypeANDROID,
	planeLabel: PlaneLabelANDROID,
	subsumedByPlane: TrackableANDROID,
	lastUpdatedTime: Time,
	vertexCapacityInput: u32,
	vertexCountOutput: ^u32,
	vertices: ^Vector2f,
}

AnchorSpaceCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	time: Time,
	pose: Posef,
	trackable: TrackableANDROID,
}

SystemTrackablesPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsAnchor: b32,
	maxAnchors: u32,
}

TrackableObjectANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingState: TrackingStateANDROID,
	centerPose: Posef,
	extents: Extent3DfEXT,
	objectLabel: ObjectLabelANDROID,
	lastUpdatedTime: Time,
}

TrackableObjectConfigurationANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	labelCount: u32,
	activeLabels: ^ObjectLabelANDROID,
}

RaycastInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	maxResults: u32,
	trackerCount: u32,
	trackers: ^TrackableTrackerANDROID,
	origin: Vector3f,
	trajectory: Vector3f,
	space: Space,
	time: Time,
}

RaycastHitResultANDROID :: struct {
	sType: TrackableTypeANDROID,
	trackable: TrackableANDROID,
	pose: Posef,
}

RaycastHitResultsANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	resultsCapacityInput: u32,
	resultsCountOutput: u32,
	results: ^RaycastHitResultANDROID,
}

SystemMarkerTrackingPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsMarkerTracking: b32,
	supportsMarkerSizeEstimation: b32,
	maxMarkerCount: u16,
}

TrackableMarkerConfigurationANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingMode: TrackableMarkerTrackingModeANDROID,
	databaseCount: u32,
	databases: ^TrackableMarkerDatabaseANDROID,
}

TrackableMarkerDatabaseANDROID :: struct {
	dictionary: TrackableMarkerDictionaryANDROID,
	entryCount: u32,
	entries: ^TrackableMarkerDatabaseEntryANDROID,
}

TrackableMarkerDatabaseEntryANDROID :: struct {
	id: i32,
	edgeSize: f32,
}

TrackableMarkerANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingState: TrackingStateANDROID,
	lastUpdatedTime: Time,
	dictionary: TrackableMarkerDictionaryANDROID,
	markerId: i32,
	centerPose: Posef,
	extents: Extent2Df,
}

SystemAnchorSharingExportPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsAnchorSharingExport: b32,
}

AnchorSharingInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	anchor: Space,
}

AnchorSharingTokenANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	token: ^AIBinder,
}

DeviceAnchorPersistenceCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
}

PersistedAnchorSpaceCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	anchorId: UuidEXT,
}

PersistedAnchorSpaceInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	anchor: Space,
}

SystemDeviceAnchorPersistencePropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsAnchorPersistence: b32,
}

PerformanceMetricsStateANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
}

PerformanceMetricsCounterANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	counterFlags: PerformanceMetricsCounterFlagsANDROID,
	counterUnit: PerformanceMetricsCounterUnitANDROID,
	uintValue: u32,
	floatValue: f32,
}

SystemQrCodeTrackingPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsQrCodeTracking: b32,
	supportsQrCodeSizeEstimation: b32,
	maxQrCodeCount: u16,
}

TrackableQrCodeConfigurationANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingMode: QrCodeTrackingModeANDROID,
	qrCodeEdgeSize: f32,
}

TrackableQrCodeANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingState: TrackingStateANDROID,
	lastUpdatedTime: Time,
	centerPose: Posef,
	extents: Extent2Df,
	bufferCapacityInput: u32,
	bufferCountOutput: u32,
	buffer: cstring,
}

SystemPassthroughLayerPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsPassthroughLayer: b32,
	maxMeshIndexCount: u32,
	maxMeshVertexCount: u32,
}

PassthroughLayerCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacity: u32,
	indexCapacity: u32,
}

PassthroughLayerMeshANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	windingOrder: WindingOrderANDROID,
	vertexCount: u32,
	vertices: ^Vector3f,
	indexCount: u32,
	indices: ^u16,
}

CompositionLayerPassthroughANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	pose: Posef,
	scale: Vector3f,
	opacity: f32,
	layer: PassthroughLayerANDROID,
}

SystemSceneMeshingPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSceneMeshing: b32,
}

SceneMeshingTrackerCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	semanticLabelSet: SceneMeshSemanticLabelSetANDROID,
	enableNormals: b32,
}

SceneMeshSnapshotCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	boundingBox: Boxf,
}

SceneMeshSnapshotCreationResultANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	snapshot: SceneMeshSnapshotANDROID,
	trackingState: SceneMeshTrackingStateANDROID,
}

SceneSubmeshStateANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	submeshId: Uuid,
	lastUpdatedTime: Time,
	submeshPoseInBaseSpace: Posef,
	bounds: Extent3Df,
}

SceneSubmeshDataANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	submeshId: Uuid,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertexPositions: ^Vector3f,
	vertexNormals: ^Vector3f,
	vertexSemantics: ^u8,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

SystemEyeTrackingPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsEyeTracking: b32,
}

EyeANDROID :: struct {
	eyeState: EyeStateANDROID,
	eyePose: Posef,
}

EyesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	eyes: [EYE_MAX_ANDROID]EyeANDROID,
	mode: EyeTrackingModeANDROID,
}

EyesGetInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
	baseSpace: Space,
}

EyeTrackerCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
}

EventDataRecommendedResolutionChangedANDROID :: struct {
	sType: StructureType,
	next: rawptr,
}

SystemLightEstimationPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsLightEstimation: b32,
}

LightEstimatorCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
}

LightEstimateGetInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	time: Time,
}

LightEstimateANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	state: LightEstimateStateANDROID,
	lastUpdatedTime: Time,
}

DirectionalLightANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	state: LightEstimateStateANDROID,
	intensity: Vector3f,
	direction: Vector3f,
}

AmbientLightANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	state: LightEstimateStateANDROID,
	intensity: Vector3f,
	colorCorrection: Vector3f,
}

SphericalHarmonicsANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	state: LightEstimateStateANDROID,
	kind: SphericalHarmonicsKindANDROID,
	coefficients: [9][3]f32,
}

SystemPlaneDetectionPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	supportedFeatures: PlaneDetectionCapabilityFlagsEXT,
}

PlaneDetectorCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	flags: PlaneDetectorFlagsEXT,
}

PlaneDetectorBeginInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	orientationCount: u32,
	orientations: ^PlaneDetectorOrientationEXT,
	semanticTypeCount: u32,
	semanticTypes: ^PlaneDetectorSemanticTypeEXT,
	maxPlanes: u32,
	minArea: f32,
	boundingBoxPose: Posef,
	boundingBoxExtent: Extent3DfEXT,
}

PlaneDetectorGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
}

PlaneDetectorLocationsEXT :: struct {
	sType: StructureType,
	next: rawptr,
	planeLocationCapacityInput: u32,
	planeLocationCountOutput: u32,
	planeLocations: ^PlaneDetectorLocationEXT,
}

PlaneDetectorLocationEXT :: struct {
	sType: StructureType,
	next: rawptr,
	planeId: u64,
	locationFlags: SpaceLocationFlags,
	pose: Posef,
	extents: Extent2Df,
	orientation: PlaneDetectorOrientationEXT,
	semanticType: PlaneDetectorSemanticTypeEXT,
	polygonBufferCount: u32,
}

PlaneDetectorPolygonBufferEXT :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector2f,
}

SystemVirtualKeyboardPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsVirtualKeyboard: b32,
}

VirtualKeyboardCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

VirtualKeyboardSpaceCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	locationType: VirtualKeyboardLocationTypeMETA,
	space: Space,
	poseInSpace: Posef,
}

VirtualKeyboardLocationInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	locationType: VirtualKeyboardLocationTypeMETA,
	space: Space,
	poseInSpace: Posef,
	scale: f32,
}

VirtualKeyboardModelVisibilitySetInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	visible: b32,
}

VirtualKeyboardAnimationStateMETA :: struct {
	sType: StructureType,
	next: rawptr,
	animationIndex: i32,
	fraction: f32,
}

VirtualKeyboardModelAnimationStatesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	stateCapacityInput: u32,
	stateCountOutput: u32,
	states: ^VirtualKeyboardAnimationStateMETA,
}

VirtualKeyboardTextureDataMETA :: struct {
	sType: StructureType,
	next: rawptr,
	textureWidth: u32,
	textureHeight: u32,
	bufferCapacityInput: u32,
	bufferCountOutput: u32,
	buffer: ^u8,
}

VirtualKeyboardInputInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	inputSource: VirtualKeyboardInputSourceMETA,
	inputSpace: Space,
	inputPoseInSpace: Posef,
	inputState: VirtualKeyboardInputStateFlagsMETA,
}

VirtualKeyboardTextContextChangeInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	textContext: cstring,
}

EventDataVirtualKeyboardCommitTextMETA :: struct {
	sType: StructureType,
	next: rawptr,
	keyboard: VirtualKeyboardMETA,
	text: [MAX_VIRTUAL_KEYBOARD_COMMIT_TEXT_SIZE_META]u8,
}

EventDataVirtualKeyboardBackspaceMETA :: struct {
	sType: StructureType,
	next: rawptr,
	keyboard: VirtualKeyboardMETA,
}

EventDataVirtualKeyboardEnterMETA :: struct {
	sType: StructureType,
	next: rawptr,
	keyboard: VirtualKeyboardMETA,
}

EventDataVirtualKeyboardShownMETA :: struct {
	sType: StructureType,
	next: rawptr,
	keyboard: VirtualKeyboardMETA,
}

EventDataVirtualKeyboardHiddenMETA :: struct {
	sType: StructureType,
	next: rawptr,
	keyboard: VirtualKeyboardMETA,
}

UserCalibrationEnableEventsInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
}

EventDataHeadsetFitChangedML :: struct {
	sType: StructureType,
	next: rawptr,
	status: HeadsetFitStatusML,
	time: Time,
}

EventDataEyeCalibrationChangedML :: struct {
	sType: StructureType,
	next: rawptr,
	status: EyeCalibrationStatusML,
}

LocalizationMapML :: struct {
	sType: StructureType,
	next: rawptr,
	name: [MAX_LOCALIZATION_MAP_NAME_LENGTH_ML]u8,
	mapUuid: UuidEXT,
	mapType: LocalizationMapTypeML,
}

LocalizationEnableEventsInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
}

EventDataLocalizationChangedML :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	state: LocalizationMapStateML,
	_map: LocalizationMapML,
	confidence: LocalizationMapConfidenceML,
	errorFlags: LocalizationMapErrorFlagsML,
}

LocalizationMapQueryInfoBaseHeaderML :: struct {
	sType: StructureType,
	next: rawptr,
}

MapLocalizationRequestInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	mapUuid: UuidEXT,
}

LocalizationMapImportInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	size: u32,
	data: cstring,
}

SystemMarkerUnderstandingPropertiesML :: struct {
	sType: StructureType,
	next: rawptr,
	supportsMarkerUnderstanding: b32,
}

MarkerDetectorCreateInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	profile: MarkerDetectorProfileML,
	markerType: MarkerTypeML,
}

MarkerDetectorArucoInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	arucoDict: MarkerArucoDictML,
}

MarkerDetectorSizeInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	markerLength: f32,
}

MarkerDetectorAprilTagInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	aprilTagDict: MarkerAprilTagDictML,
}

MarkerDetectorCustomProfileInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	fpsHint: MarkerDetectorFpsML,
	resolutionHint: MarkerDetectorResolutionML,
	cameraHint: MarkerDetectorCameraML,
	cornerRefineMethod: MarkerDetectorCornerRefineMethodML,
	useEdgeRefinement: b32,
	fullAnalysisIntervalHint: MarkerDetectorFullAnalysisIntervalML,
}

MarkerDetectorSnapshotInfoML :: struct {
	sType: StructureType,
	next: rawptr,
}

MarkerDetectorStateML :: struct {
	sType: StructureType,
	next: rawptr,
	state: MarkerDetectorStatusML,
}

MarkerSpaceCreateInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	markerDetector: MarkerDetectorML,
	marker: MarkerML,
	poseInMarkerSpace: Posef,
}

Color3f :: struct {
	r: f32,
	g: f32,
	b: f32,
}

Extent3Df :: struct {
	width: f32,
	height: f32,
	depth: f32,
}

Spheref :: struct {
	center: Posef,
	radius: f32,
}

Boxf :: struct {
	center: Posef,
	extents: Extent3Df,
}

Frustumf :: struct {
	pose: Posef,
	fov: Fovf,
	nearZ: f32,
	farZ: f32,
}

Uuid :: struct {
	data: [UUID_SIZE]u8,
}

Color3fKHR :: struct {
}

Extent3DfKHR :: struct {
}

SpherefKHR :: struct {
}

BoxfKHR :: struct {
}

FrustumfKHR :: struct {
}

SystemFacialExpressionPropertiesML :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFacialExpression: b32,
}

FacialExpressionClientCreateInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	requestedCount: u32,
	requestedFacialBlendShapes: ^FacialBlendShapeML,
}

FacialExpressionBlendShapePropertiesML :: struct {
	sType: StructureType,
	next: rawptr,
	requestedFacialBlendShape: FacialBlendShapeML,
	weight: f32,
	flags: FacialExpressionBlendShapePropertiesFlagsML,
	time: Time,
}

FacialExpressionBlendShapeGetInfoML :: struct {
	sType: StructureType,
	next: rawptr,
}

RecommendedLayerResolutionMETA :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedImageDimensions: Extent2Di,
	isValid: b32,
}

RecommendedLayerResolutionGetInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	layer: ^CompositionLayerBaseHeader,
	predictedDisplayTime: Time,
}

SystemUserPresencePropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsUserPresence: b32,
}

EventDataUserPresenceChangedEXT :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	isUserPresent: b32,
}

FutureCompletionBaseHeaderEXT :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
}

FutureCompletionEXT :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
}

FutureCancelInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	future: FutureEXT,
}

FuturePollInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	future: FutureEXT,
}

FuturePollResultEXT :: struct {
	sType: StructureType,
	next: rawptr,
	state: FutureStateEXT,
}

EnvironmentDepthProviderCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: EnvironmentDepthProviderCreateFlagsMETA,
}

EnvironmentDepthSwapchainCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: EnvironmentDepthSwapchainCreateFlagsMETA,
}

EnvironmentDepthSwapchainStateMETA :: struct {
	sType: StructureType,
	next: rawptr,
	width: u32,
	height: u32,
}

EnvironmentDepthImageAcquireInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	displayTime: Time,
}

EnvironmentDepthImageViewMETA :: struct {
	sType: StructureType,
	next: rawptr,
	fov: Fovf,
	pose: Posef,
}

EnvironmentDepthImageMETA :: struct {
	sType: StructureType,
	next: rawptr,
	swapchainIndex: u32,
	nearZ: f32,
	farZ: f32,
	views: [2]EnvironmentDepthImageViewMETA,
}

EnvironmentDepthImageTimestampMETA :: struct {
	sType: StructureType,
	next: rawptr,
	captureTime: Time,
}

EnvironmentDepthHandRemovalSetInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
}

SystemEnvironmentDepthPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsEnvironmentDepth: b32,
	supportsHandRemoval: b32,
}

SpacesLocateInfoKHR :: struct {
}

SpacesLocateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	spaceCount: u32,
	spaces: ^Space,
}

SpaceLocationsKHR :: struct {
}

SpaceLocations :: struct {
	sType: StructureType,
	next: rawptr,
	locationCount: u32,
	locations: ^SpaceLocationData,
}

SpaceLocationDataKHR :: struct {
}

SpaceLocationData :: struct {
	locationFlags: SpaceLocationFlags,
	pose: Posef,
}

SpaceVelocitiesKHR :: struct {
}

SpaceVelocities :: struct {
	sType: StructureType,
	next: rawptr,
	velocityCount: u32,
	velocities: ^SpaceVelocityData,
}

SpaceVelocityDataKHR :: struct {
}

SpaceVelocityData :: struct {
	velocityFlags: SpaceVelocityFlags,
	linearVelocity: Vector3f,
	angularVelocity: Vector3f,
}

SpatialCapabilityComponentTypesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	componentTypeCapacityInput: u32,
	componentTypeCountOutput: u32,
	componentTypes: ^SpatialComponentTypeEXT,
}

SpatialCapabilityConfigurationBaseHeaderEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
}

SpatialContextCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capabilityConfigCount: u32,
	capabilityConfigs: ^^SpatialCapabilityConfigurationBaseHeaderEXT,
}

CreateSpatialContextCompletionEXT :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	spatialContext: SpatialContextEXT,
}

SpatialDiscoverySnapshotCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	componentTypeCount: u32,
	componentTypes: ^SpatialComponentTypeEXT,
}

CreateSpatialDiscoverySnapshotCompletionInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	future: FutureEXT,
}

CreateSpatialDiscoverySnapshotCompletionEXT :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	snapshot: SpatialSnapshotEXT,
}

SpatialComponentDataQueryConditionEXT :: struct {
	sType: StructureType,
	next: rawptr,
	componentTypeCount: u32,
	componentTypes: ^SpatialComponentTypeEXT,
}

SpatialComponentDataQueryResultEXT :: struct {
	sType: StructureType,
	next: rawptr,
	entityIdCapacityInput: u32,
	entityIdCountOutput: u32,
	entityIds: ^SpatialEntityIdEXT,
	entityStateCapacityInput: u32,
	entityStateCountOutput: u32,
	entityStates: ^SpatialEntityTrackingStateEXT,
}

SpatialBufferEXT :: struct {
	bufferId: SpatialBufferIdEXT,
	bufferType: SpatialBufferTypeEXT,
}

SpatialBufferGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	bufferId: SpatialBufferIdEXT,
}

SpatialBounded2DDataEXT :: struct {
	center: Posef,
	extents: Extent2Df,
}

SpatialComponentBounded2DListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	boundCount: u32,
	bounds: ^SpatialBounded2DDataEXT,
}

SpatialComponentBounded3DListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	boundCount: u32,
	bounds: ^Boxf,
}

SpatialComponentParentListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	parentCount: u32,
	parents: ^SpatialEntityIdEXT,
}

SpatialMeshDataEXT :: struct {
	origin: Posef,
	vertexBuffer: SpatialBufferEXT,
	indexBuffer: SpatialBufferEXT,
}

SpatialComponentMesh3DListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	meshCount: u32,
	meshes: ^SpatialMeshDataEXT,
}

SpatialEntityFromIdCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	entityId: SpatialEntityIdEXT,
}

SpatialUpdateSnapshotCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	entityCount: u32,
	entities: ^SpatialEntityEXT,
	componentTypeCount: u32,
	componentTypes: ^SpatialComponentTypeEXT,
	baseSpace: Space,
	time: Time,
}

EventDataSpatialDiscoveryRecommendedEXT :: struct {
	sType: StructureType,
	next: rawptr,
	spatialContext: SpatialContextEXT,
}

SpatialFilterTrackingStateEXT :: struct {
	sType: StructureType,
	next: rawptr,
	trackingState: SpatialEntityTrackingStateEXT,
}

SpatialCapabilityConfigurationAnchorEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
}

SpatialComponentAnchorListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	locationCount: u32,
	locations: ^Posef,
}

SpatialAnchorCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	pose: Posef,
}

SpatialPersistenceContextCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	scope: SpatialPersistenceScopeEXT,
}

CreateSpatialPersistenceContextCompletionEXT :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	createResult: SpatialPersistenceContextResultEXT,
	persistenceContext: SpatialPersistenceContextEXT,
}

SpatialContextPersistenceConfigEXT :: struct {
	sType: StructureType,
	next: rawptr,
	persistenceContextCount: u32,
	persistenceContexts: ^SpatialPersistenceContextEXT,
}

SpatialDiscoveryPersistenceUuidFilterEXT :: struct {
	sType: StructureType,
	next: rawptr,
	persistedUuidCount: u32,
	persistedUuids: ^Uuid,
}

SpatialPersistenceDataEXT :: struct {
	persistUuid: Uuid,
	persistState: SpatialPersistenceStateEXT,
}

SpatialComponentPersistenceListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	persistDataCount: u32,
	persistData: ^SpatialPersistenceDataEXT,
}

SpatialEntityPersistInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	spatialContext: SpatialContextEXT,
	spatialEntityId: SpatialEntityIdEXT,
}

PersistSpatialEntityCompletionEXT :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	persistResult: SpatialPersistenceContextResultEXT,
	persistUuid: Uuid,
}

SpatialEntityUnpersistInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	persistUuid: Uuid,
}

UnpersistSpatialEntityCompletionEXT :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	unpersistResult: SpatialPersistenceContextResultEXT,
}

SpatialCapabilityConfigurationPlaneTrackingEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
}

SpatialComponentPlaneAlignmentListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	planeAlignmentCount: u32,
	planeAlignments: ^SpatialPlaneAlignmentEXT,
}

SpatialComponentMesh2DListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	meshCount: u32,
	meshes: ^SpatialMeshDataEXT,
}

SpatialPolygon2DDataEXT :: struct {
	origin: Posef,
	vertexBuffer: SpatialBufferEXT,
}

SpatialComponentPolygon2DListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	polygonCount: u32,
	polygons: ^SpatialPolygon2DDataEXT,
}

SpatialComponentPlaneSemanticLabelListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	semanticLabelCount: u32,
	semanticLabels: ^SpatialPlaneSemanticLabelEXT,
}

StationaryReferenceSpaceGenerationIdGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
}

StationaryReferenceSpaceGenerationIdResultEXT :: struct {
	sType: StructureType,
	next: rawptr,
	generationId: Uuid,
}

SystemNotificationsSetInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	suppressNotifications: b32,
}

SpatialAudioRendererCreateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	framesPerBuffer: u32,
	sampleRate: AudioSampleRateBD,
}

AudioBufferBD :: struct {
	sType: StructureType,
	next: rawptr,
	channelLayout: AudioBufferChannelLayoutBD,
	bufferChannels: u32,
	bufferLength: u32,
	buffer: ^f32,
}

SoundObjectDirectivityCardioidBD :: struct {
	sType: StructureType,
	next: rawptr,
	alpha: f32,
	order: f32,
}

SoundObjectShapeSphereBD :: struct {
	sType: StructureType,
	next: rawptr,
	radius: f32,
}

SoundObjectDistanceAttenuationBD :: struct {
	sType: StructureType,
	next: rawptr,
	distanceAttenuationType: SoundObjectDistanceAttenuationTypeBD,
	minAttenuationRange: f32,
	maxAttenuationRange: f32,
	referenceDistance: f32,
	rolloffFactor: f32,
	customDistanceAttenuationCurve: ^SoundObjectDistanceAttenuationCurveBD,
}

AttenuationCurvePointBD :: struct {
	distance: f32,
	gain: f32,
}

SoundObjectDistanceAttenuationCurveBD :: struct {
	sType: StructureType,
	next: rawptr,
	curvePointCount: u32,
	curvePoints: ^AttenuationCurvePointBD,
}

SoundObjectConfigBD :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
	pose: Posef,
	baseSpace: Space,
	mainVolume: f32,
	reflectionGain: f32,
	enableDoppler: b32,
	directSoundAttenuation: ^SoundObjectDistanceAttenuationBD,
	indirectSoundAttenuation: ^SoundObjectDistanceAttenuationBD,
}

SoundFieldConfigBD :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
	orientation: Quaternionf,
	baseSpace: Space,
	mainVolume: f32,
	lfeGain: f32,
}

SoundFieldChannelDefinitionSurroundBD :: struct {
	sType: StructureType,
	next: rawptr,
	channelMask: SoundFieldChannelMaskSurroundBD,
}

SoundFieldChannelDefinitionAmbixBD :: struct {
	sType: StructureType,
	next: rawptr,
	channelMask: SoundFieldChannelMaskAmbixBD,
}

SoundFieldChannelDefinitionFumaBD :: struct {
	sType: StructureType,
	next: rawptr,
	channelMask: SoundFieldChannelMaskFumaBD,
}

SoundTriangleMeshBD :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCount: u32,
	vertices: ^Vector3f,
	indexCount: u32,
	indices: ^u32,
}

SoundObstacleConfigBD :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
	pose: Posef,
	baseSpace: Space,
	materialCount: u32,
	materials: ^SoundObstacleMaterialBD,
}

SoundObstacleMaterialConfigBD :: struct {
	sType: StructureType,
	next: rawptr,
	materialType: SoundObstacleMaterialTypeBD,
	bandCount: u32,
	bandFrequencies: ^f32,
	bandAbsorptions: ^f32,
	bandScatterings: ^f32,
	bandTransmissions: ^f32,
}

SpatialAnchorsCreateInfoBaseHeaderML :: struct {
	sType: StructureType,
	next: rawptr,
}

SpatialAnchorsCreateInfoFromPoseML :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	poseInBaseSpace: Posef,
	time: Time,
}

CreateSpatialAnchorsCompletionML :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	spaceCount: u32,
	spaces: ^Space,
}

SpatialAnchorStateML :: struct {
	sType: StructureType,
	next: rawptr,
	confidence: SpatialAnchorConfidenceML,
}

SpatialAnchorsCreateStorageInfoML :: struct {
	sType: StructureType,
	next: rawptr,
}

SpatialAnchorsQueryInfoBaseHeaderML :: struct {
	sType: StructureType,
	next: rawptr,
}

SpatialAnchorsQueryInfoRadiusML :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	center: Vector3f,
	time: Time,
	radius: f32,
}

SpatialAnchorsQueryCompletionML :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	uuidCapacityInput: u32,
	uuidCountOutput: u32,
	uuids: ^UuidEXT,
}

SpatialAnchorsCreateInfoFromUuidsML :: struct {
	sType: StructureType,
	next: rawptr,
	storage: SpatialAnchorsStorageML,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

SpatialAnchorsPublishInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	anchorCount: u32,
	anchors: ^Space,
	expiration: u64,
}

SpatialAnchorsPublishCompletionML :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

SpatialAnchorsDeleteInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

SpatialAnchorsDeleteCompletionML :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
}

SpatialAnchorsUpdateExpirationInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCount: u32,
	uuids: ^UuidEXT,
	expiration: u64,
}

SpatialAnchorsUpdateExpirationCompletionML :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
}

SpatialAnchorCompletionResultML :: struct {
	uuid: UuidEXT,
	result: Result,
}

SpatialAnchorsPublishCompletionDetailsML :: struct {
	sType: StructureType,
	next: rawptr,
	resultCount: u32,
	results: ^SpatialAnchorCompletionResultML,
}

SpatialAnchorsDeleteCompletionDetailsML :: struct {
	sType: StructureType,
	next: rawptr,
	resultCount: u32,
	results: ^SpatialAnchorCompletionResultML,
}

SpatialAnchorsUpdateExpirationCompletionDetailsML :: struct {
	sType: StructureType,
	next: rawptr,
	resultCount: u32,
	results: ^SpatialAnchorCompletionResultML,
}

WorldMeshDetectorCreateInfoML :: struct {
	sType: StructureType,
	next: rawptr,
}

WorldMeshStateRequestInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	boundingBoxCenter: Posef,
	boundingBoxExtents: Extent3DfEXT,
}

WorldMeshBlockStateML :: struct {
	sType: StructureType,
	next: rawptr,
	uuid: UuidEXT,
	meshBoundingBoxCenter: Posef,
	meshBoundingBoxExtents: Extent3DfEXT,
	lastUpdateTime: Time,
	status: WorldMeshBlockStatusML,
}

WorldMeshStateRequestCompletionML :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	timestamp: Time,
	meshBlockStateCapacityInput: u32,
	meshBlockStateCountOutput: u32,
	meshBlockStates: ^WorldMeshBlockStateML,
}

WorldMeshBufferRecommendedSizeInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	maxBlockCount: u32,
}

WorldMeshBufferSizeML :: struct {
	sType: StructureType,
	next: rawptr,
	size: u32,
}

WorldMeshBufferML :: struct {
	sType: StructureType,
	next: rawptr,
	bufferSize: u32,
	buffer: rawptr,
}

WorldMeshBlockRequestML :: struct {
	sType: StructureType,
	next: rawptr,
	uuid: UuidEXT,
	lod: WorldMeshDetectorLodML,
}

WorldMeshGetInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	flags: WorldMeshDetectorFlagsML,
	fillHoleLength: f32,
	disconnectedComponentArea: f32,
	blockCount: u32,
	blocks: ^WorldMeshBlockRequestML,
}

WorldMeshBlockML :: struct {
	sType: StructureType,
	next: rawptr,
	uuid: UuidEXT,
	blockResult: WorldMeshBlockResultML,
	lod: WorldMeshDetectorLodML,
	flags: WorldMeshDetectorFlagsML,
	indexCount: u32,
	indexBuffer: ^u16,
	vertexCount: u32,
	vertexBuffer: ^Vector3f,
	normalCount: u32,
	normalBuffer: ^Vector3f,
	confidenceCount: u32,
	confidenceBuffer: ^f32,
}

WorldMeshRequestCompletionInfoML :: struct {
	sType: StructureType,
	next: rawptr,
	meshSpace: Space,
	meshSpaceLocateTime: Time,
}

WorldMeshRequestCompletionML :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	blockCount: u32,
	blocks: ^WorldMeshBlockML,
}

EventDataPassthroughLayerResumedMETA :: struct {
	sType: StructureType,
	next: rawptr,
	layer: PassthroughLayerFB,
}

RenderModelCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	renderModelId: RenderModelIdEXT,
	gltfExtensionCount: u32,
	gltfExtensions: [^]cstring,
}

RenderModelPropertiesGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
}

RenderModelPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	cacheId: UuidEXT,
	animatableNodeCount: u32,
}

RenderModelSpaceCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	renderModel: RenderModelEXT,
}

RenderModelAssetCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	cacheId: UuidEXT,
}

RenderModelAssetDataGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
}

RenderModelAssetDataEXT :: struct {
	sType: StructureType,
	next: rawptr,
	bufferCapacityInput: u32,
	bufferCountOutput: u32,
	buffer: ^u8,
}

RenderModelAssetPropertiesGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
}

RenderModelAssetNodePropertiesEXT :: struct {
	uniqueName: [MAX_RENDER_MODEL_ASSET_NODE_NAME_SIZE_EXT]u8,
}

RenderModelAssetPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	nodePropertyCount: u32,
	nodeProperties: ^RenderModelAssetNodePropertiesEXT,
}

RenderModelStateGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	displayTime: Time,
}

RenderModelNodeStateEXT :: struct {
	nodePose: Posef,
	isVisible: b32,
}

RenderModelStateEXT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeStateCount: u32,
	nodeStates: ^RenderModelNodeStateEXT,
}

InteractionRenderModelIdsEnumerateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
}

InteractionRenderModelSubactionPathInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
}

InteractionRenderModelTopLevelUserPathGetInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	topLevelUserPathCount: u32,
	topLevelUserPaths: ^Path,
}

EventDataInteractionRenderModelsChangedEXT :: struct {
	sType: StructureType,
	next: rawptr,
}

SystemSpatialSensingPropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialSensing: b32,
}

SpatialEntityComponentGetInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	entityId: SpatialEntityIdBD,
	componentType: SpatialEntityComponentTypeBD,
}

SpatialEntityComponentDataBaseHeaderBD :: struct {
	sType: StructureType,
	next: rawptr,
}

SpatialEntityLocationGetInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
}

SpatialEntityComponentDataLocationBD :: struct {
	sType: StructureType,
	next: rawptr,
	location: SpaceLocation,
}

SpatialEntityComponentDataSemanticBD :: struct {
	sType: StructureType,
	next: rawptr,
	labelCapacityInput: u32,
	labelCountOutput: u32,
	labels: ^SemanticLabelBD,
}

SpatialEntityComponentDataBoundingBox2DBD :: struct {
	sType: StructureType,
	next: rawptr,
	boundingBox2D: Rect2Df,
}

SpatialEntityComponentDataPolygonBD :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector2f,
}

SpatialEntityComponentDataBoundingBox3DBD :: struct {
	sType: StructureType,
	next: rawptr,
	boundingBox3D: Boxf,
}

SpatialEntityComponentDataTriangleMeshBD :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector3f,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u16,
}

SenseDataProviderCreateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	providerType: SenseDataProviderTypeBD,
}

SenseDataProviderStartInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
}

EventDataSenseDataProviderStateChangedBD :: struct {
	sType: StructureType,
	next: rawptr,
	provider: SenseDataProviderBD,
	newState: SenseDataProviderStateBD,
}

EventDataSenseDataUpdatedBD :: struct {
	sType: StructureType,
	next: rawptr,
	provider: SenseDataProviderBD,
}

SenseDataQueryInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
}

SenseDataFilterUuidBD :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

SenseDataFilterSemanticBD :: struct {
	sType: StructureType,
	next: rawptr,
	labelCount: u32,
	labels: ^SemanticLabelBD,
}

SenseDataQueryCompletionBD :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	snapshot: SenseDataSnapshotBD,
}

QueriedSenseDataGetInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
}

QueriedSenseDataBD :: struct {
	sType: StructureType,
	next: rawptr,
	stateCapacityInput: u32,
	stateCountOutput: u32,
	states: ^SpatialEntityStateBD,
}

SpatialEntityStateBD :: struct {
	sType: StructureType,
	next: rawptr,
	entityId: SpatialEntityIdBD,
	lastUpdateTime: Time,
	uuid: UuidEXT,
}

SpatialEntityAnchorCreateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	snapshot: SenseDataSnapshotBD,
	entityId: SpatialEntityIdBD,
}

AnchorSpaceCreateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	anchor: AnchorBD,
	poseInAnchorSpace: Posef,
}

SystemSpatialAnchorPropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialAnchor: b32,
}

SpatialAnchorCreateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	pose: Posef,
	time: Time,
}

SpatialAnchorCreateCompletionBD :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	uuid: UuidEXT,
	anchor: AnchorBD,
}

SpatialAnchorPersistInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	location: PersistenceLocationBD,
	anchor: AnchorBD,
}

SpatialAnchorUnpersistInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	location: PersistenceLocationBD,
	anchor: AnchorBD,
}

SystemSpatialAnchorSharingPropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialAnchorSharing: b32,
}

SpatialAnchorShareInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	anchor: AnchorBD,
}

SharedSpatialAnchorDownloadInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	uuid: UuidEXT,
}

SystemSpatialMeshPropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialMesh: b32,
}

SenseDataProviderCreateInfoSpatialMeshBD :: struct {
	sType: StructureType,
	next: rawptr,
	configFlags: SpatialMeshConfigFlagsBD,
	lod: SpatialMeshLodBD,
}

SystemSpatialScenePropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialScene: b32,
}

SceneCaptureInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
}

SystemSpatialPlanePropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialPlane: b32,
}

SpatialEntityComponentDataPlaneOrientationBD :: struct {
	sType: StructureType,
	next: rawptr,
	orientation: PlaneOrientationBD,
}

SenseDataFilterPlaneOrientationBD :: struct {
	sType: StructureType,
	next: rawptr,
	orientationCount: u32,
	orientations: ^PlaneOrientationBD,
}

SystemSimultaneousHandsAndControllersPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSimultaneousHandsAndControllers: b32,
}

SimultaneousHandsAndControllersTrackingResumeInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

SimultaneousHandsAndControllersTrackingPauseInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

LoaderInitInfoPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	propertyValueCount: u32,
	propertyValues: ^LoaderInitPropertyValueEXT,
}

LoaderInitPropertyValueEXT :: struct {
	name: cstring,
	value: cstring,
}

SpatialCapabilityConfigurationDepthRaycastANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
}

SpatialRaycastInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	time: Time,
	origin: Vector3f,
	direction: Vector3f,
	maxDistance: f32,
}

SpatialRaycastResultDataANDROID :: struct {
	hitPose: Posef,
	distanceSquared: f32,
}

SpatialComponentRaycastResultListANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	raycastResultCount: u32,
	raycastResults: ^SpatialRaycastResultDataANDROID,
}

SpatialRaycastSnapshotCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	componentTypeCount: u32,
	componentTypes: ^SpatialComponentTypeEXT,
	raycastInfo: ^SpatialRaycastInfoANDROID,
}

SpatialCapabilityConfigurationArucoMarkerEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
	arUcoDict: SpatialMarkerArucoDictEXT,
}

SpatialCapabilityConfigurationAprilTagEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
	aprilDict: SpatialMarkerAprilTagDictEXT,
}

SpatialCapabilityConfigurationQrCodeEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
}

SpatialCapabilityConfigurationMicroQrCodeEXT :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
}

SpatialMarkerSizeEXT :: struct {
	sType: StructureType,
	next: rawptr,
	markerSideLength: f32,
}

SpatialMarkerStaticOptimizationEXT :: struct {
	sType: StructureType,
	next: rawptr,
	optimizeForStaticMarker: b32,
}

SpatialMarkerDataEXT :: struct {
	capability: SpatialCapabilityEXT,
	markerId: u32,
	data: SpatialBufferEXT,
}

SpatialComponentMarkerListEXT :: struct {
	sType: StructureType,
	next: rawptr,
	markerCount: u32,
	markers: ^SpatialMarkerDataEXT,
}

Extent3DiMETA :: struct {
	width: i32,
	height: i32,
	depth: i32,
}

TilePropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	tileDimensions: Extent3DiMETA,
	apronDimensions: Extent2Di,
	origin: Offset2Di,
}

TilePropertiesHintMETA :: struct {
	sType: StructureType,
	next: rawptr,
	propertiesCount: u32,
	properties: ^TilePropertiesMETA,
}

SystemFacialSimulationPropertiesBD :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFaceTracking: b32,
}

FaceTrackerCreateInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	mode: FacialSimulationModeBD,
}

FacialSimulationDataGetInfoBD :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
}

FacialSimulationDataBD :: struct {
	sType: StructureType,
	next: rawptr,
	faceExpressionWeightCount: u32,
	faceExpressionWeights: ^f32,
	isUpperFaceDataValid: b32,
	isLowerFaceDataValid: b32,
	time: Time,
}

LipExpressionDataBD :: struct {
	sType: StructureType,
	next: rawptr,
	lipsyncExpressionWeightCount: u32,
	lipsyncExpressionWeights: ^f32,
}

SystemImageTrackingPropertiesANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	supportsImageTracking: b32,
	supportsPhysicalSizeEstimation: b32,
	maxTrackedImageCount: u32,
	maxLoadedImageCount: u32,
}

TrackableImageDatabaseEntryANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingMode: TrackableImageTrackingModeANDROID,
	physicalWidth: f32,
	imageWidth: u32,
	imageHeight: u32,
	format: TrackableImageFormatANDROID,
	bufferSize: u32,
	buffer: ^u8,
}

TrackableImageDatabaseCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	entryCount: u32,
	entries: ^TrackableImageDatabaseEntryANDROID,
}

CreateTrackableImageDatabaseCompletionANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	database: TrackableImageDatabaseANDROID,
}

TrackableImageConfigurationANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	databaseCount: u32,
	databases: ^TrackableImageDatabaseANDROID,
}

TrackableImageANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	trackingState: TrackingStateANDROID,
	lastUpdatedTime: Time,
	database: TrackableImageDatabaseANDROID,
	databaseEntryIndex: u32,
	centerPose: Posef,
	extents: Extent2Df,
}

EventDataImageTrackingLostANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
}

SpatialCapabilityConfigurationObjectTrackingANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	capability: SpatialCapabilityEXT,
	enabledComponentCount: u32,
	enabledComponents: ^SpatialComponentTypeEXT,
	activeSemanticLabelCount: u32,
	activeSemanticLabels: ^SpatialObjectSemanticLabelANDROID,
}

SpatialComponentObjectSemanticLabelListANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	semanticLabelCount: u32,
	semanticLabels: ^SpatialObjectSemanticLabelANDROID,
}

SpatialAnchorParentANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	parentId: SpatialEntityIdEXT,
}

SpatialAnchorSpaceFromIdCreateInfoANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	anchorEntityId: SpatialEntityIdEXT,
}

SpatialDiscoveryUniqueEntitiesFilterANDROID :: struct {
	sType: StructureType,
	next: rawptr,
}

SpatialComponentSubsumedByListANDROID :: struct {
	sType: StructureType,
	next: rawptr,
	subsumedUniqueIdCount: u32,
	subsumedUniqueIds: ^SpatialEntityIdEXT,
}

EventDataViewConfigurationViewsChangedEXT :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
}

BatteryStateDisplayEXT :: struct {
	sType: StructureType,
	next: rawptr,
	stateFlags: BatteryStateDisplayStateFlagsEXT,
	batteryLevel: f32,
}

SystemEnvironmentRaycastPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	supportsEnvironmentRaycast: b32,
}

EnvironmentRaycasterCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

EnvironmentRaycasterCreateCompletionMETA :: struct {
	sType: StructureType,
	next: rawptr,
	futureResult: Result,
	environmentRaycaster: EnvironmentRaycasterMETA,
}

EnvironmentRaycastFilterBaseHeaderMETA :: struct {
	sType: StructureType,
	next: rawptr,
}

EnvironmentRaycastFilterDistanceMETA :: struct {
	sType: StructureType,
	next: rawptr,
	maxDistance: f32,
}

EnvironmentRaycastHitGetInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	origin: Vector3f,
	direction: Vector3f,
	filterCount: u32,
	filters: ^^EnvironmentRaycastFilterBaseHeaderMETA,
}

EnvironmentRaycastHitMETA :: struct {
	sType: StructureType,
	next: rawptr,
	status: EnvironmentRaycastHitStatusMETA,
	pose: Posef,
}

HandGestureQCOM :: struct {
	gesture: HandGestureTypeQCOM,
	gestureRatio: f32,
	flipRatio: f32,
}

HapticParametricPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	idealFrameSubmissionRate: Duration,
	minimumFirstFrameDuration: Duration,
	minFrequencyHz: f32,
	maxFrequencyHz: f32,
}

HapticParametricPointEXT :: struct {
	time: Duration,
	value: f32,
}

HapticParametricTransientEXT :: struct {
	time: Duration,
	amplitude: f32,
	frequency: f32,
}

HapticParametricVibrationEXT :: struct {
	sType: StructureType,
	next: rawptr,
	amplitudePointCount: u32,
	amplitudePoints: ^HapticParametricPointEXT,
	frequencyPointCount: u32,
	frequencyPoints: ^HapticParametricPointEXT,
	transientCount: u32,
	transients: ^HapticParametricTransientEXT,
	minFrequencyHz: f32,
	maxFrequencyHz: f32,
	streamFrameType: HapticParametricStreamFrameTypeEXT,
}

SystemHapticParametricPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsParametricHaptics: b32,
}

