function Format(Int : number)
	return string.format("%02i", Int)
end

local Utils = {}

local prefixes = {
    "","k","M","B","T","qd","Qn","Sx","Sp","Oc","N"
}

function Utils:tableToString(data : table)
    local result = ""
        for i, value in pairs(data) do
            result = result .. value
            if i < #data then
                result = result .. "\n" -- Добавляем символ новой строки, кроме последнего элемента
            end
        end
        return result
end

function Utils:FormatTime(Seconds : number)
    local Minutes = (Seconds - Seconds%60)/60
    Seconds = Seconds - Minutes*60
    local Hours = (Minutes - Minutes%60)/60
    Minutes = Minutes - Hours*60
    
    local Days = (Hours - Hours%24)/24
    Hours = Hours - Days*24
    
    if Days > 0 and Hours > 0 and Minutes > 0 then
        return Format(Days)..":"..Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
    elseif Days <= 0 and Hours > 0 and Minutes > 0 then
        return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
    elseif Days <= 0 and Hours <= 0 and Minutes > 0 then
        return Format(Minutes)..":"..Format(Seconds)
    else
        return Format(Minutes)..":"..Format(Seconds)
    end
end

function Utils:Addprefixes(Num : number)
    for i = 1, #prefixes do
        if Num < 10 ^ (i * 3) then
            return math.floor(Num / ((10 ^ ((i - 1) * 3)) / 100)) / (100) .. prefixes[i]
        end
    end
end

function Utils:CommaNumber(Num : number)
    Num = tostring(Num)
    return Num:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end



return Utils