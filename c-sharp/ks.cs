// mcs ks.cs && mono ks.exe
using System;
public class HelloWorld {
    static public void Main () {
        DateTime dt = DateTime.Now;
        Console.WriteLine ( Math.Round(
        (decimal)((dt.Hour * 3600 + dt.Minute * 60 + dt.Second)/1000.0),
        3).ToString());
    }
}

