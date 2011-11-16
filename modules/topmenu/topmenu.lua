TopMenu = {}

-- private variables
local topMenu

-- public functions
function TopMenu.create()
  topMenu = UI.loadAndDisplay("/topmenu/topmenu.otui")
end

function TopMenu.destroy()
  topMenu:destroy()
  topMenu = nil
end

function TopMenu.getButton(id)
  return topMenu:getChildById(id)
end