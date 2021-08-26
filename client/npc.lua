local coords = {
    {-672.13, 4401.78, 17.65,"Buyer",47.05,0x6C9B2849,"a_m_m_hillbilly_01"}
}
local coords2 = {
    {-788.28, 4477.03, 17.69,"Buyer",134.80,0x6C9B2849,"a_m_m_hillbilly_01"}
}

Citizen.CreateThread(function()

    for _,v in pairs(coords) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("facials@p_m_one@variations@normal")
      while not HasAnimDictLoaded("facials@p_m_one@variations@normal") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"facials@p_m_one@variations@normal","normal", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()

    for _,v in pairs(coords2) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("facials@p_m_one@variations@normal")
      while not HasAnimDictLoaded("facials@p_m_one@variations@normal") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"facials@p_m_one@variations@normal","normal", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)