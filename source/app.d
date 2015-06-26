import elastic_api;
import std.range, std.stdio, std.file;
import std.algorithm;
import std.concurrency;
import std.parallelism;
import std.csv;
import headers;
import filestore;
import std.array,std.conv;
import elasticsearch.client;


void main() {



    string path = "/Users/david/Documents/cdr/single/";
    //20150507-20150610/";
    string[] files = listdir(path);
    string[] fileDates = getFileDates(files);
    bulkinsert();
    /*createIndexes(fileDates);
    headers h1;
    foreach (file; parallel(files)){
        auto fileDate = splitter(file, "-").array()[2][0..8];
            
        writeln(file);
        auto f1 = f_item!string();    
        File f = File(path~file);
        f1.readFile(f);
        auto hash1 = file_hash!string();
        if (f1.data.length < 4){
            continue;
        }
        f1.sliceData(3, f1.data.length-1);
        hash1.hash_data(h1, f1.data);
        auto data = hash1.getData(); 
        insertRecs(data,fileDate);
    }*/
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

void insertRecs(T)(T[T][] data, string date){
            auto items = Json.emptyArray;
            foreach(rec;data){
                //writeln(cdr);
            auto item = Json.emptyObject;
            //foreach(r; rec.byPair()){
            //    writeln(r);
                //item[r.key] = r.value;
            //}
            each!((k)=> item[k.key] = k.value)(rec.byKeyValue());

            items ~= item;

            //writeln(items);
            insert(items, date);
        }
}

