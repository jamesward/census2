package com.jamesward.census2;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

public class CensusResultService
{

    // return the average results for a test
    public Hashtable<String, Integer> getAverageResults(String testId, Boolean gzip, Integer numRows)
    {
        Hashtable<String, ArrayList<Integer>> allResults = new Hashtable<String, ArrayList<Integer>>();

        CensusResult searchCensusResult = new CensusResult();
        searchCensusResult.setTestId(testId);
        searchCensusResult.setNumRows(numRows);
        searchCensusResult.setGzip(gzip);

        // find like searchCensusResult
        
        List<CensusResult> results = CensusResultDAO.findSimilar(searchCensusResult);

        for (CensusResult result : results)
        {
            if (allResults.get(result.getResultType()) == null)
            {
                allResults.put(result.getResultType(), new ArrayList<Integer>());
            }

            if ((result.getResultData() != null) && (result.getResultData() != -1))
            {
                allResults.get(result.getResultType()).add(result.getResultData());
            }
        }

        Hashtable<String, Integer> averageResults = new Hashtable<String, Integer>();

        Iterator<String> keys = allResults.keySet().iterator();

        while (keys.hasNext())
        {
            long total = 0;
            String resultType = keys.next();
            ArrayList<Integer> r = allResults.get(resultType);
            for (int i = 0; i < r.size(); i++)
            {
                total += r.get(i);
            }

            Integer averageValue = 0;

            if (r.size() > 0)
            {
                averageValue = new Long(total / r.size()).intValue();
            }

            averageResults.put(resultType, averageValue);
        }

        return averageResults;
    }

    //get the results for each unique entry and assemble everything into a single hashmap like:
    // {ip: 123.123.123.123; testId: flex_amf; gzip: true; numRows: 5000; transferTime: 4321; parseTime: 321 ...}
    public List<Hashtable<String, Object>> getAllResults()
    {
        ArrayList<Hashtable<String, Object>> allResults = new ArrayList<Hashtable<String, Object>>();
        
        List<CensusResult> allCensusResults = CensusResultDAO.findAll();

        Hashtable<CensusResult, List<CensusResult>> groupedResults = new Hashtable<CensusResult, List<CensusResult>>();

        // group the rows together into items that have a common ip, testId, gzip, and numRows
        for (CensusResult result : allCensusResults)
        {
            CensusResult key = new CensusResult();
            key.setIpAddress(result.getIpAddress());
            key.setTestId(result.getTestId());
            key.setGzip(result.getGzip());
            key.setNumRows(result.getNumRows());

            List<CensusResult> r = groupedResults.get(key);
            if (r == null)
            {
                r = new ArrayList<CensusResult>();
                groupedResults.put(key, r);
            }

            r.add(result);
        }


        // expand out the grouped items into an object per grouped item

        Iterator<CensusResult> keys = groupedResults.keySet().iterator();

        while (keys.hasNext())
        {
            CensusResult r = keys.next();

            Hashtable<String, Object> item = new Hashtable<String, Object>();

            item.put("ipAddress", r.getIpAddress());
            item.put("testId", r.getTestId());
            item.put("gzip", r.getGzip());
            item.put("numRows", r.getNumRows());

            List<CensusResult> ra = groupedResults.get(r);
            Iterator <CensusResult> rai = ra.iterator();

            while (rai.hasNext())
            {
                CensusResult cr = rai.next();
                item.put(cr.getResultType(), cr.getResultData());
                item.put("createDate", cr.getCreateDate());
            }

            allResults.add(item);
        }

        return allResults;
    }

    public List<CensusResult> getAllRawResults()
    {
        List<CensusResult> allRawResults = CensusResultDAO.findAll();

        return allRawResults;
    }

    public void deleteResult(String ipAddress, String testId, Boolean gzip, Integer numRows)
    {
        CensusResult searchCensusResult = new CensusResult(ipAddress, testId, null, null, gzip, numRows);
        CensusResultDAO.deleteSimilar(searchCensusResult);
    }

}