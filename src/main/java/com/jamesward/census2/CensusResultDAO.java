package com.jamesward.census2;

import com.mongodb.DB;
import com.mongodb.Mongo;
import com.mongodb.MongoURI;

import java.net.UnknownHostException;

public class CensusResultDAO {

    
    
    protected DB db() throws UnknownHostException {
        DB db = null;
        
        if (System.getenv("MONGOLAB_URI") != null) {
            MongoURI mongoURI = new MongoURI(System.getenv("MONGOLAB_URI"));
            Mongo mongo = new Mongo(mongoURI);
            db = mongo.getDB(mongoURI.getDatabase());
            db.authenticate(mongoURI.getUsername(), mongoURI.getPassword());
        }
        else {
            Mongo mongo = new Mongo("localhost");
            db = mongo.getDB("census2");
        }
        
        return db;
    }
}
