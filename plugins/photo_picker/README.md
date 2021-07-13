# Godot PhotoPicker plugin

Example:

```
var _picker = null

func _image_picked(image):
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	icon.texture = texture

func _permission_updated(target, status):
	match (target):
		apns.PERMISSION_TARGET_PHOTO_LIBRARY:
			print("photo library")
		apns.PERMISSION_TARGET_CAMERA:
			print("camera")
	
	match (status):
		apns.PERMISSION_STATUS_UNKNOWN:
			print("unknown")
		apns.PERMISSION_STATUS_ALLOWED:
			print("allowed")
		apns.PERMISSION_STATUS_DENIED:
			print("denied")
            
func _on_Button_button_down():
	apns.present(apns.SOURCE_SAVED_PHOTOS_ALBUM);
	apns.present(apns.SOURCE_CAMERA_REAR);
	apns.present(apns.SOURCE_CAMERA_FRONT);
    
	print(apns.permission_status(apns.PERMISSION_TARGET_CAMERA))
	print(apns.permission_status(apns.PERMISSION_TARGET_PHOTO_LIBRARY))
    
	apns.request_permission(apns.PERMISSION_TARGET_CAMERA)
	apns.request_permission(apns.PERMISSION_TARGET_PHOTO_LIBRARY)

...

func _ready():
	if Engine.has_singleton("PhotoPicker"):
		_picker = Engine.get_singleton("PhotoPicker")
		_picker.connect("image_picked", self, "_image_picked")
		_picker.connect("permission_updated", self, "_permission_updated")
		print("registering photo picker")
	else:
		print("no photo picker")
```

## Enum

Type: `PhotoPickerSourceType`  
Values: `SOURCE_PHOTO_LIBRARY`, `SOURCE_CAMERA_FRONT`, `SOURCE_CAMERA_REAR`, `SOURCE_SAVED_PHOTOS_ALBUM`

Type: `PhotoPickerPermissionTarget`  
Values: `PERMISSION_TARGET_PHOTO_LIBRARY`, `PERMISSION_TARGET_CAMERA`

Type: `PhotoPickerPermissionStatus`  
Values: `PERMISSION_STATUS_UNKNOWN`, `PERMISSION_STATUS_ALLOWED`, `PERMISSION_STATUS_DENIED`

## Methods

`permission_status(PhotoPickerPermissionTarget target): PhotoPickerPermissionStatus` - Returns a permissions status for specific photo picker target.
`request_permission(PhotoPickerPermissionTarget target)` - Performs a permission request for photo picker permission target if needed.
`present(PhotoPickerSourceType source)` - Presents a photo picker with specific source type that allows to select an image or take a picture from camera.

## Properties

## Signals

`image_picked(Ref<Image> image)` - Called whenever user selects an image from a library or takes a photo.
`permission_updated(PhotoPickerPermissionTarget image)` - Called when user changes permission status after `request_permission` is called.