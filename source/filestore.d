
module filestore;
import std.stdio;
import std.range, std.algorithm, std.array;
import headers;


struct FileStore
{
    string[] fileNames;

    this(string[] fileNames){
        fileNames=fileNames;
    }

    void addFile(string fileName){
        fileNames~=fileName;
    }
}

struct f_item(T){
    
    T[] data;
    void readFile(File dataIn){
        char[] tempBuf;
        import std.string, std.conv;
        foreach (ubyte[] buffer; chunks(dataIn, 8092))
        {

            char[] x = cast(char[]) buffer;
            tempBuf ~= x;
            
        }
        string[] lines = splitLines(to!string(tempBuf));
            
        data = data ~= lines;
    }

    void insertData(T[] newData){
       data =  data ~ newData;
    }

    void sliceData( size_t begin, size_t end){
        data = data[begin..end];
    }

    T opIndex(in size_t t1)
    {
        return data[t1];
    }

}


struct file_hash(T)
{
    T[T][] d;

    void hash_data(headers h1,string[] data){

        foreach(line; data){
            auto lineArray = splitter(line, ",").array;
            auto dict = zip(h1.fullHeader,lineArray).
                filter!(a=>h1.filteredHeader.canFind(a[0])).assocArray;
           

            d ~= dict;

        }

    }

    T[T][] getData(){
        return d;
    }
}






