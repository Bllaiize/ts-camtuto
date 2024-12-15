# FiveM Script: Tutorial Cameras

This script allows you to manage and execute multiple cameras in FiveM, perfect for creating tutorials or immersive cinematics.

## 🎥 Features

- 🎬 **Multi-Camera Management**: Set up multiple cameras with custom angles.  
- ⏱️ **Smooth Transitions**: Add transition effects between cameras.  
- 🔄 **Automation**: Easily configure the script to automatically play camera sequences.  
- 📜 **Customizable**: Adjust positions, rotations, and durations through a configuration file.

## 🛠️ Installation

1. Clone or download this repository into your server's `resources` folder:  
   ```bash
   git clone https://github.com/Bllaiize/ts-camtuto.git
   ```

2. Add the scripts to your server.cfg :
```ensure ts-camtuto```

2. The config files
```lua
config = {
    cameras = {
        petrol = { -- A sequence of cameras for the "petrol" tutorial
            { 
                coords = vector4(2623.09, 1613.43, 55.5, 251.49), -- Initial coordinates and rotation for the camera
                duration = 7500, -- Time this camera remains active (in milliseconds)
                traveling = true, -- Should the camera move to a target position?
                direction = vector3(2580.44, 1448.3, 55.5), -- Target position for traveling
                shake = true, -- Enable camera shake effect
                speed = 5, -- Speed of the traveling motion
                txt = {"To start harvesting oil, you will need to go to the refinery.", "And more text"} -- Text to display during this scene. [ /!\ USE , IF U WANT USE SEVERAL TEXT ] 
            }
        },
    }
}

```


