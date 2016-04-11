package unapp

class Votes {

    int value //0,1 dependiendo si es negativo o positivo

    static belongsTo = [author: User,comment: Comment]
}