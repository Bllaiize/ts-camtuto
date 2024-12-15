local cam = nil

function createCamera(coords, traveling, direction, shake, speed)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, coords.x, coords.y, coords.z)
    SetCamRot(cam, 0.0, 0.0, coords.w)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)
    
    if shake then
        ShakeCam(cam, "HAND_SHAKE", 0.5)
    end

    if traveling and direction then
        Citizen.CreateThread(function()
            local startTime = GetGameTimer()
            local duration = 5000

            local travelDuration = duration / (speed / 10)
            
            while GetGameTimer() - startTime < travelDuration do
                local progress = (GetGameTimer() - startTime) / travelDuration
                local newX = coords.x + progress * (direction.x - coords.x)
                local newY = coords.y + progress * (direction.y - coords.y)
                local newZ = coords.z + progress * (direction.z - coords.z)
                SetCamCoord(cam, newX, newY, newZ)
                Wait(0)
            end
        end)
    end
end


function destroyCamera()
    SetCamActive(cam, false)
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(cam, false)
    cam = nil
end

function displayText(text)
    ClearAllHelpMessages()
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function loadScene(coords)
    NewLoadSceneStart(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z, 50.0, 0)
    while IsNetworkLoadingScene() do
        Wait(1)
    end
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
        Wait(1)
    end
end

function switchToCameraGroup(camGroup)
    local cameras = config.cameras[camGroup]
    if cameras then
        Citizen.CreateThread(function()
            for _, camData in ipairs(cameras) do
                loadScene(camData.coords)
                createCamera(camData.coords, camData.traveling, camData.direction, camData.shake, camData.speed)
                
                local durationPerText = camData.duration / #camData.txt
                for _, text in ipairs(camData.txt) do
                    displayText(text)
                    Citizen.Wait(durationPerText)
                end
                
                destroyCamera()
            end
        end)
    else
        print("Caméra de groupe non trouvée dans la configuration.")
    end
end


RegisterCommand('cam', function(source, args, rawCommand)
    if #args > 0 then
        local camGroup = args[1]
        switchToCameraGroup(camGroup)
    else
        print("Use : /cam [Camera Name]")
    end
end, false)

RegisterNetEvent('bl-cam:setPlayerToCam')
AddEventHandler('bl-cam:setPlayerToCam', function(cam)
    switchToCameraGroup(cam)

end)



