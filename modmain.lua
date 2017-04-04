local require = GLOBAL.require

--DumpEntity(GLOBAL)

AddReplicableComponent("chatterbox")

AddPlayerPostInit(function(inst)
    if inst == nil then return end
    if GLOBAL.TheWorld.ismastersim then
        inst:AddComponent("chatterbox")
    end
end)