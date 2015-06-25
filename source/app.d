//import elastic_api;
import std.range, std.stdio, std.file;
import std.algorithm;
import std.concurrency;
import std.parallelism;
import std.csv;
import headers;
import filestore;
import std.array,std.conv;



void main() {



    string path = "/home/david/cdrs/";
    string[] files = listdir(path);
    string[] fileDates = getFileDates(files);

    //readfiles(path);
    headers h1;
    foreach(file; files){
        writeln(file);
        auto f1 = f_item!string();    
        File f = File(path~file);
        f1.readFile(f);
        //headers h1;
        auto hash1 = file_hash!string();
        if (f1.data.length < 4){
            continue;
        }
        f1.sliceData(3, f1.data.length-1);
        hash1.hash_data(h1, f1.data);

    }
}



private string[] listdir(string pathname)
{

    return std.file.dirEntries(pathname, SpanMode.shallow)
        .filter!(a => a.isFile)
        .filter!(a=> endsWith(a.name, ".csv"))
        .map!(a => std.path.baseName(a.name))
        .array;
}

string[] getFileDates(string[] files){
    
    string[][string] datemap;  
    string[] dates;
    foreach(string file; files){
        auto split = splitter(file, "-").array;
            dates ~= split[2][0..8];
    }
        dates = dates.uniq.array;
        //dates.each!(a=>datemap[a] = string[]);
        writeln(dates);
    return dates;
}

