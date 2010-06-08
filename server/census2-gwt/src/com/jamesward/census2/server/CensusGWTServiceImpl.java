package com.jamesward.census2.server;

import java.util.ArrayList;
import java.util.List;

import com.jamesward.census2.client.CensusGWTService;
import com.jamesward.census2.shared.CensusEntryVO;
import com.google.gwt.user.server.rpc.RemoteServiceServlet;

/**
 * The server side implementation of the RPC service.
 */
@SuppressWarnings("serial")
public class CensusGWTServiceImpl extends RemoteServiceServlet implements CensusGWTService
{

	@Override
	public CensusEntryVO add(CensusEntryVO data)
	{
		
		return null;
	}

	@Override
	public List<CensusEntryVO> fetch(Integer startRow, Integer endRow, String sortBy)
	{
		ArrayList<CensusEntryVO> entries = new ArrayList<CensusEntryVO>();
		
		if (endRow > 0)
			entries.add(new CensusEntryVO(1, 38, "Private", "1st 2nd 3rd or 4th grade", "Married-civilian spouse present", "White", "Female"));
		if (endRow > 1)
			entries.add(new CensusEntryVO(2, 44, "Self-employed-not incorporated", "Associates degree-occup /vocational", "Married-civilian spouse present", "White", "Female"));
		if (endRow > 2)
			entries.add(new CensusEntryVO(3, 2, "Not in universe", "Children", "Never married", "White", "Male"));

		return entries;
	}

	@Override
	public void remove(CensusEntryVO data)
	{

	}

	@Override
	public CensusEntryVO update(CensusEntryVO data)
	{
		return null;
	}
	
}