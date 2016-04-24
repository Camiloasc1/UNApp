#!/usr/bin/python

# IMPORTANT: YOU MUST SET THE MONGOLAB_URI IN A FILE CALLED "db.txt" (only the link)
# IT IS NOT INCLUDED HERE FOR SECURITY

from pymongo import MongoClient  # pymongo>=3.2

DB = open("db.txt","r").readlines()[0]

client = MongoClient(DB,
                     connectTimeoutMS=30000,
                     socketTimeoutMS=None,
                     socketKeepAlive=True)

db = client.get_default_database()

iterator = db.teacher.find()

i = 0

for teacher in iterator:
    i+=1
    print teacher#.get(u'name').encode('utf-8')
    #print "http://www.docentes.unal.edu.co/"+teacher.get(u'username').encode('utf-8')+"/"
print i
