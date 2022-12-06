require 'pp'

datastream = ARGF.readline(chomp: true)

i = 0
marker = []

while marker.length < 14 do
    if marker.include?(datastream[i])
        marker.shift(marker.index(datastream[i]) + 1) 
    end
    
    marker << datastream[i]
    i += 1
end

pp marker.join
pp i