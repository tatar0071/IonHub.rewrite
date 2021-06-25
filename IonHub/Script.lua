local a = game.GameId
local b = {595270616, 1686265127}

function c(d)
  loadstring(game:HttpGet("https://raw.githubusercontent.com/tatar0071/IonHub.rewrite/main/IonHub/"..d..".lua"))()
end

if a == b[1] then
  c("SoA")
elseif a == b[2] then
  c("QuarantineZ")
else
  c("Universal")
end
