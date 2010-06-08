package com.jamesward.census2.client;

import java.util.Date;

import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.user.client.Window.Location;
import com.smartgwt.client.types.FetchMode;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridField;
import com.smartgwt.client.widgets.grid.events.DrawAreaChangedEvent;
import com.smartgwt.client.widgets.grid.events.DrawAreaChangedHandler;

public class Census2_gwt implements EntryPoint
{
	public static final String TESTID = "smartgwt_rpc";
	
	//public static Date startRenderTime;
	public static Date endRenderTime;
	
	public void onModuleLoad()
	{
		final ListGrid censusGrid = new ListGrid();
		
		censusGrid.setDataSource(CensusDataSource.getInstance());
		censusGrid.setWidth100();
		censusGrid.setHeight100();

		ListGridField idField = new ListGridField("id", "id");
		ListGridField ageField = new ListGridField("age", "age");
		ListGridField classOfWorkerField = new ListGridField("classOfWorker", "classOfWorker");
		ListGridField educationField = new ListGridField("education", "education");
		ListGridField maritalStatusField = new ListGridField("maritalStatus", "maritalStatus");
		ListGridField raceField = new ListGridField("race", "race");
		ListGridField sexField = new ListGridField("sex", "sex");
		censusGrid.setFields(idField, ageField, classOfWorkerField, educationField, maritalStatusField, raceField, sexField);

		censusGrid.setAutoFetchData(false);
		censusGrid.setDataFetchMode(FetchMode.BASIC); // sets server-side paging and sorting
		
		CensusDataSource.getInstance().numRows = new Integer(Location.getParameter("numRows"));
		CensusDataSource.getInstance().clientId = Location.getParameter("clientId");
		CensusDataSource.getInstance().sendCensusResultURL = Location.getParameter("sendCensusResultURL");
		CensusDataSource.getInstance().gzip = false;
		
		if ((Location.getParameter("enableGZip") != null) && (Location.getParameter("enableGZip").equals("true")))
		{
			CensusDataSource.getInstance().gzip = true;
		}

		censusGrid.fetchData();
		
		censusGrid.draw();
		
		censusGrid.addDrawAreaChangedHandler(new DrawAreaChangedHandler() {
			@Override
			public void onDrawAreaChanged(DrawAreaChangedEvent event) {
				if (endRenderTime == null)
				{
					endRenderTime = new Date();
					
					SendCensusResult.sendResult(CensusDataSource.getInstance().sendCensusResultURL,
							CensusDataSource.getInstance().clientId,
							TESTID,
							"renderTime",
							endRenderTime.getTime() - CensusDataSource.getInstance().startRenderTime.getTime(),
							CensusDataSource.getInstance().gzip,
							CensusDataSource.getInstance().numRows);
				}
			}
		});
		
	}
}