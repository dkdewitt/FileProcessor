module elastic_api;

import std.stdio;
import elasticsearch.api.actions.base;
import elasticsearch.api.actions.indices;
import elasticsearch.client;
import elasticsearch.parameters;
import std.algorithm;


void search(){
        //create();
        auto client = new Client(Host());
        Parameters searchParams;
        searchParams["body"] = "<elasticsearch query>";
        searchParams["index"] = "es_test_index";
}

void insert( Json record, string index){
    auto client = new Client(Host());
    client.index(index, "cdr",  record.toString());

}

//{"index":{"_index":"bulk_test", "_type":"products"}}
 //{ "Title":"Product 3", "Description":"Product 1 Description", "Size":"Small", "Location":[{"url":"website.com", "price":"9.99", "anchor":"Prodcut 1"}],"Images":[{ "url":"product1.jpg"}],"Slug":"prodcut1"}
//{"index":{"_index":"bulk_test", "_type":"products"}}
 //{ "Title":"Product 2", "Description":"Product 1 Description", "Size":"Small", "Location":[{"url":"website.com", "price":"9.99", "anchor":"Prodcut 1"}],"Images":[{ "url":"product1.jpg"}],"Slug":"prodcut1"}

void bulkinsert( ){
    auto client = new Client(Host());
    auto tst2 = Json.emptyArray;
    Json[] tx;
    auto item = Json.emptyObject;
    item["test"] = "TestValue";
    tx ~= item;
    auto item2 = Json.emptyObject;
    item2["XYU"] = "1234";
    tx ~= item2;
    tst2 ~= item;
    writeln(tst2.toString);
    string record = "{\"index\":{\"_index\":\"bulk_test\", \"_type\":\"cdr\"}}
{\"Title\":\"Product 1\"}";
    client.bulkIndex("bulk_test", "cdr",  record);
    
    
    writeln(tx);
}


void createIndexes(const string[] dates){

  foreach(date; dates){

      auto client = new Client(Host());

      Parameters p;

      //string indexName = ""
      p.addField("index", date);
      p.addField("body", `
          { 
              "settings": {
                 "index": {
                   "number_of_shards": 1,
                   "number_of_replicas": 0,
                 },
               },
               "mappings": {
                 "cdr": {
                   "properties": {
                     "name": { "type": "string"}
                   }
                 }
               }          
          }
      `);
      client.createIndex(p);
    }

}


void create(){
    // The host structure defaults to connecting to localhost

    auto client = new Client(Host());

    Parameters p;
    p.addField("index", "bulk_test");
    p.addField("body", `
        { 
            "settings": {
               "index": {
                 "number_of_shards": 1,
                 "number_of_replicas": 0,
               },
             },
             "mappings": {
               "cdr": {
                 "properties": {
                   "name": { "type": "string"}
                 }
               }
             }          
        }
    `);


    client.createIndex(p);

}