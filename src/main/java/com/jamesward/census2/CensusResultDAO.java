package com.jamesward.census2;

import com.mongodb.DB;
import com.mongodb.Mongo;
import com.mongodb.MongoURI;
import net.vz.mongodb.jackson.DBCursor;
import net.vz.mongodb.jackson.JacksonDBCollection;

import java.net.UnknownHostException;
import java.util.List;

public class CensusResultDAO {

    private CensusResultDAO() {
        
    }
    
    private static DB db = null;
    
    protected static DB db() {
        if (db == null) {
            try {
                if (System.getenv("MONGOLAB_URI") != null) {
                    MongoURI mongoURI = new MongoURI(System.getenv("MONGOLAB_URI"));
                    Mongo mongo = new Mongo(mongoURI);
                    db = mongo.getDB(mongoURI.getDatabase());
                    db.authenticate(mongoURI.getUsername(), mongoURI.getPassword());
                }
                else {
                    Mongo mongo = new Mongo("127.0.0.1");
                    db = mongo.getDB("census2");
                }
            }
            catch (UnknownHostException exception) {
                throw new RuntimeException(exception);
            }
        }
        
        return db;
    }
    
    public static void init() {
        db();
    }
    
    protected static JacksonDBCollection<CensusResult, String> collection() {
        JacksonDBCollection<CensusResult, String> collection = JacksonDBCollection.wrap(db().getCollection("censusresults"), CensusResult.class, String.class);
        return collection;
    }

    public static void deleteSimilar(CensusResult searchCensusResult) {
        collection().remove(searchCensusResult);
        //DBCursor<CensusResult> results = collection().find(searchCensusResult);
        //while (results.hasNext()) {
        //    results.next()
        //}
    }
    
    public static List<CensusResult> findSimilar(CensusResult searchCensusResult) {
        return collection().find(searchCensusResult).toArray();
    }

    public static void add(CensusResult newCensusResult) {
        collection().insert(newCensusResult);
    }

    public static List<CensusResult> findAll() {
        return collection().find().toArray();
    }
}
