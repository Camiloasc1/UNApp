package unapp

class Votes {

    int value //0,1 dependiendo si es negativo o positivo
    //User author
    //Comment comment

    static belongsTo = [author: User,comment: Comment]

}