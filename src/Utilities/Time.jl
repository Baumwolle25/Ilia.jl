using Dates

mutable struct Time
    timeStarted::Dates.DateTime
    startTime::Dates.DateTime
    endTime::Dates.DateTime
    Time() = new(now(),now(),now())
end

function getTime(t::Time)
    return now() - t.timeStarted
end

function time(t::Time)
    t.startTime = t.endTime
    t.endTime = now()
end

function getDT(t::Time)
    return t.endTime - t.startTime
end