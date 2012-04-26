Locales = { }

-- private variables
local defaultLocaleName = 'en-us'
local installedLocales
local currentLocale

-- public functions
function Locales.init()
  installedLocales = {}

  Locales.installLocales('locales')

  local userLocaleName = Settings.get('locale')
  if userLocaleName then
    print('Using configurated locale: ' .. userLocaleName)
    Locales.setLocale(userLocaleName)
  else
    print('Using default locale: ' .. defaultLocaleName)
    Locales.setLocale(defaultLocaleName)
    Settings.set('locale', defaultLocaleName)
  end

  -- add event for creating combobox
  --for key,value in pairs(installedLocales) do
    -- add elements
  --end
end

function Locales.terminate()
  installedLocales = nil
  currentLocale = nil
end

function Locales.installLocale(locale)
  if not locale or not locale.name then
    error('Unable to install locale.')
  end

  local installedLocale = installedLocales[locale.name]
  if installedLocale then
    -- combine translations replacing with new if already exists
    for word,translation in pairs(locale.translation) do
      installedLocale.translation[word] = translation
    end
  else
    installedLocales[locale.name] = locale

    -- update combobox
  end
end

function Locales.installLocales(directory)
  dofiles(directory)
end

function Locales.setLocale(name)
  local locale = installedLocales[name]
  if not locale then
    error("Locale " .. name .. ' does not exist.')
  end
  currentLocale = locale
end

function tr(text, ...)
  if currentLocale then
    if tonumber(text) then
      -- todo: use locale information to calculate this. also detect floating numbers
      local out = ''
      local number = tostring(text):reverse()
      for i=1,#number do
        out = out .. number:sub(i, i)
        if i % 3 == 0 and i ~= #number then
          out = out .. ','
        end
      end
      return out:reverse()
    elseif tostring(text) then
      local translation = currentLocale.translation[text]
      if not translation then
        if currentLocale.name ~= defaultLocaleName then
          warning('Unable to translate: \"' .. text .. '\"')
        end
        translation = text
      end
      return string.format(translation, ...)
    end
  end
  return text
end
