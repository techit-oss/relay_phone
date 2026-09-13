Relay.PhoneIdentity = Relay.PhoneIdentity or {}

math.randomseed(os.time() + GetGameTimer())

local function generatePhoneNumber()
    local phoneConfig = RelayConfig.Phone or {}
    local prefix = tostring(phoneConfig.NumberPrefix or '')
    local totalLength = tonumber(phoneConfig.NumberLength) or 7
    local suffixLength = math.max(1, totalLength - #prefix)
    local suffix = {}

    for index = 1, suffixLength do
        suffix[index] = tostring(math.random(0, 9))
    end

    return prefix .. table.concat(suffix)
end

local function getIdentityByIdentifier(identifier)
    return MySQL.single.await([[
        SELECT id, identifier, phone_number, display_name, created_at, updated_at, last_seen_at
        FROM relay_phone_identities
        WHERE identifier = ?
        LIMIT 1
    ]], { identifier })
end

local function touchIdentity(identifier, displayName)
    MySQL.update.await([[
        UPDATE relay_phone_identities
        SET display_name = COALESCE(?, display_name), last_seen_at = CURRENT_TIMESTAMP
        WHERE identifier = ?
    ]], { displayName, identifier })
end

local function createIdentity(identifier, displayName)
    local maxAttempts = RelayConfig.Phone.AssignmentMaxAttempts or 25

    for _ = 1, maxAttempts do
        local phoneNumber = generatePhoneNumber()
        local success, insertId = pcall(function()
            return MySQL.insert.await([[
                INSERT INTO relay_phone_identities (identifier, phone_number, display_name, last_seen_at)
                VALUES (?, ?, ?, CURRENT_TIMESTAMP)
            ]], { identifier, phoneNumber, displayName })
        end)

        if success and insertId then
            return getIdentityByIdentifier(identifier)
        end
    end

    return nil
end

function Relay.PhoneIdentity.GetOrCreateForSource(source)
    if type(source) ~= 'number' or source <= 0 then
        return nil, 'invalid_source'
    end

    local identifier = Relay.ServerBridge.GetIdentifier(source)

    if not identifier or identifier == '' then
        return nil, 'identifier_unavailable'
    end

    local displayName = Relay.ServerBridge.GetCharacterName(source)
    local identity = getIdentityByIdentifier(identifier)

    if identity then
        touchIdentity(identifier, displayName)
        identity.display_name = displayName
        return identity
    end

    return createIdentity(identifier, displayName)
end

function Relay.PhoneIdentity.GetBootstrapForSource(source)
    local identity, errorCode = Relay.PhoneIdentity.GetOrCreateForSource(source)

    if not identity then
        return {
            ok = false,
            error = errorCode or 'identity_unavailable'
        }
    end

    return {
        ok = true,
        data = {
            identity = {
                phoneNumber = identity.phone_number,
                displayName = identity.display_name
            },
            framework = Relay.ServerBridge.name,
            apps = RelayConfig.Apps
        }
    }
end
