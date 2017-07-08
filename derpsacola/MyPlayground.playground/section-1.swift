// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

//println(String(count: 5, repeatedValue: "asdf"))


//String(count:5, repeatedValue:"*sdf")


//"".join(Array(count: n, repeatedValue: self))

func *(left: String, right: Int) -> String {
    return "".join(Array(count: right, repeatedValue: left))
}


"hello"*4