Example of usage: 

require './app.rb'

c1 = Carriage.new('cargo', 1)
...
c5 = Carriage.new('cargo', 5)

s1 = Station.new('Station1')
...
s5 = Station.new('Station5')

t1 = Train.new(1, 'cargo', 3)
t2 = Train.new(2, 'pass', 3)
t3 = Train.new(3, 'cargo', 3)

r1 = Route.new('Route1')
r2 = Route.new('Route2')


t1.add_carriage(c1)
t3.add_carriage(c1) # returns error
t2.add_carriage(c2) # returns error
t1.add_carriage(c2)
t1.add_carriage(c3)
t1.add_carriage(c4) # returns error

t1.set_route(r2) # returns error

r1.add_station(s1)
r1.add_station(s2)
r1.add_station(s3, 0) # add first

t1.set_route(r1) # t1.current_station = s3, t1.next_station = s2, t1.prev_station = nil
t1.move_next # t1.current_station = s2, s2.trains=[t1], s1.trains=[]