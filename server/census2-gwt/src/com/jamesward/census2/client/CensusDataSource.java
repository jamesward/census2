package com.jamesward.census2.client;

import java.util.ArrayList;
import java.util.List;

import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.Window.Location;
import com.google.gwt.user.client.rpc.ServiceDefTarget;
import com.jamesward.census2.shared.CensusEntryVO;
import com.smartgwt.client.data.DataSourceField;
import com.smartgwt.client.data.fields.DataSourceIntegerField;
import com.smartgwt.client.data.fields.DataSourceTextField;
import com.smartgwt.client.widgets.grid.ListGridRecord;

public class CensusDataSource extends GenericGwtRpcDataSource<CensusEntryVO, ListGridRecord, CensusGWTServiceAsync>
{

	private static CensusDataSource instance;
	
	// forces to use the singleton through getInstance();
	private CensusDataSource() {};
	
	public static CensusDataSource getInstance() {
		if (instance == null) {
			instance = new CensusDataSource();
		}
		return (instance);
	}
	
	@Override
	public void copyValues(ListGridRecord from, CensusEntryVO to) {
		to.setId(from.getAttributeAsInt("id"));
		to.setAge(from.getAttributeAsInt("age"));
		to.setClassOfWorker(from.getAttributeAsString("classOfWorker"));
		to.setEducation(from.getAttributeAsString("education"));
		to.setMaritalStatus(from.getAttributeAsString("maritalStatus"));
		to.setRace(from.getAttributeAsString("race"));
		to.setSex(from.getAttributeAsString("sex"));
	}

	@Override
	public void copyValues(CensusEntryVO from, ListGridRecord to) {
		to.setAttribute("id", from.getId());
		to.setAttribute("age", from.getAge());
		to.setAttribute("classOfWorker", from.getClassOfWorker());
		to.setAttribute("education", from.getEducation());
		to.setAttribute("maritalStatus", from.getMaritalStatus());
		to.setAttribute("race", from.getRace());
		to.setAttribute("sex", from.getSex());
	}

	@Override
	public List<DataSourceField> getDataSourceFields()
	{
		
		List<DataSourceField> fields = new ArrayList<DataSourceField>();
		
        DataSourceIntegerField idField = new DataSourceIntegerField("id"); 
        idField.setPrimaryKey(true);
        fields.add(idField);
  
        DataSourceIntegerField ageField = new DataSourceIntegerField("age"); 
        fields.add(ageField);

        DataSourceTextField classOfWorkerField = new DataSourceTextField("classOfWorker", "classOfWorker");  
        fields.add(classOfWorkerField);
        
        DataSourceTextField educationField = new DataSourceTextField("education", "education");  
        fields.add(educationField);
        
        DataSourceTextField maritalStatusField = new DataSourceTextField("maritalStatus", "maritalStatus");  
        fields.add(maritalStatusField);
        
        DataSourceTextField raceField = new DataSourceTextField("race", "race");  
        fields.add(raceField);
        
        DataSourceTextField sexField = new DataSourceTextField("sex", "sex");  
        fields.add(sexField);
  
		return fields;
	}

	@Override
	public CensusEntryVO getNewDataObjectInstance() {
		return new CensusEntryVO();
	}

	@Override
	public ListGridRecord getNewRecordInstance() {
		return new ListGridRecord();
	}

	@Override
	public CensusGWTServiceAsync getServiceAsync() {
		return GWT.create(CensusGWTService.class);
	}

	
}