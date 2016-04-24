import requests
import re
import urllib
import unicodedata
from bs4 import BeautifulSoup


# IMPORTANT: YOU MUST SET THE MONGOLAB_URI IN A FILE CALLED "db.txt" (only the link)
# IT IS NOT INCLUDED HERE FOR SECURITY

from pymongo import MongoClient  # pymongo>=3.2

regex = r"http://scienti\.colciencias\.gov\.co:8081/cvlac/visualizador/generarCurriculoCv\.do\?cod_rh=[0-9]+"
pattern = re.compile(regex)

trimming = r"[ ][ ]+"
trimming = re.compile(trimming)

def normalizeTeacher(teacherName):
    teacherName = teacherName.replace("?", "N");
    teacherName = teacherName.replace("?", "n");
    teacherName = teacherName.decode("utf-8")

    teacherName = unicodedata.normalize('NFKD', teacherName).encode('ASCII', "ignore").upper()
    return teacherName


def getResultsPage(teacherName):

    teacherName = normalizeTeacher(teacherName)
    teacherName = teacherName.replace(" ", "+")

    headers = { 'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}

    finalURL = "http://scienti.colciencias.gov.co:8083/ciencia-war/enRecursoHumanoBusqueda.do"

    payload = {
        "txtNamesRh" : teacherName,
        "nroDocumentoIdent": "",
        "sglPaisNacim" : "" ,
        "nivelFormacion" : "" ,
        "areaFormacion" : "",
        "instFormacion" : "",
        "instProfesion" : "",
        "instActual" :  "",
        "ciuInstAct" : "",
        "paisInstAct" : "",
        "areaActuacion" : "",
        "sectorAplicacion" : "",
        "clave" : "",
        "esPar" : "",
        "parEvaluadoEn" : "",
        "grupos" : "",
        "producto" : "",
        "proyecto" : ""
    }

    r = requests.post(finalURL, headers=headers , data=payload)
    return r.text


def getLinksPage(resultsPage):
    return pattern.findall(resultsPage)


def getTeacherInfo(link,teacherName):
    teacherName = normalizeTeacher(teacherName)

    isTheTeacher = False
    information = ""

    soup = BeautifulSoup(urllib.urlopen(link))

    magic = False
    magic2 = False

    for cell in soup.find_all('td'):

        aux = cell.get_text()
        aux = unicodedata.normalize('NFKD', aux).encode('ASCII', "ignore").upper()
        #aux = trimming.sub("", aux)
        aux = aux.strip()

        if magic:
            if aux == teacherName:
                isTheTeacher = True
            else:
                #print teacherName + " not found, who was found was: " + aux
                break
            magic = False

        if aux == "NOMBRE":
            magic = True

        if aux.startswith("FORMACION ACADEMICA") and not magic2:
            information = aux.strip()
            break

    if isTheTeacher:
        return information
    else:
        return None


DB = open("db.txt","r").readlines()[0]

client = MongoClient(DB,
                     connectTimeoutMS=30000,
                     socketTimeoutMS=None,
                     socketKeepAlive=True)

db = client.get_default_database()



names = open("names.txt","r").readlines()

i = 1000

nFound = 0
nTotal = 0

for name in names:
    nTotal+=1

    found = False

    name = name[0:len(name)-1]
    links = getLinksPage(getResultsPage(name))
    for link in links:
        info = getTeacherInfo(link,name)
        if info != None and info != "":

            db.teacher.update({u"name": name}, {"$set": {u"information": info}})

            #aux = db.teacher.find({u"name":name})
            #for teacher in aux:
            #    print teacher

            nFound+=1
            found = True
            #print name
            #print "\n"
            #print info#re.sub(r"\W\W+", "\n\n", info)##print "["+info+"]"
            break

    if not found:
        db.teacher.update({u"name": name}, {"$set": {u"information": u"Informacion no disponible"}})
        #print name + " wasn't found"
    #print "\n------------------------\n"

    i-=1

    if i==0:
        break

print "Total: "+str(nTotal)+" found: "+str(nFound)





















