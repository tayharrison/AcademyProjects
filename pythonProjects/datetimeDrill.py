# datetime drill

from datetime import datetime


portland = datetime.now()
#print portland
portland_hour = portland.hour
#print 'p-hour is ',  portland_hour

eastern_hour = portland_hour + 3
#print 'e_hr is ', eastern_hour

if eastern_hour >= 24:
    eastern_hour -= 24
#print 'e_hr is ', eastern_hour

if eastern_hour >= 9 and eastern_hour <= 21:
    print "NYC Branch is open"
else: print "NYC Branch is closed"


london_hour = portland_hour + 9
#print 'l hr is ', london_hour

if london_hour >= 24:
    london_hour -= 24
#print 'l- hr is ', london_hour
if london_hour >= 9 and london_hour <= 21:
    print "London Branch is open"
else: print "London Branch is closed"
